import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart'; // 🚀 ПАКЕТ ДЛЯ КАМЕРЫ
import '../../../l10n/app_localizations.dart';
import '../../home/providers/home_controller.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';

class AddMedicineScreen extends ConsumerStatefulWidget {
  const AddMedicineScreen({super.key});

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

  MedicineFormEnum _selectedForm = MedicineFormEnum.pill;
  String _selectedUnit = 'mg';
  FrequencyTypeEnum _selectedFrequency = FrequencyTypeEnum.daily;
  FoodInstructionEnum _selectedFood = FoodInstructionEnum.noMatter;

  final List<TimeOfDay> _selectedTimes = [const TimeOfDay(hour: 8, minute: 0)];
  final List<String> _units = ['mg', 'ml', 'pcs', 'drops', 'g', 'mcg'];

  // Стейт Визуального Конструктора
  PillShapeEnum _selectedShape = PillShapeEnum.circle;
  int _selectedColor = 0xFF2196F3;

  // 🚀 НОВОЕ: Стейт для реального фото
  String? _pillImagePath;

  final List<TaperingStep> _taperingSteps = [
    TaperingStep()..durationDays = 3..dosage = 1.0
  ];

  final List<int> _availableColors = [
    0xFF2196F3, 0xFFF44336, 0xFF4CAF50, 0xFFFF9800, 0xFF9C27B0,
    0xFFE91E63, 0xFF00BCD4, 0xFF795548, 0xFF607D8B, 0xFF000000,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  // 🚀 НОВОЕ: Метод для работы с камерой
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85, // Оптимизируем размер
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

  Widget _buildPillShape(PillShapeEnum shape, Color color, double size) {
    switch (shape) {
      case PillShapeEnum.circle: return Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
      case PillShapeEnum.capsule: return Container(width: size * 1.5, height: size * 0.6, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)));
      case PillShapeEnum.oval: return Container(width: size * 1.2, height: size * 0.8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.elliptical(size * 1.2, size * 0.8))));
      case PillShapeEnum.square: return Container(width: size * 0.9, height: size * 0.9, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.2)));
      case PillShapeEnum.diamond: return Transform.rotate(angle: 0.785398, child: Container(width: size * 0.75, height: size * 0.75, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.15))));
    }
  }

  void _showPillConstructorModal(AppLocalizations l10n) {
    PillShapeEnum tempShape = _selectedShape;
    int tempColor = _selectedColor;

    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent, isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          final theme = Theme.of(context);
          return Container(
            height: 450,
            decoration: BoxDecoration(color: theme.scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.customizePillTitle, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedShape = tempShape;
                            _selectedColor = tempColor;
                            _pillImagePath = null; // 🚀 Сбрасываем фото, если выбрали 3D-конструктор
                          });
                          Navigator.pop(ctx);
                        },
                        child: Text(l10n.doneAction, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      )
                    ],
                  ),
                ),
                Container(height: 1, color: theme.dividerColor.withValues(alpha: 0.1)),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 100, width: 100,
                    decoration: BoxDecoration(color: theme.colorScheme.surface, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(tempColor).withValues(alpha: 0.25), blurRadius: 24, spreadRadius: 2)]),
                    child: Center(child: _buildPillShape(tempShape, Color(tempColor), 48)),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(l10n.shape, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)))),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: PillShapeEnum.values.map((shape) {
                      final isSelected = shape == tempShape;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempShape = shape),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12), width: 56, height: 56,
                          decoration: BoxDecoration(color: isSelected ? theme.primaryColor.withValues(alpha: 0.1) : theme.colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: isSelected ? theme.primaryColor : theme.dividerColor.withValues(alpha: 0.1), width: 2)),
                          child: Center(child: _buildPillShape(shape, isSelected ? theme.primaryColor : theme.colorScheme.onSurface.withValues(alpha: 0.3), 24)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(l10n.color, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)))),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _availableColors.map((colorHex) {
                      final isSelected = colorHex == tempColor;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempColor = colorHex),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12), width: 48, height: 48,
                          decoration: BoxDecoration(color: Color(colorHex), shape: BoxShape.circle, border: Border.all(color: isSelected ? theme.colorScheme.onSurface : Colors.transparent, width: 3), boxShadow: [BoxShadow(color: Color(colorHex).withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))]),
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

  void _showRoulettePicker({required String title, required int initialValue, required int min, required int max, required String suffix, required ValueChanged<int> onChanged, required AppLocalizations l10n}) {
    int tempValue = initialValue;
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: 320, decoration: BoxDecoration(color: theme.scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  TextButton(onPressed: () { onChanged(tempValue); Navigator.pop(ctx); }, child: Text(l10n.doneAction, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)))
                ],
              ),
            ),
            Container(height: 1, color: theme.dividerColor.withValues(alpha: 0.1)),
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialValue - min), itemExtent: 48,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(background: theme.primaryColor.withValues(alpha: 0.1)),
                onSelectedItemChanged: (index) { tempValue = min + index; },
                children: List.generate(max - min + 1, (index) { return Center(child: Text('${min + index} $suffix', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600))); }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTime() => setState(() => _selectedTimes.add(const TimeOfDay(hour: 20, minute: 0)));
  void _removeTime(int index) { if (_selectedTimes.length > 1) setState(() => _selectedTimes.removeAt(index)); }

  void _save() async {
    final name = _nameController.text.trim();
    final l10n = AppLocalizations.of(context)!;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.errorEmptyFields)));
      return;
    }

    double dosageToSave = 0.0;
    int durationToSave = _durationDays;

    if (_selectedFrequency == FrequencyTypeEnum.tapering) {
      if (_taperingSteps.isEmpty) return;
      dosageToSave = _taperingSteps.first.dosage;
      durationToSave = _taperingSteps.fold(0, (sum, step) => sum + step.durationDays);
    } else {
      final dosageText = _dosageController.text.trim();
      if (dosageText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.errorEmptyFields)));
        return;
      }
      dosageToSave = double.tryParse(dosageText) ?? 0.0;
      durationToSave = _isLifetime ? 3650 : _durationDays;
    }

    final title = l10n.notificationTitle(name);
    final body = l10n.notificationBody('$dosageToSave $_selectedUnit');

    await ref.read(homeControllerProvider).addMedicineAndGenerateSchedule(
      name: name,
      dosage: dosageToSave,
      dosageUnit: _selectedUnit,
      form: _selectedForm,
      frequency: _selectedFrequency,
      foodInstruction: _selectedFood,
      times: _selectedTimes,
      durationDays: durationToSave,
      pillsInPackage: _pillsInPackage,
      intervalDays: _selectedFrequency == FrequencyTypeEnum.interval ? _intervalDays : null,
      prnMaxDailyDoses: _selectedFrequency == FrequencyTypeEnum.asNeeded ? _prnMaxDoses : null,
      taperingSteps: _selectedFrequency == FrequencyTypeEnum.tapering ? _taperingSteps : null,
      pillShape: _selectedShape,
      pillColor: _selectedColor,
      pillImagePath: _pillImagePath, // 🚀 ПЕРЕДАЕМ ФОТО В БАЗУ
      notificationTitle: title,
      notificationBody: body,
    );

    if (mounted) Navigator.of(context).pop();
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface)),
    );
  }

  Widget _buildPremiumTextField({required TextEditingController controller, required String label, required ThemeData theme, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller, keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label, labelStyle: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
        filled: true, fillColor: theme.colorScheme.surface.withValues(alpha: 0.45),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }

  Widget _buildRouletteField({required String label, required String valueText, required VoidCallback onTap, required ThemeData theme}) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7), fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(valueText, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: theme.primaryColor)),
                const SizedBox(width: 8),
                Icon(Icons.unfold_more_rounded, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartCounter({required String label, required int value, required VoidCallback onDecrement, required VoidCallback onIncrement, required ThemeData theme, String? suffix}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7), fontWeight: FontWeight.w600))),
          Row(
            children: [
              GestureDetector(onTap: onDecrement, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.remove_rounded, size: 20, color: theme.colorScheme.onSurface))),
              const SizedBox(width: 16),
              Text('$value${suffix != null ? ' $suffix' : ''}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: theme.primaryColor)),
              const SizedBox(width: 16),
              GestureDetector(onTap: onIncrement, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.add_rounded, size: 20, color: theme.primaryColor))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleSmartCounter({required String label, required double value, required VoidCallback onDecrement, required VoidCallback onIncrement, required ThemeData theme, String? suffix}) {
    String displayValue = value % 1 == 0 ? value.toInt().toString() : value.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7), fontWeight: FontWeight.w600))),
          Row(
            children: [
              GestureDetector(onTap: onDecrement, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.remove_rounded, size: 20, color: theme.colorScheme.onSurface))),
              const SizedBox(width: 16),
              Text('$displayValue${suffix != null ? ' $suffix' : ''}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: theme.primaryColor)),
              const SizedBox(width: 16),
              GestureDetector(onTap: onIncrement, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.add_rounded, size: 20, color: theme.primaryColor))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableChips<T>({required List<T> items, required T selectedValue, required String Function(T) labelBuilder, required void Function(T) onSelected, required ThemeData theme}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.map((item) {
          final isSelected = item == selectedValue;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(labelBuilder(item)), selected: isSelected, onSelected: (_) => onSelected(item),
              selectedColor: theme.primaryColor, backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.45),
              labelStyle: TextStyle(color: isSelected ? Colors.white : theme.colorScheme.onSurface.withValues(alpha: 0.7), fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide.none),
              showCheckmark: false, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true, expandedHeight: 100.0, floating: false, pinned: true, backgroundColor: Colors.transparent, elevation: 0,
            iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(l10n.addMedicationTitle, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface)),
              background: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [theme.scaffoldBackgroundColor.withValues(alpha: 0.9), theme.scaffoldBackgroundColor.withValues(alpha: 0.0)]))),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // 🚀 БЛОК: ФОТО ИЛИ КОНСТРУКТОР
                Center(
                  child: GestureDetector(
                    onTap: () => _showPillConstructorModal(l10n),
                    child: Container(
                      height: 120, width: 120,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(_selectedColor).withValues(alpha: 0.5), width: 3),
                        boxShadow: [BoxShadow(color: Color(_selectedColor).withValues(alpha: 0.2), blurRadius: 20, spreadRadius: 2)],
                      ),
                      child: _pillImagePath != null
                          ? ClipOval(
                        child: Image.file(
                          File(_pillImagePath!),
                          width: 120, height: 120, fit: BoxFit.cover,
                        ),
                      )
                          : Center(child: _buildPillShape(_selectedShape, Color(_selectedColor), 56)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🚀 ДВЕ КНОПКИ: Конструктор ИЛИ Камера
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(backgroundColor: theme.primaryColor.withValues(alpha: 0.1), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                      onPressed: () => _showPillConstructorModal(l10n),
                      icon: Icon(Icons.palette_rounded, size: 18, color: theme.primaryColor),
                      label: Text(l10n.customizePill, style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      style: TextButton.styleFrom(backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt_rounded, size: 18, color: theme.colorScheme.secondary),
                      label: Text("Photo", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // --- BENTO БЛОК 1: ОСНОВНОЕ ---
                _buildSectionHeader(l10n.overview),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPremiumTextField(controller: _nameController, label: l10n.medicineNameHint, theme: theme),
                      const SizedBox(height: 16),
                      Text(l10n.formTitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildScrollableChips<MedicineFormEnum>(
                        items: MedicineFormEnum.values, selectedValue: _selectedForm,
                        labelBuilder: (form) => form.name.toUpperCase(),
                        onSelected: (val) => setState(() => _selectedForm = val), theme: theme,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          if (_selectedFrequency != FrequencyTypeEnum.tapering) ...[
                            Expanded(flex: 2, child: _buildPremiumTextField(controller: _dosageController, label: l10n.dosageHint, theme: theme, keyboardType: const TextInputType.numberWithOptions(decimal: true))),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            flex: 3,
                            child: _buildScrollableChips<String>(
                              items: _units, selectedValue: _selectedUnit,
                              labelBuilder: (unit) => unit,
                              onSelected: (val) => setState(() => _selectedUnit = val), theme: theme,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // --- BENTO БЛОК 2: ПРАВИЛА ---
                _buildSectionHeader(l10n.scheduleAndRules),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScrollableChips<FrequencyTypeEnum>(
                        items: FrequencyTypeEnum.values, selectedValue: _selectedFrequency,
                        labelBuilder: (freq) => freq == FrequencyTypeEnum.tapering ? l10n.taperingFrequency : freq.name.toUpperCase(),
                        onSelected: (val) => setState(() => _selectedFrequency = val), theme: theme,
                      ),

                      if (_selectedFrequency == FrequencyTypeEnum.interval) ...[
                        const SizedBox(height: 16),
                        _buildSmartCounter(label: l10n.everyXDays, value: _intervalDays, onDecrement: () { if (_intervalDays > 1) setState(() => _intervalDays--); }, onIncrement: () => setState(() => _intervalDays++), theme: theme),
                      ],

                      if (_selectedFrequency == FrequencyTypeEnum.asNeeded) ...[
                        const SizedBox(height: 16),
                        _buildSmartCounter(label: l10n.maxDosesPerDay, value: _prnMaxDoses, onDecrement: () { if (_prnMaxDoses > 1) setState(() => _prnMaxDoses--); }, onIncrement: () => setState(() => _prnMaxDoses++), theme: theme),
                        const SizedBox(height: 8),
                        Text(l10n.overdoseWarning, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.w600)),
                      ],

                      if (_selectedFrequency == FrequencyTypeEnum.tapering) ...[
                        const SizedBox(height: 16),
                        ...List.generate(_taperingSteps.length, (index) {
                          final step = _taperingSteps[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: theme.dividerColor.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(l10n.stepNumber(index + 1), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: theme.primaryColor)),
                                    if (_taperingSteps.length > 1)
                                      GestureDetector(onTap: () => setState(() => _taperingSteps.removeAt(index)), child: Icon(Icons.close_rounded, color: theme.colorScheme.error, size: 20))
                                  ],
                                ),
                                const SizedBox(height: 12),
                                _buildSmartCounter(
                                  label: l10n.duration, value: step.durationDays, suffix: l10n.daysSuffix,
                                  onDecrement: () { if (step.durationDays > 1) setState(() => step.durationDays--); },
                                  onIncrement: () => setState(() => step.durationDays++), theme: theme,
                                ),
                                const SizedBox(height: 8),
                                _buildDoubleSmartCounter(
                                  label: l10n.doseForStep, value: step.dosage, suffix: _selectedUnit,
                                  onDecrement: () { if (step.dosage > 0.25) setState(() => step.dosage -= 0.5); },
                                  onIncrement: () => setState(() => step.dosage += 0.5), theme: theme,
                                ),
                              ],
                            ),
                          );
                        }),
                        InkWell(
                          onTap: () => setState(() => _taperingSteps.add(TaperingStep()..durationDays = 3..dosage = 1.0)),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_rounded, color: theme.primaryColor), const SizedBox(width: 8),
                                Text(l10n.addStep, style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                        ),
                      ],

                      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Container(height: 1, color: theme.dividerColor.withValues(alpha: 0.1))),
                      Text(l10n.foodInstructionTitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      _buildScrollableChips<FoodInstructionEnum>(
                        items: FoodInstructionEnum.values, selectedValue: _selectedFood,
                        labelBuilder: (food) => food.name,
                        onSelected: (val) => setState(() => _selectedFood = val), theme: theme,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // --- BENTO БЛОК 3: ИНВЕНТАРЬ ---
                _buildSectionHeader(l10n.inventory),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      if (_selectedFrequency != FrequencyTypeEnum.tapering) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.lifetimeCourse, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                            Switch.adaptive(value: _isLifetime, activeColor: theme.primaryColor, onChanged: (val) => setState(() => _isLifetime = val)),
                          ],
                        ),
                        if (!_isLifetime) ...[
                          const SizedBox(height: 16),
                          _buildRouletteField(
                            label: l10n.courseDuration, valueText: '$_durationDays ${l10n.daysSuffix}', theme: theme,
                            onTap: () => _showRoulettePicker(title: l10n.courseDuration, l10n: l10n, initialValue: _durationDays, min: 1, max: 365, suffix: l10n.daysSuffix, onChanged: (val) => setState(() => _durationDays = val)),
                          ),
                        ],
                        Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Container(height: 1, color: theme.dividerColor.withValues(alpha: 0.1))),
                      ],
                      _buildRouletteField(
                        label: l10n.pillsInPackage, valueText: '$_pillsInPackage ${l10n.pcsSuffix}', theme: theme,
                        onTap: () => _showRoulettePicker(title: l10n.pillsInPackage, l10n: l10n, initialValue: _pillsInPackage, min: 1, max: 1000, suffix: l10n.pcsSuffix, onChanged: (val) => setState(() => _pillsInPackage = val)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // --- BENTO БЛОК 4: ВРЕМЯ ---
                if (_selectedFrequency != FrequencyTypeEnum.asNeeded) ...[
                  _buildSectionHeader(l10n.reminders),
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
                                      final time = await showTimePicker(context: context, initialTime: _selectedTimes[index]);
                                      if (time != null) setState(() => _selectedTimes[index] = time);
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                      decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(16)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.alarm_rounded, color: theme.primaryColor, size: 22),
                                              const SizedBox(width: 12),
                                              Text(l10n.doseNumber(index + 1), style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                                            ],
                                          ),
                                          Text(_selectedTimes[index].format(context), style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (_selectedTimes.length > 1) ...[
                                  const SizedBox(width: 8),
                                  IconButton(
                                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1)),
                                    icon: Icon(Icons.close_rounded, color: theme.colorScheme.error),
                                    onPressed: () => _removeTime(index),
                                  ),
                                ]
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
                            decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_rounded, color: theme.primaryColor),
                                const SizedBox(width: 8),
                                Text(l10n.addTime, style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w800)),
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
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor, foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
            child: Text(l10n.saveAction, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
        ),
      ),
    );
  }
}