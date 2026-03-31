import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/provider/settings_provider.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final caregiverCloudRepositoryProvider = Provider<CaregiverCloudRepository>((
    ref,
    ) {
  return CaregiverCloudRepository(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
  );
});

// 🔥 НОВАЯ МОДЕЛЬ: "Слепок" дозы для передачи опекуну
class CaregiverSharedDose {
  final String id;
  final String medicineName;
  final DateTime scheduledTime;
  final String status; // pending, taken, skipped
  final double dosage;
  final String unit;
  final String kind;

  const CaregiverSharedDose({
    required this.id,
    required this.medicineName,
    required this.scheduledTime,
    required this.status,
    required this.dosage,
    required this.unit,
    required this.kind,
  });

  factory CaregiverSharedDose.fromFirestore(Map<String, dynamic> data) {
    return CaregiverSharedDose(
      id: data['id'] as String? ?? '',
      medicineName: data['medicineName'] as String? ?? 'Unknown',
      scheduledTime: DateTime.tryParse(data['scheduledTime'] as String? ?? '') ?? DateTime.now(),
      status: data['status'] as String? ?? 'pending',
      dosage: (data['dosage'] as num?)?.toDouble() ?? 0.0,
      unit: data['unit'] as String? ?? '',
      kind: data['kind'] as String? ?? 'medication',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'medicineName': medicineName,
    'scheduledTime': scheduledTime.toIso8601String(),
    'status': status,
    'dosage': dosage,
    'unit': unit,
    'kind': kind,
  };
}

class CaregiverCloudAlert {
  final String id;
  final String shareCode;
  final String message;
  final String patientName;
  final int itemCount;
  final DateTime createdAt;
  final bool seen;

  const CaregiverCloudAlert({
    required this.id,
    required this.shareCode,
    required this.message,
    required this.patientName,
    required this.itemCount,
    required this.createdAt,
    required this.seen,
  });

  factory CaregiverCloudAlert.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc,
      String shareCode,
      ) {
    final data = doc.data();
    return CaregiverCloudAlert(
      id: doc.id,
      shareCode: shareCode,
      message: data['message'] as String? ?? '',
      patientName: data['patientName'] as String? ?? '',
      itemCount: data['itemCount'] as int? ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      seen: data['seen'] as bool? ?? false,
    );
  }
}

class CaregiverNetworkRecord {
  final String shareCode;
  final String patientName;
  final String caregiverName;
  final String caregiverPhone;

  const CaregiverNetworkRecord({
    required this.shareCode,
    required this.patientName,
    required this.caregiverName,
    required this.caregiverPhone,
  });

  factory CaregiverNetworkRecord.fromFirestore(
      String shareCode,
      Map<String, dynamic> data,
      ) {
    final caregiver = data['caregiver'] as Map<String, dynamic>? ?? const {};
    return CaregiverNetworkRecord(
      shareCode: shareCode,
      patientName: data['patientName'] as String? ?? '',
      caregiverName: caregiver['name'] as String? ?? '',
      caregiverPhone: caregiver['phone'] as String? ?? '',
    );
  }
}

class CaregiverCloudRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const CaregiverCloudRepository({required this.auth, required this.firestore});

  Future<User> ensureSignedIn() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      return currentUser;
    }
    final credential = await auth.signInAnonymously();
    return credential.user!;
  }

  Future<void> upsertPatientNetwork({
    required String shareCode,
    required String patientName,
    required CaregiverProfile? caregiver,
    String? fcmToken,
  }) async {
    final user = await ensureSignedIn();
    final networkRef = firestore.collection('care_networks').doc(shareCode);
    final caregiverMap = caregiver == null
        ? null
        : {
      'name': caregiver.name,
      'relation': caregiver.relation,
      'phone': caregiver.phone,
      'shareReports': caregiver.shareReports,
    };

    await networkRef.set({
      'shareCode': shareCode,
      'patientUid': user.uid,
      'patientName': patientName,
      'caregiver': caregiverMap,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await networkRef.collection('members').doc(user.uid).set({
      'uid': user.uid,
      'role': 'patient',
      'displayName': patientName,
      'fcmToken': fcmToken,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<CaregiverNetworkRecord?> connectAsCaregiver({
    required String shareCode,
    required String deviceName,
    String? fcmToken,
  }) async {
    final user = await ensureSignedIn();
    final networkRef = firestore.collection('care_networks').doc(shareCode);
    final snapshot = await networkRef.get();
    if (!snapshot.exists) {
      return null;
    }
    if ((snapshot.data()?['patientUid'] as String?) == user.uid) {
      return null;
    }

    await networkRef.collection('members').doc(user.uid).set({
      'uid': user.uid,
      'role': 'caregiver',
      'displayName': deviceName,
      'fcmToken': fcmToken,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return CaregiverNetworkRecord.fromFirestore(shareCode, snapshot.data()!);
  }

  Future<void> enqueueAlert({
    required String shareCode,
    required String alertId,
    required String patientName,
    required String message,
    required int itemCount,
  }) async {
    await ensureSignedIn();
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('alerts')
        .doc(alertId)
        .set({
      'patientName': patientName,
      'message': message,
      'itemCount': itemCount,
      'seen': false,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeCurrentMember(String shareCode) async {
    final user = await ensureSignedIn();
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('members')
        .doc(user.uid)
        .delete();
  }

  Future<void> clearCurrentMemberToken(String shareCode) async {
    final user = await ensureSignedIn();
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('members')
        .doc(user.uid)
        .set({
      'uid': user.uid,
      'fcmToken': null,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<List<CaregiverCloudAlert>> watchAlerts(String shareCode) {
    return firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('alerts')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => CaregiverCloudAlert.fromFirestore(doc, shareCode))
          .where((alert) => !alert.seen)
          .toList(),
    );
  }

  Future<void> markAlertSeen({
    required String shareCode,
    required String alertId,
  }) async {
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('alerts')
        .doc(alertId)
        .set({'seen': true}, SetOptions(merge: true));
  }

  Future<void> updateCurrentMemberToken({
    required String shareCode,
    required String role,
    required String displayName,
    required String? fcmToken,
  }) async {
    final user = await ensureSignedIn();
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('members')
        .doc(user.uid)
        .set({
      'uid': user.uid,
      'role': role,
      'displayName': displayName,
      'fcmToken': fcmToken,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // 🚀 НОВОЕ: Отправка расписания (вызывается пациентом)
  Future<void> syncTodaySchedule({
    required String shareCode,
    required String dateString, // Формат: 'yyyy-MM-dd'
    required List<CaregiverSharedDose> doses,
  }) async {
    await ensureSignedIn();
    await firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('daily_schedules')
        .doc(dateString)
        .set({
      'updatedAt': FieldValue.serverTimestamp(),
      'items': doses.map((d) => d.toJson()).toList(),
    }, SetOptions(merge: true));
  }

  // 🚀 НОВОЕ: Прослушивание расписания (вызывается опекуном)
  Stream<List<CaregiverSharedDose>> watchTodaySchedule({
    required String shareCode,
    required String dateString,
  }) {
    return firestore
        .collection('care_networks')
        .doc(shareCode)
        .collection('daily_schedules')
        .doc(dateString)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return [];

      final data = snapshot.data()!;
      final itemsList = data['items'] as List<dynamic>? ?? [];

      return itemsList
          .map((item) => CaregiverSharedDose.fromFirestore(item as Map<String, dynamic>))
          .toList();
    });
  }
}