import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  // 🚀 МОДАЛКА: СМЕНА ЯЗЫКА
  void _showLanguagePicker(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final currentLocale = ref.read(localeProvider);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Container(
          height: 250,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32))
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Text(l10n.language, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
                title: const Text("English", style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: currentLocale.languageCode == 'en' ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                onTap: () {
                  ref.read(localeProvider.notifier).state = const Locale('en');
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Text("🇷🇺", style: TextStyle(fontSize: 24)),
                title: const Text("Русский", style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: currentLocale.languageCode == 'ru' ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                onTap: () {
                  ref.read(localeProvider.notifier).state = const Locale('ru');
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        )
    );
  }

  // 🚀 МОДАЛКА: СМЕНА ИМЕНИ
  void _showNameEditor(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final currentName = ref.read(userNameProvider);
    final controller = TextEditingController(text: currentName);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.personalInfo, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 24),
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    hintText: "Enter your name",
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    ),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        ref.read(userNameProvider.notifier).state = controller.text.trim();
                      }
                      Navigator.pop(ctx);
                    },
                    child: const Text("Save", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;

    // 🚀 Читаем стейты
    final currentTheme = ref.watch(themeModeProvider);
    final isDark = currentTheme == ThemeMode.dark || (currentTheme == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    final currentLocale = ref.watch(localeProvider);
    final userName = ref.watch(userNameProvider);
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : "?";

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 118, pinned: true, elevation: 0, backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false, titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              title: Text(l10n.settingsTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface, letterSpacing: -0.4)),
              background: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [theme.scaffoldBackgroundColor.withValues(alpha: 0.92), theme.scaffoldBackgroundColor.withValues(alpha: 0.0)]))),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: bottomSafeArea + 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // 🚀 ИНТЕРАКТИВНЫЙ ПРОФИЛЬ
                GestureDetector(
                  onTap: () => _showNameEditor(context, ref, l10n),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(20),
                    color: theme.colorScheme.surface.withValues(alpha: 0.45),
                    child: Row(
                      children: [
                        Container(
                          width: 64, height: 64,
                          decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle, border: Border.all(color: theme.primaryColor.withValues(alpha: 0.3), width: 2)),
                          child: Center(child: Text(userInitial, style: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w900))),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userName, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 2),
                              Text(l10n.personalInfo, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                            ],
                          ),
                        ),
                        Icon(Icons.edit_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // --- НАСТРОЙКИ ПРИЛОЖЕНИЯ ---
                _SectionHeader(title: l10n.appPreferences),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: EdgeInsets.zero,
                  color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      // 🚀 ИНТЕРАКТИВНАЯ ТЕМА
                      _SettingsTile(
                        icon: Icons.dark_mode_rounded, iconColor: Colors.indigo, title: l10n.darkMode, theme: theme,
                        trailing: CupertinoSwitch(
                          value: isDark,
                          activeColor: theme.primaryColor, // Цвет нашего приложения, а не дефолтный зеленый
                          onChanged: (val) {
                            ref.read(themeModeProvider.notifier).state = val ? ThemeMode.dark : ThemeMode.light;
                          },
                        ),
                      ),
                      _Divider(theme: theme),
                      // 🚀 ИНТЕРАКТИВНЫЙ ЯЗЫК
                      _SettingsTile(
                        icon: Icons.language_rounded, iconColor: Colors.teal, title: l10n.language, theme: theme,
                        onTap: () => _showLanguagePicker(context, ref, l10n),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(currentLocale.languageCode == 'ru' ? "Русский" : "English", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5), fontWeight: FontWeight.w600)),
                            const SizedBox(width: 8),
                            Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                          ],
                        ),
                      ),
                      _Divider(theme: theme),
                      _SettingsTile(icon: Icons.notifications_active_rounded, iconColor: Colors.amber.shade700, title: l10n.notifications, theme: theme, trailing: Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3))),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                _SectionHeader(title: l10n.advancedFeatures),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: EdgeInsets.zero, color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      _SettingsTile(icon: Icons.group_rounded, iconColor: theme.primaryColor, title: l10n.caregivers, theme: theme, trailing: _ComingSoonBadge(theme: theme, l10n: l10n)),
                      _Divider(theme: theme),
                      _SettingsTile(icon: Icons.warning_rounded, iconColor: theme.colorScheme.error, title: l10n.drugInteractions, theme: theme, trailing: _ComingSoonBadge(theme: theme, l10n: l10n)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                _SectionHeader(title: l10n.supportAndAbout),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: EdgeInsets.zero, color: theme.colorScheme.surface.withValues(alpha: 0.45),
                  child: Column(
                    children: [
                      _SettingsTile(icon: Icons.help_outline_rounded, iconColor: Colors.blueGrey, title: l10n.contactSupport, theme: theme, trailing: Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3))),
                      _Divider(theme: theme),
                      _SettingsTile(icon: Icons.privacy_tip_outlined, iconColor: Colors.blueGrey, title: l10n.privacyPolicy, theme: theme, trailing: Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3))),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                Center(child: TextButton.icon(style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)), onPressed: () {}, icon: const Icon(Icons.logout_rounded), label: Text(l10n.logout, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)))),
                const SizedBox(height: 24),
                Center(child: Text("NeoPill v1.0.0", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.3), fontWeight: FontWeight.w600)))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)));
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget trailing;
  final ThemeData theme;
  final VoidCallback? onTap;

  const _SettingsTile({required this.icon, required this.iconColor, required this.title, required this.trailing, required this.theme, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 20)),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface))),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final ThemeData theme;
  const _Divider({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 68, right: 20), child: Container(height: 1, color: theme.dividerColor.withValues(alpha: 0.08)));
  }
}

class _ComingSoonBadge extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations l10n;
  const _ComingSoonBadge({required this.theme, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6), border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2))),
      child: Text(l10n.comingSoon, style: theme.textTheme.labelSmall?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w900, letterSpacing: 0.5, fontSize: 10)),
    );
  }
}