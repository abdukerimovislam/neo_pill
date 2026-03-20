import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/local/entities/measurement_entity.dart';
import '../../../../data/local/isar_service.dart';
import '../../../../l10n/app_localizations.dart';

class AddMeasurementModal extends ConsumerStatefulWidget {
  const AddMeasurementModal({super.key});

  @override
  ConsumerState<AddMeasurementModal> createState() =>
      _AddMeasurementModalState();
}

class _AddMeasurementModalState extends ConsumerState<AddMeasurementModal> {
  MeasurementTypeEnum _selectedType = MeasurementTypeEnum.bloodPressure;

  int _sysValue = 120;
  int _diaValue = 80;
  int _pulseValue = 70;
  int _weightInt = 70;
  int _weightDec = 0;
  int _sugarInt = 5;
  int _sugarDec = 5;

  void _save() async {
    final isarService = ref.read(localDbProvider);
    final entity = MeasurementEntity()
      ..syncId = const Uuid().v4()
      ..timestamp = DateTime.now()
      ..type = _selectedType;

    switch (_selectedType) {
      case MeasurementTypeEnum.bloodPressure:
        entity.value1 = _sysValue.toDouble();
        entity.value2 = _diaValue.toDouble();
        entity.unit = 'mmHg';
        break;
      case MeasurementTypeEnum.heartRate:
        entity.value1 = _pulseValue.toDouble();
        entity.unit = 'bpm';
        break;
      case MeasurementTypeEnum.weight:
        entity.value1 = _weightInt + (_weightDec / 10);
        entity.unit = 'kg';
        break;
      case MeasurementTypeEnum.bloodSugar:
        entity.value1 = _sugarInt + (_sugarDec / 10);
        entity.unit = 'mmol/L';
        break;
      default:
        entity.value1 = 0;
        entity.unit = '';
    }

    await isarService.saveMeasurement(entity);
    if (mounted) Navigator.pop(context);
  }

  Widget _buildTypeChip(
    MeasurementTypeEnum type,
    String label,
    IconData icon,
    ThemeData theme,
  ) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.primaryColor
                : theme.dividerColor.withValues(alpha: 0.1),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerColumn(
    int initial,
    int min,
    int max,
    String label,
    String unit,
    ValueChanged<int> onChanged,
    ThemeData theme,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: initial - min,
              ),
              itemExtent: 56,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: theme.primaryColor.withValues(alpha: 0.1),
              ),
              onSelectedItemChanged: (idx) => onChanged(min + idx),
              children: List.generate(max - min + 1, (index) {
                return Center(
                  child: Text(
                    '${min + index} $unit',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.addMeasurement,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildTypeChip(
                  MeasurementTypeEnum.bloodPressure,
                  l10n.bloodPressure,
                  Icons.favorite,
                  theme,
                ),
                _buildTypeChip(
                  MeasurementTypeEnum.heartRate,
                  l10n.heartRate,
                  Icons.monitor_heart,
                  theme,
                ),
                _buildTypeChip(
                  MeasurementTypeEnum.weight,
                  l10n.weight,
                  Icons.scale,
                  theme,
                ),
                _buildTypeChip(
                  MeasurementTypeEnum.bloodSugar,
                  l10n.bloodSugar,
                  Icons.water_drop,
                  theme,
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Builder(
                builder: (context) {
                  if (_selectedType == MeasurementTypeEnum.bloodPressure) {
                    return Row(
                      children: [
                        _buildPickerColumn(
                          _sysValue,
                          50,
                          250,
                          l10n.systolic,
                          '',
                          (v) => setState(() => _sysValue = v),
                          theme,
                        ),
                        const Text(
                          '/',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        _buildPickerColumn(
                          _diaValue,
                          30,
                          150,
                          l10n.diastolic,
                          '',
                          (v) => setState(() => _diaValue = v),
                          theme,
                        ),
                      ],
                    );
                  } else if (_selectedType == MeasurementTypeEnum.heartRate) {
                    return Row(
                      children: [
                        _buildPickerColumn(
                          _pulseValue,
                          30,
                          200,
                          l10n.heartRate,
                          'bpm',
                          (v) => setState(() => _pulseValue = v),
                          theme,
                        ),
                      ],
                    );
                  } else if (_selectedType == MeasurementTypeEnum.weight) {
                    return Row(
                      children: [
                        _buildPickerColumn(
                          _weightInt,
                          20,
                          250,
                          l10n.weight,
                          '',
                          (v) => setState(() => _weightInt = v),
                          theme,
                        ),
                        const Text(
                          '.',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildPickerColumn(
                          _weightDec,
                          0,
                          9,
                          '',
                          'kg',
                          (v) => setState(() => _weightDec = v),
                          theme,
                        ),
                      ],
                    );
                  } else if (_selectedType == MeasurementTypeEnum.bloodSugar) {
                    return Row(
                      children: [
                        _buildPickerColumn(
                          _sugarInt,
                          1,
                          30,
                          l10n.bloodSugar,
                          '',
                          (v) => setState(() => _sugarInt = v),
                          theme,
                        ),
                        const Text(
                          '.',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildPickerColumn(
                          _sugarDec,
                          0,
                          9,
                          '',
                          'mmol',
                          (v) => setState(() => _sugarDec = v),
                          theme,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: theme.primaryColor.withValues(alpha: 0.5),
                ),
                child: const Icon(Icons.check, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
