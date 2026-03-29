import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM background message: ${message.messageId}');
}

class FirebaseMessagingService {
  final FirebaseMessaging messaging;

  const FirebaseMessagingService(this.messaging);

  Future<void> init() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    await messaging.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<String?> getToken() => messaging.getToken();

  Stream<String> get onTokenRefresh => messaging.onTokenRefresh;

  Stream<RemoteMessage> get onForegroundMessage => FirebaseMessaging.onMessage;
}

final firebaseMessagingServiceProvider = Provider<FirebaseMessagingService>((
  ref,
) {
  return FirebaseMessagingService(ref.read(firebaseMessagingProvider));
});

final firebaseForegroundMessagesProvider = StreamProvider<List<RemoteMessage>>((
  ref,
) async* {
  await for (final message
      in ref.read(firebaseMessagingServiceProvider).onForegroundMessage) {
    yield [message];
  }
});
