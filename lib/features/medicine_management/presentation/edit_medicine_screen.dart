import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // 🚀 ДОБАВЛЕН ИМПОРТ ДЛЯ РУЛЕТКИ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/providers/home_controller.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';

class EditMedicineScreen extends ConsumerStatefulWidget {
  final MedicineEntity medicine;

  const EditMedicineScreen({super.key, required this.medicine});

  @override
  ConsumerState<EditMedicineScreen> createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends ConsumerState<EditMedicineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dosageController;

  // 🚀 НОВОЕ: Стейт вместо текстовых контроллеров
  late int _pillsRemaining;
  late PillShapeEnum _selectedShape;
  late int _selectedColor;

  late MedicineFormEnum _selectedForm;
  late String _selectedUnit;
  late FoodInstructionEnum _selectedFood;

  final List<String> _units = ['mg', 'ml', 'pcs', 'drops', 'g', 'mcg'];

  final List<int> _availableColors = [
    0xFF2196F3, // Blue
    0xFFF44336, // Red
    0xFF4CAF50, // Green
    0xFFFF9800, // Orange
    0xFF9C27B0, // Purple
    0xFFE91E63, // Pink
    0xFF00BCD4, // Cyan
    0xFF795548, // Brown
    0xFF607D8B, // Blue Grey
    0xFF000000, // Black
  ];

  @override
  void initState() {
    super.initState();
    final rawDosage = widget.medicine.dosage;
    final dosageStr = rawDosage % 1 == 0 ? rawDosage.toInt().toString() : rawDosage.toString();

    _nameController = TextEditingController(text: widget.medicine.name);
    _dosageController = TextEditingController(text: dosageStr);

    // Инициализация умного стейта из базы
    _pillsRemaining = widget.medicine.pillsRemaining;
    _selectedShape = widget.medicine.pillShape;
    _selectedColor = widget.medicine.pillColor;

    _selectedForm = widget.medicine.form;
    _selectedUnit = widget.medicine.dosageUnit;
    _selectedFood = widget.medicine.foodInstruction;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  // 🚀 НОВОЕ: Рендерер геометрических форм таблетки
  Widget _buildPillShape(PillShapeEnum shape, Color color, double size) {
    switch (shape) {
      case PillShapeEnum.circle:
        return Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
      case PillShapeEnum.capsule:
        return Container(
          width: size * 1.5, height: size * 0.6,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
        );
      case PillShapeEnum.oval:
        return Container(
          width: size * 1.2, height: size * 0.8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.elliptical(size * 1.2, size * 0.8))),
        );
      case PillShapeEnum.square:
        return Container(
          width: size * 0.9, height: size * 0.9,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.2)),
        );
      case PillShapeEnum.diamond:
        return Transform.rotate(
          angle: 0.785398, // 45 градусов
          child: Container(
            width: size * 0.75, height: size * 0.75,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.15)),
          ),
        );
    }
  }

  // 🚀 НОВОЕ: Модальное окно Визуального Конструктора
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Customize Pill", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedShape = tempShape;
                            _selectedColor = tempColor;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Text(l10n.doneAction, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      )
                    ],
                  ),
                ),
                const Divider(height: 1),
                const SizedBox(height: 24),
                // Превью внутри модалки
                Center(
                  child: Container(
                    height: 100, width: 100,
                    decoration: BoxDecoration(
                      color: theme.cardColor, shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Color(tempColor).withOpacity(0.3), blurRadius: 20, spreadRadius: 2)],
                    ),
                    child: Center(child: _buildPillShape(tempShape, Color(tempColor), 48)),
                  ),
                ),
                const SizedBox(height: 32),

                // Выбор формы
                Text("Shape", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: PillShapeEnum.values.map((shape) {
                      final isSelected = shape == tempShape;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempShape = shape),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 56, height: 56,
                          decoration: BoxDecoration(
                            color: isSelected ? theme.primaryColor.withOpacity(0.1) : theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? theme.primaryColor : theme.dividerColor.withOpacity(0.1), width: 2),
                          ),
                          child: Center(child: _buildPillShape(shape, isSelected ? theme.primaryColor : theme.colorScheme.onSurface.withOpacity(0.3), 24)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Выбор цвета
                Text("Color", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _availableColors.map((colorHex) {
                      final isSelected = colorHex == tempColor;
                      return GestureDetector(
                        onTap: () => setModalState(() => tempColor = colorHex),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: Color(colorHex), shape: BoxShape.circle,
                            border: Border.all(color: isSelected ? theme.colorScheme.onSurface : Colors.transparent, width: 3),
                            boxShadow: [BoxShadow(color: Color(colorHex).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
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

  // 🚀 НОВОЕ: Модальное окно с рулеткой (CupertinoPicker)
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      onChanged(tempValue);
                      Navigator.pop(ctx);
                    },
                    child: Text(l10n.doneAction, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  )
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialValue - min),
                itemExtent: 48,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                onSelectedItemChanged: (index) {
                  tempValue = min + index;
                },
                children: List.generate(max - min + 1, (index) {
                  return Center(
                    child: Text(
                      '${min + index} $suffix',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
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

  void _saveChanges() async {
    final name = _nameController.text.trim();
    final dosageText = _dosageController.text.trim();
    final l10n = AppLocalizations.of(context)!;

    if (name.isEmpty || dosageText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.errorEmptyFields)));
      return;
    }

    final dosage = double.tryParse(dosageText) ?? 0.0;

    final title = l10n.notificationTitle(name);
    final body = l10n.notificationBody('$dosage $_selectedUnit');

    await ref.read(homeControllerProvider).updateMedicineDetails(
      medicine: widget.medicine,
      newName: name,
      newDosage: dosage,
      newDosageUnit: _selectedUnit,
      newForm: _selectedForm,
      newFoodInstruction: _selectedFood,
      newPillsRemaining: _pillsRemaining,
      newPillImagePath: null, // Игнорируем фото
      newNotificationTitle: title,
      newNotificationBody: body,
      newPillShape: _selectedShape, // 🚀 СОХРАНЯЕМ НОВУЮ ФОРМУ
      newPillColor: _selectedColor, // 🚀 СОХРАНЯЕМ НОВЫЙ ЦВЕТ
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  // ПРЕМИАЛЬНЫЙ ТЕКСТОВЫЙ ВВОД
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
        labelStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5)),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.4),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // 🚀 НОВОЕ: UI для поля с рулеткой
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
            Row(
              children: [
                Text(valueText, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                const SizedBox(width: 8),
                Icon(Icons.unfold_more, size: 20, color: theme.colorScheme.onSurface.withOpacity(0.3)),
              ],
            ),
          ],
        ),
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
              backgroundColor: theme.colorScheme.surface.withOpacity(0.4),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide.none),
              showCheckmark: false,
              elevation: isSelected ? 4 : 0,
              shadowColor: theme.primaryColor.withOpacity(0.4),
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
      // 🚀 ПРЕМИУМ UX: Фон заходит под аппбар
      extendBodyBehindAppBar: true,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 🚀 СОВРЕМЕННЫЙ SliverAppBar
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
                l10n.editCourse,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0.0)],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // 🚀 ВИЗУАЛЬНЫЙ КОНСТРУКТОР ТАБЛЕТКИ
                Center(
                  child: GestureDetector(
                    onTap: () => _showPillConstructorModal(l10n),
                    child: Container(
                      height: 110, width: 110,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withOpacity(0.5), shape: BoxShape.circle,
                        border: Border.all(color: Color(_selectedColor).withOpacity(0.5), width: 3),
                        boxShadow: [BoxShadow(color: Color(_selectedColor).withOpacity(0.2), blurRadius: 20, spreadRadius: 2)],
                      ),
                      child: Center(
                        child: _buildPillShape(_selectedShape, Color(_selectedColor), 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: () => _showPillConstructorModal(l10n),
                    icon: Icon(Icons.palette_outlined, size: 18, color: theme.primaryColor),
                    label: Text("Customize Appearance", style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),

                // --- BENTO БЛОК 1: ОСНОВНОЕ ---
                Text('Overview', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPremiumTextField(controller: _nameController, label: l10n.medicineNameHint, theme: theme),
                      const SizedBox(height: 16),
                      Text(l10n.formTitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                      const SizedBox(height: 8),
                      _buildScrollableChips<MedicineFormEnum>(
                        items: MedicineFormEnum.values,
                        selectedValue: _selectedForm,
                        labelBuilder: (form) => form.name.toUpperCase(),
                        onSelected: (val) => setState(() => _selectedForm = val),
                        theme: theme,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildPremiumTextField(controller: _dosageController, label: l10n.dosageHint, theme: theme, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: _buildScrollableChips<String>(
                              items: _units,
                              selectedValue: _selectedUnit,
                              labelBuilder: (unit) => unit,
                              onSelected: (val) => setState(() => _selectedUnit = val),
                              theme: theme,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- BENTO БЛОК 2: ДЕТАЛИ ---
                Text('Details', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.foodInstructionTitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                      const SizedBox(height: 8),
                      _buildScrollableChips<FoodInstructionEnum>(
                        items: FoodInstructionEnum.values,
                        selectedValue: _selectedFood,
                        labelBuilder: (food) => food.name,
                        onSelected: (val) => setState(() => _selectedFood = val),
                        theme: theme,
                      ),
                      const SizedBox(height: 16),

                      // 🚀 ИСПОЛЬЗУЕМ РУЛЕТКУ ДЛЯ ОСТАТКОВ
                      _buildRouletteField(
                        label: l10n.pillsRemaining,
                        valueText: '$_pillsRemaining pcs',
                        theme: theme,
                        onTap: () => _showRoulettePicker(
                          title: l10n.pillsRemaining,
                          l10n: l10n,
                          initialValue: _pillsRemaining,
                          min: 0,
                          max: 1000,
                          suffix: 'pcs',
                          onChanged: (val) => setState(() => _pillsRemaining = val),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120), // Пространство под плавающую кнопку
              ]),
            ),
          ),
        ],
      ),

      // 🚀 ПРЕМИАЛЬНАЯ ПЛАВАЮЩАЯ КНОПКА СОХРАНЕНИЯ
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: theme.primaryColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(l10n.saveChanges, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}