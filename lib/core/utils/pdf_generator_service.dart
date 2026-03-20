import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../data/local/entities/medicine_entity.dart';
import '../../data/local/entities/dose_log_entity.dart';
import '../../l10n/app_localizations.dart';

class PdfGeneratorService {

  // Главный метод генерации и отправки отчета
  static Future<void> generateAndShareReport({
    required MedicineEntity medicine,
    required List<DoseLogEntity> logs,
    required AppLocalizations l10n,
  }) async {
    final pdf = pw.Document();

    // Сортируем логи от новых к старым
    logs.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));

    // Считаем статистику
    final takenCount = logs.where((l) => l.status == DoseStatusEnum.taken).length;
    final skippedCount = logs.where((l) => l.status == DoseStatusEnum.skipped).length;
    final totalProcessed = takenCount + skippedCount;
    final adherenceRate = totalProcessed > 0 ? (takenCount / totalProcessed * 100).toStringAsFixed(1) : '0.0';

    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');

    // Формируем страницы PDF
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(medicine, adherenceRate, l10n),
            pw.SizedBox(height: 20),
            _buildMedicineDetails(medicine, dateFormat, l10n),
            pw.SizedBox(height: 20),
            _buildLogsTable(logs, dateFormat, timeFormat, l10n),
          ];
        },
      ),
    );

    // Сохраняем в байты
    final Uint8List pdfBytes = await pdf.save();

    // Вызываем системное окно Share (Поделиться)
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Medical_Report_${medicine.name.replaceAll(' ', '_')}.pdf',
    );
  }

  // Шапка документа
  static pw.Widget _buildHeader(MedicineEntity medicine, String adherenceRate, AppLocalizations l10n) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Patient Adherence Report', // В идеале перевести через l10n
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800),
            ),
            pw.Text(
              'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
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
              pw.Text('Overall Adherence Rate:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('$adherenceRate%', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.green700)),
            ],
          ),
        ),
      ],
    );
  }

  // Детали препарата
  static pw.Widget _buildMedicineDetails(MedicineEntity medicine, DateFormat dateFormat, AppLocalizations l10n) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Medication Profile', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
        pw.SizedBox(height: 8),
        pw.Text('Name: ${medicine.name}', style: const pw.TextStyle(fontSize: 14)),
        pw.Text('Dosage: ${medicine.dosage} ${medicine.dosageUnit} (${medicine.form.name})', style: const pw.TextStyle(fontSize: 14)),
        pw.Text('Started: ${dateFormat.format(medicine.startDate)}', style: const pw.TextStyle(fontSize: 14)),
        if (medicine.foodInstruction != FoodInstructionEnum.noMatter)
          pw.Text('Instruction: ${medicine.foodInstruction.name}', style: const pw.TextStyle(fontSize: 14)),
      ],
    );
  }

  // Таблица истории приемов
  static pw.Widget _buildLogsTable(List<DoseLogEntity> logs, DateFormat dateFormat, DateFormat timeFormat, AppLocalizations l10n) {
    // Фильтруем логи, оставляем только те, что уже должны были быть выпиты (или пропущены)
    final pastLogs = logs.where((l) => l.status != DoseStatusEnum.pending).toList();

    if (pastLogs.isEmpty) {
      return pw.Text('No recorded history yet.', style: pw.TextStyle(color: PdfColors.grey600, fontStyle: pw.FontStyle.italic));
    }

    return pw.TableHelper.fromTextArray(
      headers: ['Date', 'Scheduled Time', 'Actual Time', 'Status'], // В идеале из l10n
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blue600),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      data: pastLogs.map((log) {
        String statusText;
        PdfColor statusColor;

        if (log.status == DoseStatusEnum.taken) {
          statusText = 'Taken';
          statusColor = PdfColors.green600;
        } else {
          statusText = 'Skipped';
          statusColor = PdfColors.red600;
        }

        return [
          dateFormat.format(log.scheduledTime),
          timeFormat.format(log.scheduledTime),
          log.actualTime != null ? timeFormat.format(log.actualTime!) : '-',
          statusText, // Для раскраски текста нужен кастомный билд ячеек, но для простоты текста хватит массива
        ];
      }).toList(),
    );
  }
}