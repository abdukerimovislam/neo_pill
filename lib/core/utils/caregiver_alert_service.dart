import 'package:intl/intl.dart';

import '../../features/home/providers/home_provider.dart';
import '../../features/settings/provider/settings_provider.dart';
import '../../l10n/app_localizations.dart';

class CaregiverAlertService {
  static String buildAlertMessage({
    required AppLocalizations l10n,
    required String patientName,
    required CaregiverProfile caregiver,
    required CaregiverAlertSummary summary,
    required String localeCode,
  }) {
    final timeFormat = _safeTimeFormat(localeCode);
    final buffer = StringBuffer()
      ..writeln(l10n.caregiverAlertMessageGreeting(caregiver.name))
      ..writeln()
      ..writeln(l10n.caregiverAlertMessageIntro(patientName));

    for (final item in summary.items) {
      final timeLabel = timeFormat.format(item.item.doseLog.scheduledTime);
      final courseName = item.item.medicine?.name ?? l10n.unknownMedicine;
      final line = switch (item.reason) {
        CaregiverAlertReason.overdue => l10n.caregiverAlertMessageLineOverdue(
          courseName,
          timeLabel,
          item.delayMinutes,
        ),
        CaregiverAlertReason.skipped => l10n.caregiverAlertMessageLineSkipped(
          courseName,
          timeLabel,
        ),
      };
      buffer.writeln('• $line');
    }

    buffer
      ..writeln()
      ..write(l10n.caregiverAlertMessageFooter);

    return buffer.toString().trim();
  }

  static DateFormat _safeTimeFormat(String localeCode) {
    try {
      return DateFormat.Hm(localeCode);
    } catch (_) {
      return DateFormat('HH:mm');
    }
  }
}
