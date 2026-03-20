import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/local/entities/medicine_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/home_controller.dart';
import '../../../medicine_management/presentation/add_medicine_screen.dart';

class SosPanel extends ConsumerWidget {
  const SosPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final controller = ref.read(homeControllerProvider);

    // Подписываемся на изменения экстренных лекарств
    final prnAsync = ref.watch(asNeededMedicinesProvider);

    return prnAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (prnMedicines) {
        // Если экстренных лекарств нет, панель вообще не занимает место
        if (prnMedicines.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                l10n.sosPanelTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error, // Красный оттенок для внимания
                ),
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: prnMedicines.length + 1, // +1 для кнопки "Добавить"
                itemBuilder: (context, index) {
                  // КНОПКА ДОБАВЛЕНИЯ (Последний элемент)
                  if (index == prnMedicines.length) {
                    return _buildAddSosButton(context, theme, l10n);
                  }

                  // КАРТОЧКА ПРЕПАРАТА
                  final medicine = prnMedicines[index];
                  return _buildSosCard(context, medicine, theme, l10n, controller);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildSosCard(BuildContext context, MedicineEntity medicine, ThemeData theme, AppLocalizations l10n, HomeController controller) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.error.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.error.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageOrIcon(medicine, theme),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              medicine.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error.withOpacity(0.1),
              foregroundColor: theme.colorScheme.error,
              minimumSize: const Size(80, 30),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            onPressed: () => controller.takeAsNeededDose(medicine, context, l10n),
            child: Text(l10n.takeNowAction, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSosButton(BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddMedicineScreen()),
        );
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: theme.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.addSosMedicine,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOrIcon(MedicineEntity medicine, ThemeData theme) {
    if (medicine.pillImagePath != null && medicine.pillImagePath!.isNotEmpty) {
      final file = File(medicine.pillImagePath!);
      if (file.existsSync()) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
          ),
        );
      }
    }
    return Icon(Icons.medication, color: theme.colorScheme.error, size: 36);
  }
}