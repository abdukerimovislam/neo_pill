import 'package:flutter/material.dart';

import '../../../features/settings/provider/care_context_provider.dart';
import 'glass_container.dart';
import 'motion_pressable.dart';

class CareContextSwitcher extends StatelessWidget {
  final AppCareContext selectedContext;
  final String personalLabel;
  final String caregivingLabel;
  final ValueChanged<AppCareContext> onChanged;

  const CareContextSwitcher({
    super.key,
    required this.selectedContext,
    required this.personalLabel,
    required this.caregivingLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: const EdgeInsets.all(6),
      borderRadius: 20,
      color: theme.colorScheme.surface.withValues(alpha: 0.84),
      child: Row(
        children: [
          Expanded(
            child: _ContextChip(
              icon: Icons.person_rounded,
              label: personalLabel,
              selected: selectedContext == AppCareContext.myCare,
              selectedColor: theme.primaryColor,
              onTap: () => onChanged(AppCareContext.myCare),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ContextChip(
              icon: Icons.groups_rounded,
              label: caregivingLabel,
              selected: selectedContext == AppCareContext.caregiving,
              selectedColor: theme.colorScheme.tertiary,
              onTap: () => onChanged(AppCareContext.caregiving),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _ContextChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MotionPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      pressedScale: 0.99,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor
              : theme.colorScheme.surface.withValues(alpha: 0.34),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? Colors.white
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: selected
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
