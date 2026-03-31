import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n_extensions.dart';
import '../../home/presentation/widgets/pill_icon_widget.dart';
import '../../home/providers/home_controller.dart';

// 🚀 КЛАСС ДЛЯ ШАБЛОНОВ ЗАБОЛЕВАНИЙ
class _TemplateOption {
  final String name;
  final String note;
  final double dosage;
  final String unit;
  final CourseKindEnum kind;
  final FrequencyTypeEnum freq;
  final IconData icon;

  const _TemplateOption({
    required this.name,
    required this.note,
    required this.dosage,
    required this.unit,
    required this.kind,
    required this.freq,
    required this.icon,
  });
}

// 🚀 ВНУТРЕННИЙ КЛАСС ДЛЯ ПОЭТАПНОГО КУРСА
class _ComplexCourseStep {
  int durationDays;
  double dosage;
  List<TimeOfDay> times;

  _ComplexCourseStep({
    required this.durationDays,
    required this.dosage,
    required this.times,
  });
}

class AddMedicineScreen extends ConsumerStatefulWidget {
  final CourseKindEnum initialKind;

  const AddMedicineScreen({
    super.key,
    this.initialKind = CourseKindEnum.medication,
  });

  @override
  ConsumerState<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends ConsumerState<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();

  int _durationDays = 30;
  int _pillsInPackage = 30;
  int _intervalDays = 2;
  int _prnMaxDoses = 4;
  bool _isLifetime = false;

  late CourseKindEnum _selectedKind;
  MedicineFormEnum _selectedForm = MedicineFormEnum.pill;
  String _selectedUnit = 'mg';
  FrequencyTypeEnum _selectedFrequency = FrequencyTypeEnum.daily;
  FoodInstructionEnum _selectedFood = FoodInstructionEnum.noMatter;

  final List<TimeOfDay> _selectedTimes = [const TimeOfDay(hour: 8, minute: 0)];
  final List<String> _units = ['mg', 'ml', 'pcs', 'drops', 'g', 'mcg', 'IU'];

  PillShapeEnum _selectedShape = PillShapeEnum.circle;
  int _selectedColor = 0xFF2196F3;
  String? _pillImagePath;

  int _dailyPreset = 1;

  final List<_ComplexCourseStep> _complexSteps = [
    _ComplexCourseStep(
      durationDays: 3,
      dosage: 1.0,
      times: [const TimeOfDay(hour: 8, minute: 0)],
    ),
  ];

  final List<int> _availableColors = [
    0xFF2196F3,
    0xFFF44336,
    0xFF4CAF50,
    0xFFFF9800,
    0xFF9C27B0,
    0xFFE91E63,
    0xFF00BCD4,
    0xFF795548,
    0xFF607D8B,
    0xFF424242,
  ];

  @override
  void initState() {
    super.initState();
    _selectedKind = widget.initialKind;
    _applyDailyPreset(1, triggerSetState: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  // 🚀 ГЕНЕРАТОР ШАБЛОНОВ НА ОСНОВЕ ЛОКАЛИЗАЦИИ
  List<_TemplateOption> _getTemplates(AppLocalizations l10n) {
    return [
      _TemplateOption(
        name: l10n.suggestionIbuprofenName,
        note: l10n.suggestionIbuprofenNote,
        dosage: 400,
        unit: 'mg',
        kind: CourseKindEnum.medication,
        freq: FrequencyTypeEnum.asNeeded,
        icon: Icons.healing_rounded,
      ),
      _TemplateOption(
        name: l10n.suggestionAmlodipineName,
        note: l10n.suggestionAmlodipineNote,
        dosage: 5,
        unit: 'mg',
        kind: CourseKindEnum.medication,
        freq: FrequencyTypeEnum.daily,
        icon: Icons.favorite_rounded,
      ),
      _TemplateOption(
        name: l10n.suggestionOmeprazoleName,
        note: l10n.suggestionOmeprazoleNote,
        dosage: 20,
        unit: 'mg',
        kind: CourseKindEnum.medication,
        freq: FrequencyTypeEnum.daily,
        icon: Icons.local_drink_rounded,
      ),
      _TemplateOption(
        name: l10n.suggestionCalciumVitaminDName,
        note: l10n.suggestionCalciumVitaminDNote,
        dosage: 1,
        unit: 'pcs',
        kind: CourseKindEnum.supplement,
        freq: FrequencyTypeEnum.daily,
        icon: Icons.spa_rounded,
      ),
      _TemplateOption(
        name: l10n.suggestionFerrousSulfateName,
        note: l10n.suggestionFerrousSulfateNote,
        dosage: 325,
        unit: 'mg',
        kind: CourseKindEnum.supplement,
        freq: FrequencyTypeEnum.daily,
        icon: Icons.water_drop_rounded,
      ),
      _TemplateOption(
        name: l10n.suggestionCetirizineName,
        note: l10n.suggestionCetirizineNote,
        dosage: 10,
        unit: 'mg',
        kind: CourseKindEnum.medication,
        freq: FrequencyTypeEnum.daily,
        icon: Icons.air_rounded,
      ),
    ];
  }

  void _applyTemplate(_TemplateOption template) {
    HapticFeedback.lightImpact();
    setState(() {
      _nameController.text = template.name;
      _dosageController.text = template.dosage % 1 == 0
          ? template.dosage.toInt().toString()
          : template.dosage.toString();
      _selectedUnit = template.unit;
      _selectedFrequency = template.freq;

      // Сбрасываем время на дефолтное утро (если это не SOS)
      if (template.freq != FrequencyTypeEnum.asNeeded) {
        _selectedTimes.clear();
        _selectedTimes.add(const TimeOfDay(hour: 8, minute: 0));
      }
    });

    // Показываем подтверждение
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Шаблон "${template.name}" применен'), // Тут можно добавить локализацию
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _pillImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      debugPrint("Image picker error: $e");
    }
  }

  void _applyDailyPreset(int preset, {bool triggerSetState = true}) {
    final apply = () {
      _selectedFrequency = FrequencyTypeEnum.daily;
      _dailyPreset = preset;

      switch (preset) {
        case 1:
          _selectedTimes
            ..clear()
            ..add(const TimeOfDay(hour: 8, minute: 0));
          break;
        case 2:
          _selectedTimes
            ..clear()
            ..add(const TimeOfDay(hour: 8, minute: 0))
            ..add(const TimeOfDay(hour: 20, minute: 0));
          break;
        case 3:
          _selectedTimes
            ..clear()
            ..add(const TimeOfDay(hour: 8, minute: 0))
            ..add(const TimeOfDay(hour: 14, minute: 0))
            ..add(const TimeOfDay(hour: 20, minute: 0));
          break;
        default:
          if (_selectedTimes.isEmpty) {
            _selectedTimes.add(const TimeOfDay(hour: 8, minute: 0));
          }
      }
    };

    if (triggerSetState) {
      setState(apply);
    } else {
      apply();
    }
  }

  void _addTime() {
    setState(() {
      _selectedTimes.add(const TimeOfDay(hour: 20, minute: 0));
      _sortTimes(_selectedTimes);
      _dailyPreset = 0;
    });
  }

  void _removeTime(int index) {
    if (_selectedTimes.length > 1) {
      setState(() {
        _selectedTimes.removeAt(index);
        _dailyPreset = 0;
      });
    }
  }

  void _sortTimes(List<TimeOfDay> times) {
    times.sort((a, b) {
      final aMinutes = a.hour * 60 + a.minute;
      final bMinutes = b.hour * 60 + b.minute;
      return aMinutes.compareTo(bMinutes);
    });
  }

  String _getInventoryUnit(AppLocalizations l10n) {
    final unitLower = _selectedUnit.toLowerCase();
    if (['mg', 'g', 'mcg', 'мг', 'г', 'мкг'].contains(unitLower)) {
      return l10n.pcsSuffix;
    }
    return l10n.dosageUnitLabel(_selectedUnit);
  }

  Widget _buildPillShape(PillShapeEnum shape, Color color, double size) {
    switch (shape) {
      case PillShapeEnum.circle:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      case PillShapeEnum.capsule:
        return Container(
          width: size * 1.5,
          height: size * 0.6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size),
          ),
        );
      case PillShapeEnum.oval:
        return Container(
          width: size * 1.2,
          height: size * 0.8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.elliptical(size * 1.2, size * 0.8),
            ),
          ),
        );
      case PillShapeEnum.square:
        return Container(
          width: size * 0.9,
          height: size * 0.9,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
        );
      case PillShapeEnum.diamond:
        return Transform.rotate(
          angle: 0.785398,
          child: Container(
            width: size * 0.75,
            height: size * 0.75,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(size * 0.15),
            ),
          ),
        );
    }
  }

  void _showPillConstructorModal(AppLocalizations l10n) {
    PillShapeEnum tempShape = _selectedShape;
    int tempColor = _selectedColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          final theme = Theme.of(context);
          return Container(
            height: 450,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.customizePillTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedShape = tempShape;
                            _selectedColor = tempColor;
                            _pillImagePath = null;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Text(
                          l10n.doneAction,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: theme.dividerColor.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(tempColor).withValues(alpha: 0.25),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _buildPillShape(tempShape, Color(tempColor), 48),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    l10n.shape,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: PillShapeEnum.values.map((shape) {
                      final isSelected = shape == tempShape;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempShape = shape),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primaryColor.withValues(alpha: 0.1)
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? theme.primaryColor
                                  : theme.dividerColor.withValues(alpha: 0.1),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: _buildPillShape(
                              shape,
                              isSelected
                                  ? theme.primaryColor
                                  : theme.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
                              24,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    l10n.color,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _availableColors.map((colorHex) {
                      final isSelected = colorHex == tempColor;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempColor = colorHex),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(colorHex),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.onSurface
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(colorHex).withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showRoulettePicker({
    required String title,
    required int initialValue,
    required int min,
    required int max,
    required String suffix,
    required ValueChanged<int> onChanged,
    required AppLocalizations l10n,
  }) {
    int tempValue = initialValue;
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onChanged(tempValue);
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      l10n.doneAction,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: theme.dividerColor.withValues(alpha: 0.1),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: initialValue - min,
                ),
                itemExtent: 48,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: theme.primaryColor.withValues(alpha: 0.1),
                ),
                onSelectedItemChanged: (index) {
                  tempValue = min + index;
                },
                children: List.generate(max - min + 1, (index) {
                  return Center(
                    child: Text(
                      '${min + index} $suffix',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final l10n = AppLocalizations.of(context)!;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorEmptyFields)));
      return;
    }

    double dosageToSave = 0.0;
    int durationToSave = _durationDays;
    List<TaperingStep>? taperingStepsToSave;

    if (_selectedFrequency == FrequencyTypeEnum.tapering) {
      if (_complexSteps.isEmpty) return;

      dosageToSave = _complexSteps.first.dosage;
      durationToSave = _complexSteps.fold(0, (sum, step) => sum + step.durationDays);

      taperingStepsToSave = _complexSteps.map((s) {
        final step = TaperingStep();
        step.durationDays = s.durationDays;
        step.dosage = s.dosage;

        step.timeStrings = s.times.map((t) {
          final hh = t.hour.toString().padLeft(2, '0');
          final mm = t.minute.toString().padLeft(2, '0');
          return '$hh:$mm';
        }).toList();

        return step;
      }).toList();

    } else {
      final dosageText = _dosageController.text.trim();
      if (dosageText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorEmptyFields)));
        return;
      }
      dosageToSave = double.tryParse(dosageText) ?? 0.0;
      durationToSave = _isLifetime ? 3650 : _durationDays;
    }

    final String unitLower = _selectedUnit.toLowerCase();
    final bool isMassUnit = ['mg', 'g', 'mcg', 'мг', 'г', 'мкг'].contains(unitLower);
    int inventoryToSave = _pillsInPackage;

    if (isMassUnit && dosageToSave > 0) {
      inventoryToSave = (_pillsInPackage * dosageToSave).round();
    }

    final title = l10n.notificationTitle(name);
    final body = l10n.notificationBody('$dosageToSave $_selectedUnit');
    final kindLabel = _selectedKind == CourseKindEnum.supplement
        ? l10n.courseKindSupplement
        : l10n.courseKindMedication;

    await ref.read(homeControllerProvider).addMedicineAndGenerateSchedule(
      kind: _selectedKind,
      name: name,
      dosage: dosageToSave,
      dosageUnit: _selectedUnit,
      form: _selectedForm,
      frequency: _selectedFrequency,
      foodInstruction: _selectedFood,
      times: _selectedFrequency == FrequencyTypeEnum.tapering
          ? _complexSteps.first.times
          : _selectedTimes,
      durationDays: durationToSave,
      pillsInPackage: inventoryToSave,
      intervalDays: _selectedFrequency == FrequencyTypeEnum.interval
          ? _intervalDays
          : null,
      prnMaxDailyDoses: _selectedFrequency == FrequencyTypeEnum.asNeeded
          ? _prnMaxDoses
          : null,
      taperingSteps: taperingStepsToSave,
      pillShape: _selectedShape,
      pillColor: _selectedColor,
      pillImagePath: _pillImagePath,
      notificationTitle: title,
      notificationBody: body,
    );

    if (mounted) {
      Navigator.of(context).pop(l10n.courseAddedMessage(kindLabel, name));
    }
  }

  Widget _buildSectionHeader(String title, {String? step}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          if (step != null) ...[
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                step,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKindSelector(ThemeData theme, AppLocalizations l10n) {
    return GlassContainer(
      padding: const EdgeInsets.all(8),
      color: theme.colorScheme.surface.withValues(alpha: 0.45),
      child: Row(
        children: [
          Expanded(
            child: _KindOptionButton(
              label: l10n.courseKindMedication,
              icon: Icons.medication_rounded,
              isSelected: _selectedKind == CourseKindEnum.medication,
              selectedColor: theme.brandPrimary,
              onTap: () =>
                  setState(() => _selectedKind = CourseKindEnum.medication),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _KindOptionButton(
              label: l10n.courseKindSupplement,
              icon: Icons.spa_rounded,
              isSelected: _selectedKind == CourseKindEnum.supplement,
              selectedColor: theme.supplementAccent,
              onTap: () =>
                  setState(() => _selectedKind = CourseKindEnum.supplement),
            ),
          ),
        ],
      ),
    );
  }

  // 🚀 НОВЫЙ ВЕРНУВШИЙСЯ БЛОК: ШАБЛОНЫ
  Widget _buildTemplatesSection(ThemeData theme, AppLocalizations l10n) {
    final allTemplates = _getTemplates(l10n);
    // Фильтруем: показываем витамины, если выбраны витамины, и наоборот
    final filteredTemplates = allTemplates.where((t) => t.kind == _selectedKind).toList();

    if (filteredTemplates.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt_rounded, color: theme.primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              l10n.addQuickStartTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          l10n.addQuickStartSubtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Row(
            children: filteredTemplates.map((template) {
              return GestureDetector(
                onTap: () => _applyTemplate(template),
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(template.icon, color: theme.primaryColor, size: 20),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        template.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        template.note,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumTextField({
    required TextEditingController controller,
    required String label,
    required ThemeData theme,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _buildRouletteField({
    required String label,
    required String valueText,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  valueText,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.unfold_more_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartCounter({
    required String label,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required ThemeData theme,
    String? suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$value${suffix != null ? ' $suffix' : ''}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 20,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleSmartCounter({
    required String label,
    required double value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required ThemeData theme,
    String? suffix,
  }) {
    String displayValue = value % 1 == 0
        ? value.toInt().toString()
        : value.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$displayValue${suffix != null ? ' $suffix' : ''}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 20,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableChips<T>({
    required List<T> items,
    required T selectedValue,
    required String Function(T) labelBuilder,
    required void Function(T) onSelected,
    required ThemeData theme,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.map((item) {
          final isSelected = item == selectedValue;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(labelBuilder(item)),
              selected: isSelected,
              onSelected: (_) => onSelected(item),
              selectedColor: theme.primaryColor,
              backgroundColor: theme.colorScheme.surface.withValues(
                alpha: 0.45,
              ),
              labelStyle: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide.none,
              ),
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final screenTitle = _selectedKind == CourseKindEnum.supplement
        ? l10n.addSupplementScreenTitle
        : l10n.addMedicationTitle;
    final nameHint = _selectedKind == CourseKindEnum.supplement
        ? l10n.supplementNameHint
        : l10n.medicineNameHint;

    final inventoryUnit = _getInventoryUnit(l10n);

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                screenTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.9),
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                AnimatedReveal(
                  delay: const Duration(milliseconds: 40),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => _showPillConstructorModal(l10n),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withValues(
                            alpha: 0.5,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(_selectedColor).withValues(alpha: 0.5),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(
                                _selectedColor,
                              ).withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: _pillImagePath != null
                            ? ClipOval(
                          child: Image.file(
                            File(_pillImagePath!),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Center(
                          child: _buildPillShape(
                            _selectedShape,
                            Color(_selectedColor),
                            56,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                AnimatedReveal(
                  delay: const Duration(milliseconds: 90),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: theme.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () => _showPillConstructorModal(l10n),
                        icon: Icon(
                          Icons.palette_rounded,
                          size: 18,
                          color: theme.primaryColor,
                        ),
                        label: Text(
                          l10n.customizePillTitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary
                              .withValues(alpha: 0.1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 18,
                          color: theme.colorScheme.secondary,
                        ),
                        label: Text(
                          l10n.addPhotoLabel,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                AnimatedReveal(
                  delay: const Duration(milliseconds: 120),
                  child: _buildKindSelector(theme, l10n),
                ),

                // 🚀 ВЕРНУЛ БЛОК ШАБЛОНОВ СЮДА
                const SizedBox(height: 24),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 130),
                  child: _buildTemplatesSection(theme, l10n),
                ),

                const SizedBox(height: 24),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _buildSectionHeader(l10n.overview, step: '1'),
                ),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 180),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(20),
                    color: theme.colorScheme.surface.withValues(alpha: 0.45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPremiumTextField(
                          controller: _nameController,
                          label: nameHint,
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.formTitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildScrollableChips<MedicineFormEnum>(
                          items: MedicineFormEnum.values,
                          selectedValue: _selectedForm,
                          labelBuilder: l10n.medicineFormLabel,
                          onSelected: (val) =>
                              setState(() => _selectedForm = val),
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (_selectedFrequency !=
                                FrequencyTypeEnum.tapering) ...[
                              Expanded(
                                flex: 2,
                                child: _buildPremiumTextField(
                                  controller: _dosageController,
                                  label: l10n.dosageHint,
                                  theme: theme,
                                  keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              flex: 3,
                              child: _buildScrollableChips<String>(
                                items: _units,
                                selectedValue: _selectedUnit,
                                labelBuilder: l10n.dosageUnitLabel,
                                onSelected: (val) =>
                                    setState(() => _selectedUnit = val),
                                theme: theme,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                _buildSectionHeader(l10n.scheduleAndRules, step: '2'),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScrollableChips<FrequencyTypeEnum>(
                        items: FrequencyTypeEnum.values,
                        selectedValue: _selectedFrequency,
                        labelBuilder: l10n.frequencyLabel,
                        onSelected: (val) =>
                            setState(() => _selectedFrequency = val),
                        theme: theme,
                      ),

                      if (_selectedFrequency == FrequencyTypeEnum.interval) ...[
                        const SizedBox(height: 16),
                        _buildSmartCounter(
                          label: l10n.everyXDays,
                          value: _intervalDays,
                          onDecrement: () {
                            if (_intervalDays > 1) {
                              setState(() => _intervalDays--);
                            }
                          },
                          onIncrement: () => setState(() => _intervalDays++),
                          theme: theme,
                        ),
                      ],

                      if (_selectedFrequency == FrequencyTypeEnum.asNeeded) ...[
                        const SizedBox(height: 16),
                        _buildSmartCounter(
                          label: l10n.maxDosesPerDay,
                          value: _prnMaxDoses,
                          onDecrement: () {
                            if (_prnMaxDoses > 1) {
                              setState(() => _prnMaxDoses--);
                            }
                          },
                          onIncrement: () => setState(() => _prnMaxDoses++),
                          theme: theme,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.overdoseWarning,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      if (_selectedFrequency == FrequencyTypeEnum.tapering) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.route_rounded, color: theme.primaryColor),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Сложный курс: настройте дозировку и время приема отдельно для каждого этапа.',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        ...List.generate(_complexSteps.length, (index) {
                          final step = _complexSteps[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.primaryColor.withValues(alpha: 0.15),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        l10n.stepNumber(index + 1),
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (_complexSteps.length > 1)
                                      GestureDetector(
                                        onTap: () => setState(() => _complexSteps.removeAt(index)),
                                        child: Icon(Icons.close_rounded, color: theme.colorScheme.error, size: 24),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildSmartCounter(
                                  label: l10n.duration,
                                  value: step.durationDays,
                                  suffix: l10n.daysSuffix,
                                  onDecrement: () {
                                    if (step.durationDays > 1) {
                                      setState(() => step.durationDays--);
                                    }
                                  },
                                  onIncrement: () => setState(() => step.durationDays++),
                                  theme: theme,
                                ),
                                const SizedBox(height: 8),
                                _buildDoubleSmartCounter(
                                  label: l10n.doseForStep,
                                  value: step.dosage,
                                  suffix: _selectedUnit,
                                  onDecrement: () {
                                    if (step.dosage > 0.25) {
                                      setState(() => step.dosage -= 0.5);
                                    }
                                  },
                                  onIncrement: () => setState(() => step.dosage += 0.5),
                                  theme: theme,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Divider(color: theme.dividerColor.withValues(alpha: 0.1)),
                                ),
                                Text(
                                  'Время приема на этом этапе',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ...List.generate(step.times.length, (timeIndex) {
                                      final time = step.times[timeIndex];
                                      return _TimeChip(
                                        label: time.format(context),
                                        onTap: () async {
                                          final newTime = await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                          );
                                          if (newTime != null) {
                                            setState(() => step.times[timeIndex] = newTime);
                                          }
                                        },
                                        onRemove: step.times.length > 1
                                            ? () => setState(() => step.times.removeAt(timeIndex))
                                            : null,
                                      );
                                    }),
                                    ActionChip(
                                      label: Text(l10n.addTime),
                                      avatar: Icon(Icons.add_rounded, size: 16, color: theme.colorScheme.onPrimary),
                                      backgroundColor: theme.primaryColor,
                                      labelStyle: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w700),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999), side: BorderSide.none),
                                      onPressed: () async {
                                        final newTime = await showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(hour: 8, minute: 0),
                                        );
                                        if (newTime != null) {
                                          setState(() {
                                            step.times.add(newTime);
                                            _sortTimes(step.times);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        InkWell(
                          onTap: () => setState(
                                () => _complexSteps.add(
                              _ComplexCourseStep(
                                durationDays: 3,
                                dosage: 1.0,
                                times: [const TimeOfDay(hour: 8, minute: 0)],
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_rounded, color: theme.primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.addStep,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          height: 1,
                          color: theme.dividerColor.withValues(alpha: 0.1),
                        ),
                      ),
                      Text(
                        l10n.foodInstructionTitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildScrollableChips<FoodInstructionEnum>(
                        items: FoodInstructionEnum.values,
                        selectedValue: _selectedFood,
                        labelBuilder: l10n.foodInstructionLabel,
                        onSelected: (val) =>
                            setState(() => _selectedFood = val),
                        theme: theme,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                _buildSectionHeader(l10n.inventory, step: '3'),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      if (_selectedFrequency != FrequencyTypeEnum.tapering) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.lifetimeCourse,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Switch.adaptive(
                              value: _isLifetime,
                              activeTrackColor: theme.primaryColor,
                              onChanged: (val) =>
                                  setState(() => _isLifetime = val),
                            ),
                          ],
                        ),
                        if (!_isLifetime) ...[
                          const SizedBox(height: 16),
                          _buildRouletteField(
                            label: l10n.courseDuration,
                            valueText: '$_durationDays ${l10n.daysSuffix}',
                            theme: theme,
                            onTap: () => _showRoulettePicker(
                              title: l10n.courseDuration,
                              l10n: l10n,
                              initialValue: _durationDays,
                              min: 1,
                              max: 365,
                              suffix: l10n.daysSuffix,
                              onChanged: (val) =>
                                  setState(() => _durationDays = val),
                            ),
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            height: 1,
                            color: theme.dividerColor.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                      _buildRouletteField(
                        label: l10n.pillsInPackage,
                        valueText: '$_pillsInPackage $inventoryUnit',
                        theme: theme,
                        onTap: () => _showRoulettePicker(
                          title: l10n.pillsInPackage,
                          l10n: l10n,
                          initialValue: _pillsInPackage,
                          min: 1,
                          max: 5000,
                          suffix: inventoryUnit,
                          onChanged: (val) =>
                              setState(() => _pillsInPackage = val),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                if (_selectedFrequency != FrequencyTypeEnum.asNeeded &&
                    _selectedFrequency != FrequencyTypeEnum.tapering) ...[
                  _buildSectionHeader(l10n.reminders, step: '4'),
                  GlassContainer(
                    padding: const EdgeInsets.all(20),
                    color: theme.colorScheme.surface.withValues(alpha: 0.45),
                    child: Column(
                      children: [
                        ...List.generate(_selectedTimes.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: _selectedTimes[index],
                                      );
                                      if (time != null) {
                                        setState(
                                              () => _selectedTimes[index] = time,
                                        );
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface
                                            .withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.alarm_rounded,
                                                color: theme.primaryColor,
                                                size: 22,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                l10n.doseNumber(index + 1),
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            _selectedTimes[index].format(
                                              context,
                                            ),
                                            style: theme.textTheme.titleLarge
                                                ?.copyWith(
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (_selectedTimes.length > 1) ...[
                                  const SizedBox(width: 8),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: theme.colorScheme.error
                                          .withValues(alpha: 0.1),
                                    ),
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: theme.colorScheme.error,
                                    ),
                                    onPressed: () => _removeTime(index),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }),
                        InkWell(
                          onTap: _addTime,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.addTime,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Text(
              l10n.saveAction,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const _TimeChip({
    required this.label,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (onRemove != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: theme.primaryColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _KindOptionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _KindOptionButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor
              : theme.colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurface.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}