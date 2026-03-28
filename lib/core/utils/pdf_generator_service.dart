import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/local/entities/dose_log_entity.dart';
import '../../data/local/entities/medicine_entity.dart';
import '../../features/settings/provider/settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/l10n_extensions.dart';

class PdfGeneratorService {
  static const PdfColor _brand = PdfColor.fromInt(0xFF1A47B8);
  static const PdfColor _brandSoft = PdfColor.fromInt(0xFFD0E0FF);
  static const PdfColor _danger = PdfColor.fromInt(0xFFF56565);
  static const PdfColor _warning = PdfColor.fromInt(0xFFF6AD55);
  static const PdfColor _success = PdfColor.fromInt(0xFF2C7A7B);
  static const PdfColor _textMain = PdfColor.fromInt(0xFF2D3748);
  static const PdfColor _textMuted = PdfColor.fromInt(0xFF718096);
  static const PdfColor _surface = PdfColor.fromInt(0xFFF7FAFC);
  static const PdfColor _border = PdfColor.fromInt(0xFFE2E8F0);

  static Future<void> generateAndShareReport({
    required MedicineEntity medicine,
    required List<DoseLogEntity> logs,
    required AppLocalizations l10n,
    required String patientName,
    CaregiverProfile? caregiver,
  }) async {
    final pdf = pw.Document();
    final locale = l10n.localeName;
    final sortedLogs = [...logs]
      ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
    final timelineLogs = sortedLogs.take(40).toList();
    final completedLogs = sortedLogs
        .where((log) => log.status != DoseStatusEnum.pending)
        .toList();
    final scheduleSnapshot = _extractScheduleSnapshot(logs);

    final takenCount = sortedLogs
        .where((log) => log.status == DoseStatusEnum.taken)
        .length;
    final skippedCount = sortedLogs
        .where((log) => log.status == DoseStatusEnum.skipped)
        .length;
    final snoozedCount = sortedLogs
        .where((log) => log.status == DoseStatusEnum.snoozed)
        .length;
    final pendingCount = sortedLogs
        .where((log) => log.status == DoseStatusEnum.pending)
        .length;

    final totalProcessed = takenCount + skippedCount + snoozedCount;
    final adherenceRate = totalProcessed > 0
        ? (takenCount / totalProcessed * 100)
        : 0.0;
    final onTimeTakenLogs = completedLogs.where((log) {
      if (log.status != DoseStatusEnum.taken || log.actualTime == null) {
        return false;
      }
      return log.actualTime!.difference(log.scheduledTime).inMinutes.abs() <=
          30;
    }).length;
    final averageDelayMinutes = _averageDelayMinutes(completedLogs);
    final onTimeRate = takenCount > 0
        ? (onTimeTakenLogs / takenCount * 100)
        : 0.0;

    final dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm', locale);
    final dateFormat = DateFormat.yMMMd(locale);
    final shortDateFormat = DateFormat('yyyy-MM-dd', locale);
    final timeFormat = DateFormat.Hm(locale);
    final reportPeriod = sortedLogs.isEmpty
        ? null
        : '${shortDateFormat.format(sortedLogs.last.scheduledTime)} - ${shortDateFormat.format(sortedLogs.first.scheduledTime)}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 32),
        build: (context) {
          return [
            _buildHeader(
              l10n: l10n,
              generatedAt: dateTimeFormat.format(DateTime.now()),
              medicine: medicine,
            ),
            pw.SizedBox(height: 14),
            _buildSummaryGrid(
              l10n: l10n,
              adherenceRate: adherenceRate,
              takenCount: takenCount,
              skippedCount: skippedCount,
              snoozedCount: snoozedCount,
            ),
            pw.SizedBox(height: 14),
            _buildClinicalHighlights(
              l10n: l10n,
              patientName: patientName,
              caregiver: caregiver,
              reportPeriod: reportPeriod,
              pendingCount: pendingCount,
              onTimeRate: onTimeRate,
              averageDelayMinutes: averageDelayMinutes,
              stockLeft:
                  '${medicine.pillsRemaining} ${l10n.dosageUnitLabel(medicine.dosageUnit)}',
            ),
            pw.SizedBox(height: 16),
            _buildSectionCard(
              title: l10n.pdfCourseProfileTitle,
              child: _buildMedicineDetails(
                l10n: l10n,
                medicine: medicine,
                dateFormat: dateFormat,
              ),
            ),
            pw.SizedBox(height: 14),
            if (scheduleSnapshot.isNotEmpty)
              _buildSectionCard(
                title: l10n.pdfScheduleSnapshotTitle,
                subtitle: l10n.pdfScheduleSnapshotSubtitle,
                child: _buildScheduleSnapshot(
                  logs: scheduleSnapshot,
                  timeFormat: timeFormat,
                  unit: l10n.dosageUnitLabel(medicine.dosageUnit),
                ),
              ),
            if (scheduleSnapshot.isNotEmpty) pw.SizedBox(height: 14),
            _buildSectionCard(
              title: l10n.pdfAdministrationHistoryTitle,
              subtitle: l10n.pdfAdministrationHistorySubtitle,
              child: _buildTimelineTable(
                l10n: l10n,
                logs: timelineLogs,
                totalLogs: sortedLogs.length,
                dateFormat: dateFormat,
                timeFormat: timeFormat,
                unit: l10n.dosageUnitLabel(medicine.dosageUnit),
              ),
            ),
          ];
        },
      ),
    );

    final Uint8List pdfBytes = await pdf.save();

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename:
          'Pillora_Doctor_Report_${medicine.name.replaceAll(' ', '_')}.pdf',
    );
  }

  static List<DoseLogEntity> _extractScheduleSnapshot(
    List<DoseLogEntity> logs,
  ) {
    if (logs.isEmpty) return [];
    final ascending = [...logs]
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    final first = ascending.first.scheduledTime;
    final firstDay = DateTime(first.year, first.month, first.day);
    return ascending.where((log) {
      final current = log.scheduledTime;
      return current.year == firstDay.year &&
          current.month == firstDay.month &&
          current.day == firstDay.day;
    }).toList();
  }

  static double _averageDelayMinutes(List<DoseLogEntity> logs) {
    final takenLogs = logs
        .where(
          (log) => log.status == DoseStatusEnum.taken && log.actualTime != null,
        )
        .toList();
    if (takenLogs.isEmpty) return 0;
    final total = takenLogs.fold<int>(0, (sum, log) {
      return sum +
          log.actualTime!.difference(log.scheduledTime).inMinutes.abs();
    });
    return total / takenLogs.length;
  }

  static pw.Widget _buildHeader({
    required AppLocalizations l10n,
    required String generatedAt,
    required MedicineEntity medicine,
  }) {
    final title = l10n.pdfDoctorReportTitle;
    final subtitle = medicine.kind == CourseKindEnum.supplement
        ? l10n.pdfSupplementCourseSummary
        : l10n.pdfMedicationCourseSummary;

    return pw.Container(
      padding: const pw.EdgeInsets.all(18),
      decoration: pw.BoxDecoration(
        color: _surface,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(16)),
        border: pw.Border.all(color: _border),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      title,
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: _brand,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      subtitle,
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: _textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: pw.BoxDecoration(
                  color: _brandSoft,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(12),
                  ),
                ),
                child: pw.Text(
                  generatedAt,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: _brand,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          pw.Text(
            medicine.name,
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: _textMain,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryGrid({
    required AppLocalizations l10n,
    required double adherenceRate,
    required int takenCount,
    required int skippedCount,
    required int snoozedCount,
  }) {
    pw.Widget metric({
      required String label,
      required String value,
      required PdfColor color,
    }) {
      return pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            color: color == _brand ? _brandSoft : _surface,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(14)),
            border: pw.Border.all(
              color: color == _brand ? _brandSoft : _border,
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                value,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: color,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                label,
                style: const pw.TextStyle(fontSize: 10, color: _textMuted),
              ),
            ],
          ),
        ),
      );
    }

    return pw.Row(
      children: [
        metric(
          label: l10n.pdfAdherenceLabel,
          value: '${adherenceRate.toStringAsFixed(0)}%',
          color: _brand,
        ),
        pw.SizedBox(width: 10),
        metric(
          label: l10n.statusTaken,
          value: takenCount.toString(),
          color: _success,
        ),
        pw.SizedBox(width: 10),
        metric(
          label: l10n.statusSkipped,
          value: skippedCount.toString(),
          color: _danger,
        ),
        pw.SizedBox(width: 10),
        metric(
          label: l10n.pdfSnoozedLabel,
          value: snoozedCount.toString(),
          color: _warning,
        ),
      ],
    );
  }

  static pw.Widget _buildClinicalHighlights({
    required AppLocalizations l10n,
    required String patientName,
    CaregiverProfile? caregiver,
    required String? reportPeriod,
    required int pendingCount,
    required double onTimeRate,
    required double averageDelayMinutes,
    required String stockLeft,
  }) {
    pw.Widget item(String label, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 92,
              child: pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _textMuted,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                value,
                style: const pw.TextStyle(fontSize: 11, color: _textMain),
              ),
            ),
          ],
        ),
      );
    }

    return _buildSectionCard(
      title: l10n.pdfClinicalSummaryTitle,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          item(l10n.pdfPatientLabel, patientName),
          if (caregiver != null)
            item(
              l10n.pdfCaregiverLabel,
              [
                caregiver.name,
                if (caregiver.relation.isNotEmpty) caregiver.relation,
                if (caregiver.phone.isNotEmpty) caregiver.phone,
              ].join(' • '),
            ),
          if (reportPeriod != null)
            item(l10n.pdfReportPeriodLabel, reportPeriod),
          item(l10n.pdfOnTimeRateLabel, '${onTimeRate.toStringAsFixed(0)}%'),
          item(
            l10n.pdfAverageDelayLabel,
            '${averageDelayMinutes.toStringAsFixed(0)} ${l10n.pdfMinuteShort}',
          ),
          item(l10n.pdfUpcomingDosesLabel, pendingCount.toString()),
          item(l10n.pdfStockLeftLabel, stockLeft),
        ],
      ),
    );
  }

  static pw.Widget _buildMedicineDetails({
    required AppLocalizations l10n,
    required MedicineEntity medicine,
    required DateFormat dateFormat,
  }) {
    final instruction = switch (medicine.foodInstruction) {
      FoodInstructionEnum.beforeFood => l10n.foodBefore,
      FoodInstructionEnum.withFood => l10n.foodWith,
      FoodInstructionEnum.afterFood => l10n.foodAfter,
      _ => l10n.pdfNoFoodRestriction,
    };

    pw.Widget line(String label, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 96,
              child: pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _textMuted,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                value,
                style: const pw.TextStyle(fontSize: 11, color: _textMain),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        line(l10n.pdfNameLabel, medicine.name),
        line(l10n.pdfCourseTypeLabel, l10n.courseKindLabel(medicine.kind)),
        line(
          l10n.pdfDosageLabel,
          '${_formatDosage(medicine.dosage)} ${l10n.dosageUnitLabel(medicine.dosageUnit)} (${_formatFormLabel(medicine.form, l10n)})',
        ),
        line(
          l10n.pdfFrequencyLabel,
          _formatFrequencyLabel(medicine.frequency, l10n),
        ),
        line(l10n.pdfStartedLabel, dateFormat.format(medicine.startDate)),
        line(l10n.pdfInstructionLabel, instruction),
        if ((medicine.instructions ?? '').trim().isNotEmpty)
          line(l10n.pdfNotesLabel, medicine.instructions!.trim()),
      ],
    );
  }

  static pw.Widget _buildScheduleSnapshot({
    required List<DoseLogEntity> logs,
    required DateFormat timeFormat,
    required String unit,
  }) {
    return pw.Wrap(
      spacing: 10,
      runSpacing: 10,
      children: logs.map((log) {
        return pw.Container(
          width: 120,
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: _surface,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
            border: pw.Border.all(color: _border),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                timeFormat.format(log.scheduledTime),
                style: pw.TextStyle(
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                  color: _brand,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                '${_formatDosage(log.dosage)} $unit',
                style: const pw.TextStyle(fontSize: 11, color: _textMain),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  static pw.Widget _buildTimelineTable({
    required AppLocalizations l10n,
    required List<DoseLogEntity> logs,
    required int totalLogs,
    required DateFormat dateFormat,
    required DateFormat timeFormat,
    required String unit,
  }) {
    if (logs.isEmpty) {
      return pw.Text(
        l10n.pdfTimelineEmpty,
        style: pw.TextStyle(color: _textMuted, fontStyle: pw.FontStyle.italic),
      );
    }

    final rows = logs.map((log) {
      final scheduled =
          '${dateFormat.format(log.scheduledTime)} ${timeFormat.format(log.scheduledTime)}';
      final actual = log.actualTime == null
          ? '-'
          : '${dateFormat.format(log.actualTime!)} ${timeFormat.format(log.actualTime!)}';
      final delay = _formatDelay(log, l10n);
      final statusText = _statusLabel(log.status, l10n);
      final statusColor = _statusColor(log.status);

      return pw.TableRow(
        decoration: pw.BoxDecoration(
          border: pw.Border(bottom: pw.BorderSide(color: _border, width: 0.7)),
        ),
        children: [
          _tableCell(scheduled),
          _tableCell(actual),
          _tableCell('${_formatDosage(log.dosage)} $unit'),
          _tableStatusCell(statusText, statusColor),
          _tableCell(delay),
        ],
      );
    }).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Table(
          columnWidths: const {
            0: pw.FlexColumnWidth(2.2),
            1: pw.FlexColumnWidth(2.2),
            2: pw.FlexColumnWidth(1.2),
            3: pw.FlexColumnWidth(1.3),
            4: pw.FlexColumnWidth(1.3),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: _brand),
              children: [
                _tableHeader(l10n.pdfTableScheduled),
                _tableHeader(l10n.pdfTableActual),
                _tableHeader(l10n.pdfTableDose),
                _tableHeader(l10n.pdfTableStatus),
                _tableHeader(l10n.pdfTableDelay),
              ],
            ),
            ...rows,
          ],
        ),
        if (totalLogs > logs.length) ...[
          pw.SizedBox(height: 8),
          pw.Text(
            l10n.pdfTimelineTruncated(logs.length, totalLogs),
            style: const pw.TextStyle(fontSize: 9, color: _textMuted),
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildSectionCard({
    required String title,
    String? subtitle,
    required pw.Widget child,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(16)),
        border: pw.Border.all(color: _border),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: _brand,
            ),
          ),
          if (subtitle != null) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              subtitle,
              style: const pw.TextStyle(fontSize: 10, color: _textMuted),
            ),
          ],
          pw.SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  static pw.Widget _tableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
    );
  }

  static pw.Widget _tableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 10, color: _textMain),
      ),
    );
  }

  static pw.Widget _tableStatusCell(String text, PdfColor color) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: pw.BoxDecoration(
          color: color.shade(0.12),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(999)),
        ),
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  static String _formatDelay(DoseLogEntity log, AppLocalizations l10n) {
    if (log.actualTime == null) {
      return '-';
    }
    final minutes = log.actualTime!.difference(log.scheduledTime).inMinutes;
    if (minutes == 0) {
      return l10n.pdfOnTime;
    }
    final prefix = minutes > 0 ? '+' : '-';
    final absMinutes = minutes.abs();
    return '$prefix$absMinutes ${l10n.pdfMinuteShort}';
  }

  static String _statusLabel(DoseStatusEnum status, AppLocalizations l10n) {
    return switch (status) {
      DoseStatusEnum.taken => l10n.statusTaken,
      DoseStatusEnum.skipped => l10n.statusSkipped,
      DoseStatusEnum.snoozed => l10n.pdfSnoozedLabel,
      DoseStatusEnum.pending => l10n.statusPending,
    };
  }

  static PdfColor _statusColor(DoseStatusEnum status) {
    return switch (status) {
      DoseStatusEnum.taken => _success,
      DoseStatusEnum.skipped => _danger,
      DoseStatusEnum.snoozed => _warning,
      DoseStatusEnum.pending => _brand,
    };
  }

  static String _formatDosage(double dosage) {
    return dosage % 1 == 0 ? dosage.toInt().toString() : dosage.toString();
  }

  static String _formatFormLabel(MedicineFormEnum form, AppLocalizations l10n) {
    return switch (form) {
      MedicineFormEnum.pill => l10n.medicineFormTablet,
      MedicineFormEnum.capsule => l10n.medicineFormCapsule,
      MedicineFormEnum.liquid => l10n.medicineFormLiquid,
      MedicineFormEnum.injection => l10n.medicineFormInjection,
      MedicineFormEnum.drops => l10n.medicineFormDrops,
      MedicineFormEnum.ointment => l10n.medicineFormOintment,
      MedicineFormEnum.spray => l10n.medicineFormSpray,
      MedicineFormEnum.inhaler => l10n.medicineFormInhaler,
      MedicineFormEnum.patch => l10n.medicineFormPatch,
      MedicineFormEnum.suppository => l10n.medicineFormSuppository,
    };
  }

  static String _formatFrequencyLabel(
    FrequencyTypeEnum frequency,
    AppLocalizations l10n,
  ) {
    return switch (frequency) {
      FrequencyTypeEnum.daily => l10n.medicineFrequencyDaily,
      FrequencyTypeEnum.asNeeded => l10n.asNeededFrequency,
      FrequencyTypeEnum.specificDays => l10n.medicineFrequencySpecificDays,
      FrequencyTypeEnum.interval => l10n.medicineFrequencyInterval,
      FrequencyTypeEnum.cycle => l10n.medicineFrequencyCycle,
      FrequencyTypeEnum.tapering => l10n.taperingFrequency,
    };
  }
}
