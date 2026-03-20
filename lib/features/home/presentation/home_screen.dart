import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';

import 'widgets/horizontal_calendar.dart';
import 'widgets/dose_card.dart';
import 'widgets/sos_panel.dart';
import '../providers/home_provider.dart';
import '../../medicine_management/presentation/add_medicine_screen.dart';
// 🚀 ДОБАВЛЕН ИМПОРТ НАШЕЙ НОВОЙ МОДАЛКИ:
import '../../measurements/presentation/widgets/add_measurement_modal.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheduleAsyncValue = ref.watch(dailyScheduleProvider);

    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    const glassNavHeight = 85.0;
    final totalBottomPadding = glassNavHeight + bottomSafeArea + 100.0;

    return GradientScaffold(
      // 🚀 ПРЕМИУМ UX: Контент заезжает прямо под прозрачный статус-бар
      extendBodyBehindAppBar: true,

      body: CustomScrollView(
        // Плавный "резиновый" скролл как в iOS
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [

          // 🚀 СУПЕР-СОВРЕМЕННЫЙ SliverAppBar
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // ВАЖНО: Центрируем текст внутри расширяющегося бара
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                l10n.todaySchedule,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center, // Надежная страховка
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor,
                      theme.scaffoldBackgroundColor.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                child: CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  radius: 22,
                  child: IconButton(
                    icon: Icon(Icons.person_outline, color: theme.primaryColor),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.profileTitle)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // Календарь
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
              child: HorizontalCalendar(),
            ),
          ),

          // SOS Панель
          const SliverToBoxAdapter(
            child: SosPanel(),
          ),

          // Список таблеток
          scheduleAsyncValue.when(
            data: (scheduleItems) {
              if (scheduleItems.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 64,
                            color: theme.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l10n.emptySchedule,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 120), // Место под кнопку
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: totalBottomPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DoseCard(item: scheduleItems[index]),
                      );
                    },
                    childCount: scheduleItems.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // 🚀 НОВОЕ: Две левитирующие кнопки (Замеры здоровья и Лекарства)
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: glassNavHeight + 24, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Кнопка "Замеры здоровья"
            FloatingActionButton.small(
              heroTag: 'measurements_btn',
              elevation: 4,
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const AddMeasurementModal(),
                );
              },
              child: const Icon(Icons.monitor_heart),
            ),
            const SizedBox(height: 12),
            // Основная кнопка "Добавить лекарство"
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: FloatingActionButton(
                heroTag: 'medicine_btn',
                elevation: 0,
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddMedicineScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.add, size: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}