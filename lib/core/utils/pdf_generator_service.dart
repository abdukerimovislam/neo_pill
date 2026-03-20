import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/local/entities/dose_log_entity.dart';
import '../../data/local/entities/medicine_entity.dart';
import '../../features/settings/provider/settings_provider.dart';
import '../../l10n/app_localizations.dart';

class PdfGeneratorService {
  static Future<void> generateAndShareReport({
    required MedicineEntity medicine,
    required List<DoseLogEntity> logs,
    required AppLocalizations l10n,
    required String patientName,
    CaregiverProfile? caregiver,
  }) async {
    final pdf = pw.Document();
    final isRussian = l10n.localeName.startsWith('ru');

    logs.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));

    final takenCount = logs.where((l) => l.status == DoseStatusEnum.taken).length;
    final skippedCount = logs.where((l) => l.status == DoseStatusEnum.skipped).length;
    final pendingCount = logs.where((l) => l.status == DoseStatusEnum.pending).length;
    final totalProcessed = takenCount + skippedCount;
    final adherenceRate = totalProcessed > 0 ? (takenCount / totalProcessed * 100) : 0.0;

    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(
              isRussian: isRussian,
              adherenceRate: adherenceRate,
            ),
            pw.SizedBox(height: 18),
            _buildSummaryRow(
              isRussian: isRussian,
              takenCount: takenCount,
              skippedCount: skippedCount,
              pendingCount: pendingCount,
            ),
            pw.SizedBox(height: 18),
            _buildCareProfile(
              isRussian: isRussian,
              patientName: patientName,
              caregiver: caregiver,
            ),
            pw.SizedBox(height: 18),
            _buildMedicineDetails(
              isRussian: isRussian,
              medicine: medicine,
              dateFormat: dateFormat,
            ),
            pw.SizedBox(height: 18),
            _buildLogsTable(
              isRussian: isRussian,
              logs: logs,
              dateFormat: dateFormat,
              timeFormat: timeFormat,
            ),
          ];
        },
      ),
    );

    final Uint8List pdfBytes = await pdf.save();

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'NeoPill_Report_${medicine.name.replaceAll(' ', '_')}.pdf',
    );
  }

  static pw.Widget _buildHeader({
    required bool isRussian,
    required double adherenceRate,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              isRussian ? 'Отчет по приему лекарств' : 'Medication Adherence Report',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue800,
              ),
            ),
            pw.Text(
              '${isRussian ? 'Дата' : 'Date'}: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
              style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Divider(thickness: 2, color: PdfColors.blue200),
        pw.SizedBox(height: 10),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                isRussian ? 'Общая регулярность приема' : 'Overall adherence',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                '${adherenceRate.toStringAsFixed(1)}%',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: adherenceRate >= 80 ? PdfColors.green700 : PdfColors.orange700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryRow({
    required bool isRussian,
    required int takenCount,
    required int skippedCount,
    required int pendingCount,
  }) {
    pw.Widget metric(String label, String value) {
      return pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                value,
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 4),
              pw.Text(label, style: const pw.TextStyle(fontSize: 11)),
            ],
          ),
        ),
      );
    }

    return pw.Row(
      children: [
        metric(isRussian ? 'Принято' : 'Taken', takenCount.toString()),
        pw.SizedBox(width: 10),
        metric(isRussian ? 'Пропущено' : 'Skipped', skippedCount.toString()),
        pw.SizedBox(width: 10),
        metric(isRussian ? 'Ожидается' : 'Pending', pendingCount.toString()),
      ],
    );
  }

  static pw.Widget _buildCareProfile({
    required bool isRussian,
    required String patientName,
    CaregiverProfile? caregiver,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            isRussian ? 'Участники ухода' : 'Care team',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text('${isRussian ? 'Пациент' : 'Patient'}: $patientName'),
          if (caregiver != null) ...[
            pw.Text(
              '${isRussian ? 'Помогающий человек' : 'Caregiver'}: ${caregiver.name}',
            ),
            if (caregiver.relation.isNotEmpty)
              pw.Text('${isRussian ? 'Связь' : 'Relationship'}: ${caregiver.relation}'),
            if (caregiver.phone.isNotEmpty)
              pw.Text('${isRussian ? 'Контакт' : 'Contact'}: ${caregiver.phone}'),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildMedicineDetails({
    required bool isRussian,
    required MedicineEntity medicine,
    required DateFormat dateFormat,
  }) {
    final instruction = switch (medicine.foodInstruction) {
      FoodInstructionEnum.beforeFood => isRussian ? 'До еды' : 'Before food',
      FoodInstructionEnum.withFood => isRussian ? 'Во время еды' : 'With food',
      FoodInstructionEnum.afterFood => isRussian ? 'После еды' : 'After food',
      _ => isRussian ? 'Без ограничений' : 'No food restriction',
    };

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          isRussian ? 'Профиль лекарства' : 'Medication profile',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue800,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text('${isRussian ? 'Название' : 'Name'}: ${medicine.name}'),
        pw.Text(
          '${isRussian ? 'Дозировка' : 'Dosage'}: ${medicine.dosage} ${medicine.dosageUnit} (${medicine.form.name})',
        ),
        pw.Text(
          '${isRussian ? 'Начало курса' : 'Started'}: ${dateFormat.format(medicine.startDate)}',
        ),
        pw.Text(
          '${isRussian ? 'Остаток' : 'Stock left'}: ${medicine.pillsRemaining} ${medicine.dosageUnit}',
        ),
        pw.Text('${isRussian ? 'Инструкция' : 'Instruction'}: $instruction'),
      ],
    );
  }

  static pw.Widget _buildLogsTable({
    required bool isRussian,
    required List<DoseLogEntity> logs,
    required DateFormat dateFormat,
    required DateFormat timeFormat,
  }) {
    final pastLogs = logs.where((l) => l.status != DoseStatusEnum.pending).toList();

    if (pastLogs.isEmpty) {
      return pw.Text(
        isRussian ? 'История приема пока не записана.' : 'No recorded history yet.',
        style: pw.TextStyle(
          color: PdfColors.grey600,
          fontStyle: pw.FontStyle.italic,
        ),
      );
    }

    return pw.TableHelper.fromTextArray(
      headers: [
        isRussian ? 'Дата' : 'Date',
        isRussian ? 'По плану' : 'Scheduled',
        isRussian ? 'Фактически' : 'Actual',
        isRussian ? 'Статус' : 'Status',
      ],
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blue600),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      data: pastLogs.map((log) {
        final statusText = switch (log.status) {
          DoseStatusEnum.taken => isRussian ? 'Принято' : 'Taken',
          DoseStatusEnum.skipped => isRussian ? 'Пропущено' : 'Skipped',
          _ => isRussian ? 'Ожидается' : 'Pending',
        };

        return [
          dateFormat.format(log.scheduledTime),
          timeFormat.format(log.scheduledTime),
          log.actualTime != null ? timeFormat.format(log.actualTime!) : '-',
          statusText,
        ];
      }).toList(),
    );
  }
}
