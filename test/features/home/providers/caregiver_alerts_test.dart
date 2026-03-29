import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/core/utils/caregiver_alert_service.dart';
import 'package:neo_pill/data/local/entities/dose_log_entity.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';
import 'package:neo_pill/features/home/providers/home_provider.dart';
import 'package:neo_pill/features/settings/provider/settings_provider.dart';
import 'package:neo_pill/l10n/app_localizations_en.dart';

void main() {
  group('buildCaregiverAlertSummary', () {
    test('returns null when selected day is not today', () {
      final now = DateTime(2026, 3, 28, 10, 0);
      final summary = buildCaregiverAlertSummary(
        items: [
          _scheduleItem(
            medicineName: 'Metformin',
            scheduledTime: now.subtract(const Duration(hours: 2)),
          ),
        ],
        caregiver: _caregiver(),
        settings: CaregiverAlertSettings.defaults(),
        selectedDate: now.subtract(const Duration(days: 1)),
        now: now,
      );

      expect(summary, isNull);
    });

    test(
      'includes overdue and skipped medications, but excludes supplements by default',
      () {
        final now = DateTime(2026, 3, 28, 10, 0);
        final summary = buildCaregiverAlertSummary(
          items: [
            _scheduleItem(
              medicineName: 'Metformin',
              scheduledTime: now.subtract(const Duration(hours: 2)),
              kind: CourseKindEnum.medication,
            ),
            _scheduleItem(
              medicineName: 'Aspirin',
              scheduledTime: now.subtract(const Duration(hours: 1)),
              status: DoseStatusEnum.skipped,
              kind: CourseKindEnum.medication,
            ),
            _scheduleItem(
              medicineName: 'Magnesium',
              scheduledTime: now.subtract(const Duration(hours: 2)),
              kind: CourseKindEnum.supplement,
            ),
          ],
          caregiver: _caregiver(),
          settings: CaregiverAlertSettings.defaults(),
          selectedDate: DateTime(now.year, now.month, now.day),
          now: now,
        );

        expect(summary, isNotNull);
        expect(summary!.totalCount, 2);
        expect(summary.overdueCount, 1);
        expect(summary.skippedCount, 1);
        expect(
          summary.items.any((item) => item.item.medicine?.name == 'Magnesium'),
          isFalse,
        );
      },
    );

    test('can include supplements when enabled', () {
      final now = DateTime(2026, 3, 28, 10, 0);
      final summary = buildCaregiverAlertSummary(
        items: [
          _scheduleItem(
            medicineName: 'Magnesium',
            scheduledTime: now.subtract(const Duration(hours: 2)),
            kind: CourseKindEnum.supplement,
          ),
        ],
        caregiver: _caregiver(),
        settings: CaregiverAlertSettings.defaults().copyWith(
          includeSupplements: true,
        ),
        selectedDate: DateTime(now.year, now.month, now.day),
        now: now,
      );

      expect(summary, isNotNull);
      expect(summary!.totalCount, 1);
      expect(summary.items.single.item.medicine?.name, 'Magnesium');
    });
  });

  group('CaregiverAlertService', () {
    test('builds a ready caregiver message', () {
      final l10n = AppLocalizationsEn();
      final now = DateTime(2026, 3, 28, 10, 0);
      final summary = buildCaregiverAlertSummary(
        items: [
          _scheduleItem(
            medicineName: 'Metformin',
            scheduledTime: now.subtract(const Duration(hours: 2)),
            kind: CourseKindEnum.medication,
          ),
          _scheduleItem(
            medicineName: 'Aspirin',
            scheduledTime: now.subtract(const Duration(hours: 1)),
            status: DoseStatusEnum.skipped,
            kind: CourseKindEnum.medication,
          ),
        ],
        caregiver: _caregiver(),
        settings: CaregiverAlertSettings.defaults(),
        selectedDate: DateTime(now.year, now.month, now.day),
        now: now,
      )!;

      final message = CaregiverAlertService.buildAlertMessage(
        l10n: l10n,
        patientName: 'Alex',
        caregiver: summary.caregiver,
        summary: summary,
        localeCode: 'en',
      );

      expect(message, contains('Hello, Anna.'));
      expect(message, contains('Metformin'));
      expect(message, contains('Aspirin'));
      expect(message, contains('Please check in if support is needed.'));
    });
  });
}

CaregiverProfile _caregiver() => const CaregiverProfile(
  name: 'Anna',
  relation: 'Daughter',
  phone: '+77001234567',
  shareReports: true,
);

DoseScheduleItem _scheduleItem({
  required String medicineName,
  required DateTime scheduledTime,
  DoseStatusEnum status = DoseStatusEnum.pending,
  CourseKindEnum kind = CourseKindEnum.medication,
}) {
  final medicine = MedicineEntity()
    ..syncId = medicineName
    ..name = medicineName
    ..dosage = 1
    ..dosageUnit = 'mg'
    ..form = MedicineFormEnum.pill
    ..frequency = FrequencyTypeEnum.daily
    ..kind = kind
    ..timesPerDay = 1
    ..startDate = scheduledTime
    ..pillsInPackage = 30
    ..pillsRemaining = 20;

  final log = DoseLogEntity()
    ..syncId = '${medicineName}_${scheduledTime.toIso8601String()}'
    ..medicineSyncId = medicine.syncId
    ..scheduledTime = scheduledTime
    ..status = status
    ..dosage = 1;

  return DoseScheduleItem(doseLog: log, medicine: medicine);
}
