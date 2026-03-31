import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart'; // 🚀 Добавлен импорт для открытия ссылок

import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/care_context_switcher.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/firebase/caregiver_cloud_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../premium/presentation/premium_paywall_sheet.dart';
import '../../premium/provider/premium_provider.dart';
import '../provider/care_context_provider.dart';
import '../provider/caregiver_cloud_provider.dart';
import '../provider/caregiver_delivery_provider.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  // 🚀 ГЛОБАЛЬНЫЙ СПИСОК ЯЗЫКОВ
  // Все языки отображаются в их нативном написании для лучшего UX
  String _languageLabel(Locale locale) {
    return switch (locale.languageCode) {
      'ru' => 'Русский',
      'es' => 'Español',
      'fr' => 'Français',
      'de' => 'Deutsch',
      'ky' => 'Кыргызча',
      'kk' => 'Қазақша', // 🚀 Добавлен Казахский
      _ => 'English',
    };
  }

  // 🚀 Получаем список доступных языков прямо из провайдера, чтобы не дублировать код
  List<Locale> _getLanguageOptions() {
    // Если у тебя в LocaleNotifier есть статический список supportedLocales,
    // лучше использовать его. Но если нет, вот жесткий список:
    return const <Locale>[
      Locale('en'),
      Locale('ru'),
      Locale('es'),
      Locale('fr'),
      Locale('de'),
      Locale('ky'),
      Locale('kk'),
    ];
  }

  String _caregiverSubtitle(
      AppLocalizations l10n,
      CaregiverProfile? caregiver,
      ) {
    if (caregiver == null) {
      return l10n.settingsCaregiverEmpty;
    }
    if (caregiver.relation.isNotEmpty) {
      return '${caregiver.name} · ${caregiver.relation}';
    }
    return caregiver.name;
  }

  String _caregiverAlertsSubtitle(
      AppLocalizations l10n,
      CaregiverProfile? caregiver,
      CaregiverAlertSettings settings,
      ) {
    if (caregiver == null) {
      return l10n.settingsCaregiverAlertsEmpty;
    }
    if (!settings.enabled) {
      return l10n.settingsCaregiverAlertsDisabled;
    }
    return l10n.settingsCaregiverAlertsEnabledSummary(settings.graceMinutes);
  }

  String _caregiverConnectedSubtitle(
      AppLocalizations l10n,
      CaregiverCloudState cloudState,
      ) {
    if (cloudState.linkedPatients.isNotEmpty) {
      return cloudState.linkedPatients.map((p) => p.patientName).join(', ');
    }
    if (cloudState.hasPatientLink) {
      return l10n.settingsCaregiverConnectedModePatient;
    }
    return l10n.settingsCaregiverConnectedModeNone;
  }

  // 🚀 УНИВЕРСАЛЬНАЯ ЛОГИКА НАЖАТИЯ НА ПРЕМИУМ-ФУНКЦИИ
  void _onPremiumFeatureTap({
    required BuildContext context,
    required WidgetRef ref,
    required bool isPremium,
    required VoidCallback onAuthorized,
  }) {
    if (isPremium) {
      onAuthorized();
      return;
    }

    if (Platform.isAndroid) {
      // 🤖 ЗАГЛУШКА ДЛЯ ANDROID
      HapticFeedback.mediumImpact();
      final isRu = Localizations.localeOf(context).languageCode == 'ru';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.android_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(isRu
                    ? 'Pillora Pro для Android находится в разработке и скоро будет доступна!'
                    : 'Pillora Pro for Android is in development and will be available soon!'),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      // 🍎 iOS: ПОКАЗЫВАЕМ РЕАЛЬНЫЙ PAYWALL
      PremiumPaywallSheet.show(context);
    }
  }

  // 🚀 МЕТОД ДЛЯ ОТКРЫТИЯ ВНЕШНИХ ССЫЛОК В БРАУЗЕРЕ
  Future<void> _launchExternalUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showCaregiverSheet(
      BuildContext context,
      WidgetRef ref,
      AppLocalizations l10n,
      CaregiverProfile? existing,
      ) {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final relationController = TextEditingController(
      text: existing?.relation ?? '',
    );
    final phoneController = TextEditingController(text: existing?.phone ?? '');
    var shareReports = existing?.shareReports ?? true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsCaregiverTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.settingsCaregiverDescription,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l10n.settingsCaregiverName,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: relationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l10n.settingsCaregiverRelation,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: l10n.settingsCaregiverPhone,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassContainer(
                    padding: const EdgeInsets.all(14),
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.78),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.settingsCaregiverShareReports,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.settingsCaregiverShareReportsSubtitle,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        CupertinoSwitch(
                          value: shareReports,
                          activeTrackColor: Theme.of(context).primaryColor,
                          onChanged: (value) =>
                              setModalState(() => shareReports = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          return;
                        }
                        await ref.read(caregiverProfileProvider.notifier).save(
                          CaregiverProfile(
                            name: name,
                            relation: relationController.text.trim(),
                            phone: phoneController.text.trim(),
                            shareReports: shareReports,
                          ),
                        );
                        if (ctx.mounted) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.settingsCaregiverSaved),
                            ),
                          );
                        }
                      },
                      child: Text(l10n.settingsSave),
                    ),
                  ),
                  if (existing != null) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          await ref
                              .read(caregiverProfileProvider.notifier)
                              .clear();
                          if (ctx.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.settingsCaregiverRemoved),
                              ),
                            );
                          }
                        },
                        child: Text(l10n.settingsCaregiverRemove),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCaregiverAlertsSheet(
      BuildContext context,
      WidgetRef ref,
      AppLocalizations l10n,
      CaregiverProfile? caregiver,
      CaregiverAlertSettings settings,
      ) {
    if (caregiver == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsCaregiverAlertsEmpty)),
      );
      return;
    }

    var enabled = settings.enabled;
    var graceMinutes = settings.graceMinutes;
    var includeOverdue = settings.includeOverdue;
    var includeSkipped = settings.includeSkipped;
    var includeSupplements = settings.includeSupplements;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsCaregiverAlertsTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.settingsCaregiverAlertsDescription,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                  const SizedBox(height: 18),
                  GlassContainer(
                    padding: const EdgeInsets.all(14),
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.78),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.settingsCaregiverAlertsSwitchTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.settingsCaregiverAlertsSwitchSubtitle,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        CupertinoSwitch(
                          value: enabled,
                          activeTrackColor: Theme.of(context).primaryColor,
                          onChanged: (value) =>
                              setModalState(() => enabled = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.settingsCaregiverAlertsGraceTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.settingsCaregiverAlertsGraceDescription(graceMinutes),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [15, 30, 45, 60, 90].map((minutes) {
                      return ChoiceChip(
                        label: Text(
                          l10n.settingsCaregiverAlertsGraceChip(minutes),
                        ),
                        selected: graceMinutes == minutes,
                        onSelected: (_) =>
                            setModalState(() => graceMinutes = minutes),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  GlassContainer(
                    padding: const EdgeInsets.all(14),
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.78),
                    child: Column(
                      children: [
                        _SettingsToggleRow(
                          title: l10n.settingsCaregiverAlertsOverdueTitle,
                          subtitle: l10n.settingsCaregiverAlertsOverdueSubtitle,
                          value: includeOverdue,
                          onChanged: (value) =>
                              setModalState(() => includeOverdue = value),
                        ),
                        const SizedBox(height: 12),
                        _SettingsToggleRow(
                          title: l10n.settingsCaregiverAlertsSkippedTitle,
                          subtitle: l10n.settingsCaregiverAlertsSkippedSubtitle,
                          value: includeSkipped,
                          onChanged: (value) =>
                              setModalState(() => includeSkipped = value),
                        ),
                        const SizedBox(height: 12),
                        _SettingsToggleRow(
                          title: l10n.settingsCaregiverAlertsSupplementsTitle,
                          subtitle:
                          l10n.settingsCaregiverAlertsSupplementsSubtitle,
                          value: includeSupplements,
                          onChanged: (value) =>
                              setModalState(() => includeSupplements = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(caregiverAlertSettingsProvider.notifier)
                            .save(
                          CaregiverAlertSettings(
                            enabled: enabled,
                            graceMinutes: graceMinutes,
                            includeSkipped: includeSkipped,
                            includeOverdue: includeOverdue,
                            includeSupplements: includeSupplements,
                          ),
                        );
                        if (ctx.mounted) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.settingsCaregiverAlertsSaved),
                            ),
                          );
                        }
                      },
                      child: Text(l10n.settingsSave),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCaregiverConnectedSheet(
      BuildContext context,
      AppLocalizations l10n,
      CaregiverProfile? caregiver,
      String patientName,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Consumer(
        builder: (context, ref, child) {
          final cloudState = ref.watch(caregiverCloudProvider);
          final deliveryState = ref.watch(caregiverDeliveryProvider);
          final theme = Theme.of(context);

          return DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    l10n.settingsCaregiverConnectedTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.settingsCaregiverConnectedDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    l10n.settingsCaregiverConnectedCodeTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    color: theme.colorScheme.surface.withValues(alpha: 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectableText(
                              deliveryState.shareCode,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: deliveryState.shareCode),
                                );
                                if (ctx.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l10n.settingsCaregiverConnectedCodeCopied,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.copy_rounded, color: theme.primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.settingsCaregiverConnectedCodeSubtitle,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        if (cloudState.hasPatientLink) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.successAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_rounded, size: 16, color: theme.successAccent),
                                const SizedBox(width: 6),
                                Text(
                                  l10n.settingsCaregiverConnectedModePatient,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.successAccent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: theme.dangerAccent,
                                side: BorderSide(color: theme.dangerAccent.withValues(alpha: 0.5)),
                              ),
                              onPressed: () async {
                                await ref.read(caregiverCloudProvider.notifier).disconnectPatientMode();
                              },
                              child: Text(l10n.settingsCaregiverConnectedDisconnect),
                            ),
                          ),
                        ] else ...[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await ref
                                    .read(caregiverCloudProvider.notifier)
                                    .activatePatientMode(
                                  patientName: patientName,
                                  shareCode: deliveryState.shareCode,
                                  caregiver: caregiver,
                                );
                                if (ctx.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.settingsCaregiverConnectedPatientModeSaved),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.health_and_safety_rounded),
                              label: Text(l10n.settingsCaregiverConnectedUsePatientDevice),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    l10n.caregivers,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.warningAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    color: theme.colorScheme.surface.withValues(alpha: 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cloudState.linkedPatients.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              l10n.settingsCaregiverConnectedModeNone,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          )
                        else
                          ...cloudState.linkedPatients.map(
                                (patient) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: theme.warningAccent.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_rounded, color: theme.warningAccent),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.patientName,
                                            style: theme.textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            l10n.settingsCaregiverConnectedCloudCode(patient.shareCode),
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close_rounded, color: theme.dangerAccent),
                                      onPressed: () async {
                                        await ref.read(caregiverCloudProvider.notifier).disconnectFromPatient(patient.shareCode);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.warningAccent,
                              side: BorderSide(color: theme.warningAccent.withValues(alpha: 0.5)),
                            ),
                            onPressed: () async {
                              final codeController = TextEditingController(text: '');
                              final success = await showModalBottomSheet<bool>(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (sheetContext) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                                    decoration: BoxDecoration(
                                      color: theme.scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(32),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.settingsCaregiverConnectedJoinTitle,
                                          style: theme.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          l10n.settingsCaregiverConnectedJoinSubtitle,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: codeController,
                                          textCapitalization: TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            labelText: l10n.settingsCaregiverConnectedCodeTitle,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final ok = await ref
                                                  .read(caregiverCloudProvider.notifier)
                                                  .connectAsCaregiver(
                                                shareCode: codeController.text.trim().toUpperCase(),
                                                deviceName: patientName,
                                              );
                                              if (sheetContext.mounted) {
                                                Navigator.pop(sheetContext, ok);
                                              }
                                            },
                                            child: Text(l10n.settingsCaregiverConnectedJoinAction),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              if (ctx.mounted && success != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? l10n.settingsCaregiverConnectedCaregiverModeSaved
                                          : l10n.settingsCaregiverConnectedJoinFailed,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.link_rounded),
                            label: Text(l10n.settingsCaregiverConnectedUseCaregiverDevice),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (cloudState.hasPatientLink) ...[
                    const SizedBox(height: 32),
                    Text(
                      l10n.settingsCaregiverConnectedOutboxTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GlassContainer(
                      padding: const EdgeInsets.all(16),
                      color: theme.colorScheme.surface.withValues(alpha: 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deliveryState.pendingCount > 0
                                ? l10n.settingsCaregiverConnectedPending(deliveryState.pendingCount)
                                : l10n.settingsCaregiverConnectedReady,
                            style: theme.textTheme.bodyMedium,
                          ),
                          if (deliveryState.lastQueuedAt != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              l10n.settingsCaregiverConnectedLastQueued(
                                deliveryState.lastQueuedAt!.toLocal().toString(),
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                          if (deliveryState.pendingCount > 0) ...[
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await ref.read(caregiverDeliveryProvider.notifier).clearOutbox();
                                  if (ctx.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(l10n.settingsCaregiverConnectedOutboxCleared),
                                      ),
                                    );
                                  }
                                },
                                child: Text(l10n.settingsCaregiverConnectedClearOutbox),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSupportSheet(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    const supportEmail = 'englishmfdys@gmail.com'; // 🚀 Обновлен на реальный email

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsContactSupportTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.settingsContactSupportBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
            const SizedBox(height: 16),
            GlassContainer(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.surface.withValues(alpha: 0.78),
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline_rounded,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      supportEmail,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: supportEmail),
                  );
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.settingsSupportEmailCopied)),
                    );
                  }
                },
                child: Text(l10n.settingsCopySupportEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(
      BuildContext context,
      WidgetRef ref,
      AppLocalizations l10n,
      ) {
    final currentLocale = ref.read(localeProvider);
    final options = _getLanguageOptions();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Позволяет списку быть выше
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.6, // Динамическая высота
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                l10n.language,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final locale = options[index];
                  return ListTile(
                    leading: Icon(
                      Icons.language_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      _languageLabel(locale),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: currentLocale.languageCode == locale.languageCode
                        ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                        : null,
                    onTap: () async {
                      await ref.read(localeProvider.notifier).setLocale(locale);
                      if (ctx.mounted) {
                        Navigator.pop(ctx);
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.settingsLanguageChangeLater,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNameEditor(
      BuildContext context,
      WidgetRef ref,
      AppLocalizations l10n,
      ) {
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.personalInfo,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: l10n.settingsExampleName),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(userNameProvider.notifier)
                        .setUserName(controller.text.trim());
                    if (ctx.mounted) {
                      Navigator.pop(ctx);
                    }
                  },
                  child: Text(l10n.settingsSave),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    final currentTheme = ref.watch(themeModeProvider);
    final isDark = currentTheme == ThemeMode.dark;
    final currentLocale = ref.watch(localeProvider);
    final isRu = currentLocale.languageCode == 'ru';
    final userName = ref.watch(userNameProvider);
    final comfortMode = ref.watch(comfortModeProvider);
    final caregiver = ref.watch(caregiverProfileProvider);
    final caregiverAlerts = ref.watch(caregiverAlertSettingsProvider);
    final caregiverCloud = ref.watch(caregiverCloudProvider);
    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : '?';
    final cardOpacity = comfortMode ? 0.94 : 0.48;
    final hasCaregivingContext = caregiverCloud.hasCaregiverLink;
    final selectedContext = hasCaregivingContext
        ? ref.watch(selectedCareContextProvider)
        : AppCareContext.myCare;

    // ПОЛУЧАЕМ РЕАЛЬНЫЙ СТАТУС ПРЕМИУМА
    final isPremiumNow = ref.watch(premiumProvider);

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 118,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              title: Text(
                l10n.settingsTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.92),
                      theme.scaffoldBackgroundColor.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: bottomSafeArea + 100,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (hasCaregivingContext) ...[
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 30),
                    child: CareContextSwitcher(
                      selectedContext: selectedContext,
                      personalLabel: userName.isEmpty
                          ? l10n.defaultUserName
                          : userName,
                      caregivingLabel:
                      caregiverCloud.caregiverLinkedPatientName ??
                          l10n.settingsCaregiverConnectedTitle,
                      onChanged: (value) {
                        ref.read(selectedCareContextProvider.notifier).state =
                            value;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 45),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(14),
                      color: theme.colorScheme.surface.withValues(
                        alpha: cardOpacity,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color:
                              (selectedContext == AppCareContext.myCare
                                  ? theme.primaryColor
                                  : theme.warningAccent)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              selectedContext == AppCareContext.myCare
                                  ? Icons.person_rounded
                                  : Icons.groups_rounded,
                              color: selectedContext == AppCareContext.myCare
                                  ? theme.primaryColor
                                  : theme.warningAccent,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              selectedContext == AppCareContext.myCare
                                  ? l10n.settingsCaregiverConnectedModePatient
                                  : l10n.settingsCaregiverConnectedModeCaregiver(
                                caregiverCloud
                                    .caregiverLinkedPatientName ??
                                    l10n.defaultUserName,
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.74,
                                ),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                AnimatedReveal(
                  delay: const Duration(milliseconds: 50),
                  child: GestureDetector(
                    onTap: () => _showNameEditor(context, ref, l10n),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      color: theme.colorScheme.surface.withValues(
                        alpha: cardOpacity,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                userInitial,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  l10n.settingsYourProfilePreferences,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit_rounded,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 120),
                  child: _SectionHeader(title: l10n.appPreferences),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 150),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    color: theme.colorScheme.surface.withValues(
                      alpha: cardOpacity,
                    ),
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.dark_mode_rounded,
                          iconColor: Colors.indigo,
                          title: l10n.darkMode,
                          theme: theme,
                          trailing: CupertinoSwitch(
                            value: isDark,
                            activeTrackColor: theme.primaryColor,
                            onChanged: (val) {
                              ref
                                  .read(themeModeProvider.notifier)
                                  .setThemeMode(
                                val ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                          ),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.text_fields_rounded,
                          iconColor: theme.primaryColor,
                          title: l10n.settingsComfortModeTitle,
                          subtitle: l10n.settingsComfortModeSubtitle,
                          theme: theme,
                          trailing: CupertinoSwitch(
                            value: comfortMode,
                            activeTrackColor: theme.primaryColor,
                            onChanged: (val) {
                              ref
                                  .read(comfortModeProvider.notifier)
                                  .setComfortMode(val);
                            },
                          ),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.language_rounded,
                          iconColor: Colors.teal,
                          title: l10n.language,
                          theme: theme,
                          onTap: () => _showLanguagePicker(context, ref, l10n),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _languageLabel(currentLocale),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.55,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.notifications_active_rounded,
                          iconColor: Colors.amber.shade700,
                          title: l10n.notifications,
                          subtitle: l10n.settingsNotificationsEnabled,
                          theme: theme,
                          trailing: Text(
                            l10n.settingsOn,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.55,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 210),
                  child: _SectionHeader(title: l10n.settingsSupportAndSafety),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 240),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    color: theme.colorScheme.surface.withValues(
                      alpha: cardOpacity,
                    ),
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.restart_alt_rounded,
                          iconColor: Colors.teal,
                          title: l10n.settingsShowOnboardingAgain,
                          subtitle: l10n.settingsShowOnboardingAgainSubtitle,
                          theme: theme,
                          onTap: () async {
                            // 1. Сбрасываем флаг завершения в провайдере (и в SharedPreferences)
                            await ref.read(onboardingCompleteProvider.notifier).reset();

                            if (context.mounted) {
                              // 2. Делаем легкую вибрацию
                              HapticFeedback.mediumImpact();

                              // 3. Переходим на экран онбординга
                              // Используем pushAndRemoveUntil, чтобы нельзя было вернуться назад в настройки
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                                    (route) => false,
                              );
                            }
                          },
                          trailing: Icon(
                            Icons.chevron_right_rounded,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        _Divider(theme: theme),
                        // 🚀 ОПЕКУНЫ
                        _SettingsTile(
                          icon: Icons.group_rounded,
                          iconColor: theme.primaryColor,
                          title: l10n.caregivers,
                          subtitle: _caregiverSubtitle(l10n, caregiver),
                          theme: theme,
                          onTap: () => _onPremiumFeatureTap(
                            context: context,
                            ref: ref,
                            isPremium: isPremiumNow,
                            onAuthorized: () => _showCaregiverSheet(context, ref, l10n, caregiver),
                          ),
                          trailing: isPremiumNow
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (caregiver?.shareReports == true)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    l10n.settingsOn,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ],
                          )
                              : _PremiumBadge(theme: theme),
                        ),
                        _Divider(theme: theme),
                        // 🚀 АЛЕРТЫ
                        _SettingsTile(
                          icon: Icons.notifications_active_rounded,
                          iconColor: Colors.amber.shade700,
                          title: l10n.settingsCaregiverAlertsTitle,
                          subtitle: _caregiverAlertsSubtitle(
                            l10n,
                            caregiver,
                            caregiverAlerts,
                          ),
                          theme: theme,
                          onTap: () => _onPremiumFeatureTap(
                            context: context,
                            ref: ref,
                            isPremium: isPremiumNow,
                            onAuthorized: () => _showCaregiverAlertsSheet(context, ref, l10n, caregiver, caregiverAlerts),
                          ),
                          trailing: isPremiumNow
                              ? Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3))
                              : _PremiumBadge(theme: theme),
                        ),
                        _Divider(theme: theme),
                        // 🚀 ОБЛАЧНАЯ СВЯЗЬ
                        _SettingsTile(
                          icon: Icons.link_rounded,
                          iconColor: theme.primaryColor,
                          title: l10n.settingsCaregiverConnectedTitle,
                          subtitle: _caregiverConnectedSubtitle(
                            l10n,
                            caregiverCloud,
                          ),
                          theme: theme,
                          onTap: () => _onPremiumFeatureTap(
                            context: context,
                            ref: ref,
                            isPremium: isPremiumNow,
                            onAuthorized: () => _showCaregiverConnectedSheet(context, l10n, caregiver, userName),
                          ),
                          trailing: isPremiumNow
                              ? Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3))
                              : _PremiumBadge(theme: theme),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.warning_rounded,
                          iconColor: theme.colorScheme.error,
                          title: l10n.drugInteractions,
                          subtitle: l10n.settingsFeaturePolishing,
                          theme: theme,
                          trailing: _ComingSoonBadge(theme: theme, l10n: l10n),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 300),
                  child: _SectionHeader(title: l10n.supportAndAbout),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 330),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    color: theme.colorScheme.surface.withValues(
                      alpha: cardOpacity,
                    ),
                    child: Column(
                      children: [
                        // 🚀 КНОПКА ВОССТАНОВЛЕНИЯ ПОКУПОК (ТРЕБОВАНИЕ APPLE)
                        if (!isPremiumNow && Platform.isIOS) ...[
                          _SettingsTile(
                            icon: Icons.restore_rounded,
                            iconColor: theme.warningAccent,
                            title: l10n.premiumRestorePurchases,
                            theme: theme,
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              await ref.read(premiumProvider.notifier).restore();
                              if (context.mounted) {
                                final isPremiumAfter = ref.read(premiumProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isPremiumAfter ? 'Purchases restored!' : 'No active subscriptions found'),
                                  ),
                                );
                              }
                            },
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                          ),
                          _Divider(theme: theme),
                        ],
                        _SettingsTile(
                          icon: Icons.help_outline_rounded,
                          iconColor: Colors.blueGrey,
                          title: l10n.contactSupport,
                          subtitle: l10n.settingsSupportEmailSubtitle,
                          theme: theme,
                          onTap: () => _showSupportSheet(context, l10n),
                          trailing: Icon(
                            Icons.chevron_right_rounded,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.description_outlined,
                          iconColor: Colors.blueGrey,
                          title: isRu ? 'Пользовательское соглашение' : 'Terms of Use',
                          theme: theme,
                          onTap: () => _launchExternalUrl('https://sites.google.com/view/pillora-terms-of-use'),
                          trailing: Icon(
                            Icons.open_in_new_rounded,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        _Divider(theme: theme),
                        _SettingsTile(
                          icon: Icons.privacy_tip_outlined,
                          iconColor: Colors.blueGrey,
                          title: l10n.privacyPolicy,
                          subtitle: l10n.settingsPrivacySubtitle,
                          theme: theme,
                          onTap: () => _launchExternalUrl('https://sites.google.com/view/pillora-privacy-policy'),
                          trailing: Icon(
                            Icons.open_in_new_rounded,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 380),
                  child: Center(
                    child: Text(
                      'Pillora v1.0.1',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.35,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CupertinoSwitch(
          value: value,
          activeTrackColor: theme.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final ThemeData theme;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.trailing,
    required this.theme,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.55,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
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
    return Padding(
      padding: const EdgeInsets.only(left: 68, right: 16),
      child: Container(
        height: 1,
        color: theme.dividerColor.withValues(alpha: 0.08),
      ),
    );
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
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        l10n.comingSoon,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.primaryColor,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  final ThemeData theme;

  const _PremiumBadge({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.warningAccent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 14, color: theme.warningAccent),
          const SizedBox(width: 4),
          Text(
            'PRO',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.warningAccent,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}