import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_pill/features/home/presentation/widgets/pill_icon_widget.dart';

import '../../../../data/local/entities/medicine_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/l10n_extensions.dart';
import '../../../medicine_management/presentation/add_medicine_screen.dart';
import '../../providers/home_controller.dart';

class SosPanel extends ConsumerWidget {
  const SosPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final controller = ref.read(homeControllerProvider);
    final prnAsync = ref.watch(asNeededMedicinesProvider);

    return prnAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, stackTrace) => const SizedBox.shrink(),
      data: (prnMedicines) {
        if (prnMedicines.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 12.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.flash_on, color: theme.primaryColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    l10n.sosPanelTitle.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 64,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: prnMedicines.length + 1,
                itemBuilder: (context, index) {
                  if (index == prnMedicines.length) {
                    return _buildAddSosButton(context, theme, l10n);
                  }
                  return _buildSleekSosCard(
                    context,
                    prnMedicines[index],
                    theme,
                    l10n,
                    controller,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildSleekSosCard(
    BuildContext context,
    MedicineEntity medicine,
    ThemeData theme,
    AppLocalizations l10n,
    HomeController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.primaryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: PillIconWidget(
                shape: medicine.pillShape,
                colorHex: medicine.pillColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${medicine.dosage} ${l10n.dosageUnitLabel(medicine.dosageUnit)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
              foregroundColor: theme.primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              minimumSize: const Size(60, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () =>
                controller.takeAsNeededDose(medicine, context, l10n),
            child: Text(
              l10n.takeNowAction,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSosButton(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AddMedicineScreen()));
        if (context.mounted && result is String && result.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(result)));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_circle, color: theme.primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              l10n.addSosMedicine,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
