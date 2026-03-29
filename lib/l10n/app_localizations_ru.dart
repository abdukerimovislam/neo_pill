// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Расписание на сегодня';

  @override
  String get architectureReady => 'Архитектура готова. Все системы в норме.';

  @override
  String get nextCreateHome => 'Далее: Создать главный экран';

  @override
  String get statusTaken => 'Принято';

  @override
  String get statusSkipped => 'Пропущено';

  @override
  String get statusSnoozed => 'Отложено на 10 мин';

  @override
  String get statusPending => 'Ожидает';

  @override
  String get emptySchedule => 'На этот день нет запланированных лекарств';

  @override
  String get takeAction => 'Принять';

  @override
  String get skipAction => 'Пропустить';

  @override
  String get dosageUnitMg => 'мг';

  @override
  String get dosageUnitMl => 'мл';

  @override
  String get dosageUnitDrops => 'кап.';

  @override
  String get dosageUnitPcs => 'шт.';

  @override
  String get dosageUnitG => 'г';

  @override
  String get dosageUnitMcg => 'мкг';

  @override
  String get dosageUnitIu => 'МЕ';

  @override
  String get addMedicationTitle => 'Добавить лекарство';

  @override
  String get medicineNameHint => 'Название (например, Витамин D)';

  @override
  String get dosageHint => 'Дозировка (например, 500)';

  @override
  String get saveAction => 'Сохранить и создать расписание';

  @override
  String get errorEmptyFields => 'Пожалуйста, заполните все поля';

  @override
  String get profileTitle => 'Профиль';

  @override
  String notificationTitle(String name) {
    return 'Время принять $name!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Дозировка: $dosage. Пожалуйста, не пропускайте.';
  }

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get adherenceRate => 'Уровень соблюдения';

  @override
  String get dosesTaken => 'Принятые дозы';

  @override
  String get dosesMissed => 'Пропущенные дозы';

  @override
  String get activeCourses => 'Активные курсы';

  @override
  String get tabHome => 'Расписание';

  @override
  String get tabAnalytics => 'Статистика';

  @override
  String get keepItUp => 'Отличная работа! Так держать.';

  @override
  String get needsAttention =>
      'Требует внимания. Старайтесь не пропускать дозы.';

  @override
  String get medicineDetails => 'Детали лекарства';

  @override
  String get pillsRemaining => 'Осталось в наличии';

  @override
  String get deleteCourse => 'Удалить курс';

  @override
  String get deleteConfirmation =>
      'Вы уверены, что хотите удалить этот курс и все его напоминания?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" добавлено.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" обновлено.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" удалено.';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get timeOfDay => 'Время суток';

  @override
  String get courseDuration => 'Длительность курса (дней)';

  @override
  String get pillsInPackage => 'Количество в упаковке';

  @override
  String get addTime => 'Добавить время';

  @override
  String timeLabel(int number) {
    return 'Время $number';
  }

  @override
  String get foodBefore => 'До еды';

  @override
  String get foodWith => 'Во время еды';

  @override
  String get foodAfter => 'После еды';

  @override
  String get foodNoMatter => 'В любое время';

  @override
  String get unknownMedicine => 'Неизвестное лекарство';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get medicineInfo => 'Информация о лекарстве';

  @override
  String get formTitle => 'Форма';

  @override
  String get scheduleTitle => 'Расписание';

  @override
  String get everyXDays => 'Каждые X дней';

  @override
  String get maxDosesPerDay => 'Макс. доз в день (Безопасность)';

  @override
  String get overdoseWarning => 'Для предотвращения случайной передозировки.';

  @override
  String get foodInstructionTitle => 'Указания по приему пищи';

  @override
  String doseNumber(int number) {
    return 'Доза $number';
  }

  @override
  String get coursePaused => 'Курс приостановлен';

  @override
  String get resumeCourse => 'Возобновить';

  @override
  String get pauseCourse => 'Приостановить';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" приостановлено.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" возобновлено.';
  }

  @override
  String get doctorReport => 'Отчет для врача';

  @override
  String get generatingReport => 'Создание отчета для врача...';

  @override
  String errorGeneratingReport(String error) {
    return 'Ошибка создания PDF: $error';
  }

  @override
  String get editCourse => 'Редактировать курс';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get editMedicineInfo => 'Редактировать информацию';

  @override
  String lowStockTitle(String name) {
    return 'Заканчивается: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Осталось только $count $unit. Время пополнить запасы!';
  }

  @override
  String get lowStockBadge => 'Заканчивается';

  @override
  String get snoozeAction => 'Отложить (30 мин)';

  @override
  String get undoAction => 'Отменить';

  @override
  String get sosPanelTitle => 'По необходимости (SOS)';

  @override
  String get takeNowAction => 'Принять';

  @override
  String get limitReachedAlert =>
      'Достигнут дневной лимит! Проконсультируйтесь с врачом.';

  @override
  String get addSosMedicine => 'Добавить SOS';

  @override
  String get outOfStockBadge => 'Закончилось';

  @override
  String get recentHistory => 'Недавняя история';

  @override
  String get noHistoryYet => 'Истории пока нет';

  @override
  String get lifetimeCourse => 'Постоянный (пожизненно)';

  @override
  String get doneAction => 'Готово';

  @override
  String get addMeasurement => 'Добавить показатель';

  @override
  String get bloodPressure => 'Артериальное давление';

  @override
  String get heartRate => 'Пульс';

  @override
  String get weight => 'Вес';

  @override
  String get bloodSugar => 'Уровень сахара';

  @override
  String get systolic => 'Вверх';

  @override
  String get diastolic => 'Вниз';

  @override
  String get taperingDosing => 'Динамическая дозировка (снижение)';

  @override
  String stepNumber(int number) {
    return 'Шаг $number';
  }

  @override
  String get addStep => 'Добавить шаг';

  @override
  String get doseForStep => 'Доза для этого шага';

  @override
  String get whatWouldYouLikeToDo => 'Что вы хотите сделать?';

  @override
  String get scheduleNewTreatmentCourse => 'Запланировать новый курс лечения';

  @override
  String get logHealthMetricsSubtitle => 'Записать давление, пульс, вес';

  @override
  String get priorityAction => 'Приоритетное действие';

  @override
  String get skipDoseAction => 'Пропустить';

  @override
  String errorPrefix(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get goodMorning => 'Доброе утро';

  @override
  String get goodAfternoon => 'Добрый день';

  @override
  String get goodEvening => 'Добрый вечер';

  @override
  String get dailyProgress => 'Ежедневный прогресс';

  @override
  String get sosEmergency => 'SOS экстренно';

  @override
  String get adherenceSubtitle => 'Обзор соблюдения режима лечения';

  @override
  String get healthCorrelationTitle => 'Связь со здоровьем';

  @override
  String get healthCorrelationSubtitle =>
      'Сравните соблюдение режима с показателями здоровья';

  @override
  String get last7Days => 'Последние 7 дней';

  @override
  String get pillsTaken => 'Принято таблеток';

  @override
  String get overallAdherence => 'Общее соблюдение';

  @override
  String get statusGood => 'Хорошо';

  @override
  String get statusNeedsAttention => 'Требует внимания';

  @override
  String get statTaken => 'Принято';

  @override
  String get statSkipped => 'Пропущено';

  @override
  String get statTotal => 'Всего';

  @override
  String get completedDosesSubtitle => 'Завершенные дозы';

  @override
  String get missedDosesSubtitle => 'Пропущенные дозы';

  @override
  String get noDataYet => 'Пока нет данных';

  @override
  String get noDataDescription =>
      'Начните отслеживать показатели и регулярно принимать лекарства,\nчтобы увидеть здесь полезную статистику.';

  @override
  String get failedToLoadAdherence =>
      'Не удалось загрузить данные о соблюдении';

  @override
  String get failedToLoadChart => 'Не удалось загрузить график';

  @override
  String avgAdherence(String value) {
    return 'Ср. соблюдение $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Ср. $metricName $value';
  }

  @override
  String get addAction => 'Добавить запись';

  @override
  String get frequency => 'Частота';

  @override
  String get form => 'Форма';

  @override
  String get inventory => 'Запасы';

  @override
  String get lowStockAlert => 'ЗАКАНЧИВАЕТСЯ';

  @override
  String get asNeededFrequency => 'ПО НЕОБХОДИМОСТИ';

  @override
  String get taperingFrequency => 'ПОСТЕПЕННАЯ ОТМЕНА';

  @override
  String get customizePill => 'Настроить внешний вид';

  @override
  String get customizePillTitle => 'Настроить внешний вид';

  @override
  String get shape => 'Форма';

  @override
  String get color => 'Цвет';

  @override
  String get overview => 'Обзор';

  @override
  String get scheduleAndRules => 'Расписание и правила';

  @override
  String get duration => 'Длительность';

  @override
  String get reminders => 'Напоминания';

  @override
  String get daysSuffix => 'дн.';

  @override
  String get pcsSuffix => 'шт.';

  @override
  String get details => 'Детали';

  @override
  String get settingsTitle => 'Настройки и Профиль';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get appPreferences => 'Настройки приложения';

  @override
  String get darkMode => 'Темный режим';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Уведомления';

  @override
  String get advancedFeatures => 'Расширенные настройки';

  @override
  String get caregivers => 'Близкие и Опекуны';

  @override
  String get drugInteractions => 'Взаимодействие лекарств';

  @override
  String get comingSoon => 'СКОРО';

  @override
  String get supportAndAbout => 'Поддержка и О приложении';

  @override
  String get contactSupport => 'Связаться с поддержкой';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get logout => 'Выйти';

  @override
  String get tabSettings => 'Профиль';

  @override
  String get defaultUserName => 'Друг';

  @override
  String get courseKindMedication => 'Лекарство';

  @override
  String get courseKindSupplement => 'Добавка';

  @override
  String get courseFilterAll => 'Все';

  @override
  String get courseFilterMedications => 'Лекарства';

  @override
  String get courseFilterSupplements => 'Добавки';

  @override
  String get homeTakeMedicationNow => 'Принять лекарство сейчас';

  @override
  String get homeTakeSupplementNow => 'Принять добавку сейчас';

  @override
  String get homeEmptyAllTitle => 'Пока нет лекарств';

  @override
  String get homeEmptyMedicationsTitle => 'Пока нет лекарств';

  @override
  String get homeEmptySupplementsTitle => 'Пока нет добавок';

  @override
  String get homeEmptyAllSubtitle =>
      'Сейчас ничего не требует внимания. Вы можете проверить другой день или добавить новый курс, когда будете готовы.';

  @override
  String get homeEmptyMedicationsSubtitle =>
      'На этот день нет лекарств, требующих внимания. Отличный момент для спокойной паузы.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'На этот день нет добавок, требующих внимания. Ваш режим оздоровления свободен.';

  @override
  String get homeAddSupplementTitle => 'Добавить добавку';

  @override
  String get homeAddSupplementSubtitle =>
      'Запланировать витамины и оздоровительные добавки';

  @override
  String get homeForThisDay => 'На этот день';

  @override
  String get homeMorningRoutine => 'Утренняя рутина';

  @override
  String get homeAfternoonRoutine => 'Дневная рутина';

  @override
  String get homeEveningRoutine => 'Вечерняя рутина';

  @override
  String get homeNightRoutine => 'Ночная рутина';

  @override
  String get homeRoutineSupplementsOnly => 'только добавки';

  @override
  String get homeRoutineMedicationsOnly => 'только лекарства';

  @override
  String get homeRoutineMixed => 'смешанная рутина';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count позиций',
      many: '$count позиций',
      few: '$count позиции',
      one: '1 позиция',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Требует внимания';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count запланированных позиций должны быть приняты или проверены сейчас.',
      many:
          '$count запланированных позиций должны быть приняты или проверены сейчас.',
      few:
          '$count запланированные позиции должны быть приняты или проверены сейчас.',
      one:
          '1 запланированная позиция должна быть принята или проверена сейчас.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'Следующее';

  @override
  String get homeRefillReminderTitle => 'Напоминание о пополнении';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count курсам скоро может потребоваться пополнение.',
      many: '$count курсам скоро может потребоваться пополнение.',
      few: '$count курсам скоро может потребоваться пополнение.',
      one: '1 курсу скоро может потребоваться пополнение.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Всё спокойно';

  @override
  String get homeEverythingCalmSubtitle =>
      'Прямо сейчас нет срочных задач по лекарствам или добавкам.';

  @override
  String get homeNoUpcomingItem => 'Нет предстоящих запланированных позиций.';

  @override
  String homeScheduledFor(String time) {
    return 'Запланировано на $time';
  }

  @override
  String get calendarToday => 'Сегодня';

  @override
  String get calendarSelectedDay => 'Выбранный день';

  @override
  String get calendarShowingToday => 'Показано расписание на сегодня';

  @override
  String get calendarBrowseNearbyDays =>
      'Прокрутите колесо, чтобы просмотреть ближайшие дни';

  @override
  String get calendarPreviewAnotherDay =>
      'Колесо позволяет предварительно просмотреть другой день перед обновлением экрана.';

  @override
  String get calendarDayWheelSemantics => 'Колесо дней';

  @override
  String get analyticsCourseMix => 'Смесь курсов';

  @override
  String get analyticsCourseMixSubtitle =>
      'Лечебные курсы и добавки отслеживаются вместе, но измеряются здесь отдельно.';

  @override
  String get analyticsCurrentRoutine => 'Текущая рутина';

  @override
  String get analyticsCurrentRoutineSubtitle =>
      'Дней подряд без пропущенных доз';

  @override
  String get analyticsTimingAccuracy => 'Точность времени';

  @override
  String get analyticsTimingAccuracySubtitle => 'Принято в течение 30 минут';

  @override
  String get analyticsBestRoutine => 'Лучшая рутина';

  @override
  String get analyticsBestRoutineSubtitle =>
      'Лучший результат за последние 90 дней';

  @override
  String get analyticsRefillRisk => 'Риск нехватки';

  @override
  String get analyticsRefillRiskSubtitle => 'Курсы близки к порогу пополнения';

  @override
  String get analyticsAverageDelay => 'Средняя задержка';

  @override
  String get analyticsMinutesShort => 'мин';

  @override
  String get analyticsCoachNote => 'Заметка тренера';

  @override
  String get analyticsMissedDoses => 'Пропущенные дозы';

  @override
  String analyticsActiveShort(int count) {
    return '$count активно';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Принято: $taken Пропущено: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Связаться с поддержкой';

  @override
  String get settingsContactSupportBody =>
      'Если что-то непонятно или работает не так, как ожидалось, мы можем помочь. Укажите модель вашего устройства, версию приложения и краткое описание проблемы.';

  @override
  String get settingsSupportEmailCopied => 'Email поддержки скопирован';

  @override
  String get settingsCopySupportEmail => 'Скопировать email поддержки';

  @override
  String get settingsPrivacyTitle => 'Политика конфиденциальности';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Pillora хранит данные ваших курсов, настройки напоминаний и историю приема на вашем устройстве, чтобы приложение могло показывать ваше расписание и создавать отчеты.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Фотографии лекарств и экспорт отчетов создаются только тогда, когда вы решите их использовать. Перед запуском замените это резюме в приложении на окончательный URL-адрес вашей политики конфиденциальности.';

  @override
  String get settingsPrivacyLaunchNote =>
      'Примечание к запуску: перед релизом опубликуйте полную политику конфиденциальности на вашем сайте или на странице в магазине приложений.';

  @override
  String get settingsLanguageEnglish => 'Английский';

  @override
  String get settingsLanguageRussian => 'Русский';

  @override
  String get settingsYourProfilePreferences => 'Ваш профиль и важные настройки';

  @override
  String get settingsComfortModeTitle => 'Комфортный режим';

  @override
  String get settingsComfortModeSubtitle =>
      'Увеличенный текст и более спокойный дизайн';

  @override
  String get settingsNotificationsEnabled =>
      'Напоминания о лекарствах включены';

  @override
  String get settingsOn => 'Вкл';

  @override
  String get settingsSupportAndSafety => 'Поддержка и безопасность';

  @override
  String get settingsShowOnboardingAgain => 'Показать обучение снова';

  @override
  String get settingsShowOnboardingAgainSubtitle =>
      'Открыть руководство для первого запуска';

  @override
  String get settingsFeaturePolishing =>
      'Эта функция дорабатывается для будущих релизов';

  @override
  String get settingsCaregiverTitle => 'Доступ для опекунов';

  @override
  String get settingsCaregiverDescription =>
      'Добавьте доверенное лицо, чтобы отчеты могли включать их контактные данные, а совместный уход оставался организованным.';

  @override
  String get settingsCaregiverName => 'Имя опекуна';

  @override
  String get settingsCaregiverRelation => 'Кем приходится';

  @override
  String get settingsCaregiverPhone => 'Номер телефона';

  @override
  String get settingsCaregiverShareReports => 'Включать опекуна в отчеты';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Отчеты для врача могут содержать контактные данные опекуна, когда вы ими делитесь.';

  @override
  String get settingsCaregiverSaved => 'Настройки опекуна сохранены';

  @override
  String get settingsCaregiverRemoved => 'Опекун удален';

  @override
  String get settingsCaregiverRemove => 'Удалить опекуна';

  @override
  String get settingsCaregiverEmpty =>
      'Добавьте доверенное лицо для совместного ухода и отчетов';

  @override
  String get settingsCaregiverAlertsTitle => 'Оповещения для опекуна';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Если важная доза просрочена или отмечена как пропущенная, Pillora может подготовить готовое оповещение для вашего опекуна на этом устройстве.';

  @override
  String get settingsCaregiverAlertsEmpty =>
      'Сначала добавьте опекуна, чтобы готовить оповещения о пропущенных дозах';

  @override
  String get settingsCaregiverAlertsDisabled =>
      'Оповещения для вашего опекуна отключены';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'Оповещение подготавливается через $minutes минут, если требуется внимание';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle =>
      'Готовить оповещения для опекуна';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Когда доза требует внимания, Pillora подготовит сообщение, которое вы сможете скопировать и отправить.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Период ожидания';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Подождать $minutes минут перед подготовкой оповещения о просроченной позиции.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes мин';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle =>
      'Включать просроченные дозы';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Подготовить оповещение, когда запланированная доза все еще ожидается после периода ожидания.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Включать пропущенные дозы';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Подготовить оповещение, когда доза явно отмечена как пропущенная.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Включать добавки';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Использовать ту же логику оповещений для добавок, а не только для лекарств.';

  @override
  String get settingsCaregiverAlertsSaved =>
      'Правила оповещений опекуна сохранены';

  @override
  String get settingsCaregiverConnectedTitle => 'Подключенная доставка опекуну';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Этот слой приложения поддерживает стабильный код связи и готовую к синхронизации папку исходящих сообщений, поэтому прямые оповещения на устройство опекуна могут быть легко подключены, когда включена облачная доставка.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Код, готовый к подключению, подготовлен. В исходящих нет ожидающих оповещений.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count оповещений(е) ожидают в папке исходящих для подключенной доставки.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Код связи с опекуном';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Держите этот код наготове для привязки устройства опекуна, когда включена прямая доставка.';

  @override
  String get settingsCaregiverConnectedOutboxTitle =>
      'Папка исходящих оповещений';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Последнее в очереди: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Скопировать код связи';

  @override
  String get settingsCaregiverConnectedCodeCopied =>
      'Код связи с опекуном скопирован';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Очистить исходящие';

  @override
  String get settingsCaregiverConnectedOutboxCleared =>
      'Папка исходящих для опекуна очищена';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Режим облачной связи';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Это устройство действует как устройство пациента и зеркалирует оповещения в Firestore.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'Это устройство привязано как устройство опекуна для $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone =>
      'Это устройство еще не привязано к облачной системе опекуна.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Привязанный код: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle =>
      'Предпросмотр входящих опекуна';

  @override
  String get settingsCaregiverConnectedInboxEmpty =>
      'Сейчас нет ожидающих облачных оповещений.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Использовать это устройство как пациента';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Это устройство теперь привязано как устройство пациента';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Подключить это устройство как опекуна';

  @override
  String get settingsCaregiverConnectedJoinTitle =>
      'Присоединиться к связи с опекуном';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Введите код связи с опекуном с устройства пациента, чтобы получать оповещения в этом приложении, пока оно активно.';

  @override
  String get settingsCaregiverConnectedJoinAction =>
      'Подключить устройство опекуна';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Это устройство теперь привязано как устройство опекуна';

  @override
  String get settingsCaregiverConnectedJoinFailed =>
      'Код связи с опекуном не найден';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Отключить облачную связь';

  @override
  String get settingsCaregiverConnectedDisconnected =>
      'Это устройство было отключено от облачной системы опекуна';

  @override
  String get caregiverCloudNotificationTitle => 'Оповещение от опекуна';

  @override
  String get caregiverAlertCardTitle => 'Оповещение для опекуна готово';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName может быть уведомлен о $count позиции(ях), требующих внимания сегодня.';
  }

  @override
  String get caregiverAlertReviewAction => 'Посмотреть и скопировать';

  @override
  String get caregiverAlertSheetTitle => 'Оповещение опекуну';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Pillora подготовила готовое сообщение для $caregiverName о $count позиции(ях), требующих внимания.';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'Опаздывает на $minutes мин';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Отмечено как пропущенное';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Запланировано на $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote =>
      'Этот релиз подготавливает готовое оповещение на вашем устройстве, чтобы вы могли быстро скопировать его и отправить своему опекуну.';

  @override
  String get caregiverAlertCopyMessage => 'Скопировать текст оповещения';

  @override
  String get caregiverAlertCopyPhone => 'Скопировать телефон опекуна';

  @override
  String get caregiverAlertNoPhone => 'Добавьте телефон опекуна в Настройках';

  @override
  String get caregiverAlertMessageCopied => 'Оповещение опекуну скопировано';

  @override
  String get caregiverAlertPhoneCopied => 'Телефон опекуна скопирован';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Здравствуйте, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Pillora подготовила это обновление для $patientName. Следующие дозы требуют внимания сегодня:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — запланировано на $time, сейчас просрочено на $minutes мин';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — запланировано на $time, отмечено как пропущенное';
  }

  @override
  String get caregiverAlertMessageFooter =>
      'Пожалуйста, свяжитесь, если нужна поддержка.';

  @override
  String get settingsSupportEmailSubtitle =>
      'Email поддержки и контактные данные для запуска';

  @override
  String get settingsPrivacySubtitle =>
      'Как обрабатываются данные напоминаний, фото и отчеты';

  @override
  String get settingsExampleName => 'Например, Александр';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get onboardingStartUsing => 'Начать использовать Pillora';

  @override
  String get onboardingContinue => 'Продолжить';

  @override
  String get onboardingBack => 'Назад';

  @override
  String get onboardingWelcomeTitle => 'Pillora помогает вам не сбиться с пути';

  @override
  String get onboardingWelcomeTagline => 'Спокойно, понятно и по делу.';

  @override
  String get onboardingWelcomeBody =>
      'Сразу после открытия приложения вы увидите, какое лекарство нужно принять сейчас, а какое следующее.';

  @override
  String get onboardingFeatureEasyInterface =>
      'Крупный, легко читаемый интерфейс';

  @override
  String get onboardingFeatureNextDose => 'Фокус на следующей дозе';

  @override
  String get onboardingFeatureReminders => 'Напоминания и контроль запасов';

  @override
  String get onboardingTailorTitle =>
      'Позвольте нам настроить приложение для вас';

  @override
  String get onboardingTailorSubtitle =>
      'Вы сможете изменить эти настройки позже в Профиле.';

  @override
  String get onboardingNamePrompt => 'Как к вам обращаться?';

  @override
  String get onboardingLanguageTitle => 'Язык';

  @override
  String get onboardingReadingComfort => 'Комфорт чтения';

  @override
  String get onboardingComfortModeTitle => 'Комфортный режим';

  @override
  String get onboardingComfortModeSubtitle =>
      'Увеличенный текст, большие кнопки и меньше визуального шума.';

  @override
  String get onboardingReadyTitle => 'Всё готово';

  @override
  String get onboardingReadyBanner =>
      'Первый экран фокусируется на том, что и когда нужно принять.';

  @override
  String get onboardingReadyBody =>
      'Главный экран показывает лекарства, требующие внимания в первую очередь, а статистика находится на отдельной вкладке.';

  @override
  String get onboardingReadySummaryHome =>
      'Более простой главный экран без лишнего';

  @override
  String get onboardingReadySummaryActions =>
      'Понятные действия: принять, пропустить, добавить';

  @override
  String get onboardingReadySummaryComfortOn => 'Комфортный режим уже включен';

  @override
  String get onboardingReadySummaryComfortLater =>
      'Комфортный режим можно включить позже в Профиле';

  @override
  String get medicineStandardCourse => 'Стандартный курс';

  @override
  String get medicineComplexCourse => 'Сложный курс';

  @override
  String get schedulePreviewTitle => 'Предпросмотр расписания';

  @override
  String get scheduleDoseAtTime => 'Доза в это время';

  @override
  String get courseTypeLabel => 'Тип курса';

  @override
  String get addSupplementScreenTitle => 'Добавить добавку';

  @override
  String get editSupplementTitle => 'Редактировать добавку';

  @override
  String get settingsLanguageChangeLater =>
      'Вы можете изменить это позже в Профиле';

  @override
  String get homeNothingDueTitle => 'Сейчас ничего не нужно принимать';

  @override
  String get homeUseDayWheelSubtitle =>
      'Используйте колесо дней выше, если хотите проверить другой день.';

  @override
  String get homeNoAttentionRightNow =>
      'Нет запланированных лекарств или добавок, требующих внимания прямо сейчас.';

  @override
  String get homeAddItemFab => 'Добавить лекарство, добавку или показатель';

  @override
  String get homeTimelineSubtitle =>
      'Лекарства и добавки показаны в хронологическом порядке.';

  @override
  String get analyticsCoachGreat =>
      'Вы выстраиваете надежный режим приема лекарств. Продолжайте в том же духе.';

  @override
  String get analyticsCoachMissed =>
      'Большинство пропусков происходит из-за непоследовательности, а не из-за объема. Сделайте первую дозу дня вашей опорой.';

  @override
  String get analyticsCoachTiming =>
      'Ваш режим движется в правильном направлении. Следующая победа — лучшая точность времени.';

  @override
  String get medicineFrequencyDaily => 'Ежедневно';

  @override
  String get medicineFrequencySpecificDays => 'В определенные дни';

  @override
  String get medicineFrequencyInterval => 'С интервалом';

  @override
  String get medicineFrequencyCycle => 'Циклами';

  @override
  String get medicineFormTablet => 'Таблетка';

  @override
  String get medicineFormCapsule => 'Капсула';

  @override
  String get medicineFormLiquid => 'Жидкость';

  @override
  String get medicineFormInjection => 'Укол';

  @override
  String get medicineFormDrops => 'Капли';

  @override
  String get medicineFormOintment => 'Мазь';

  @override
  String get medicineFormSpray => 'Спрей';

  @override
  String get medicineFormInhaler => 'Ингалятор';

  @override
  String get medicineFormPatch => 'Пластырь';

  @override
  String get medicineFormSuppository => 'Свечи';

  @override
  String get medicineTimelineSupplementInfo =>
      'Эта добавка отображается в общей ежедневной ленте, оставаясь при этом отдельным оздоровительным курсом.';

  @override
  String get medicineTimelineMedicationInfo =>
      'Это лекарство отображается в общей ежедневной ленте и остается частью вашего основного плана лечения.';

  @override
  String get medicineDoseScheduleTitle => 'Расписание доз';

  @override
  String get medicineDoseScheduleSubtitle =>
      'Следующий день лечения с дозировкой по времени.';

  @override
  String get medicineHistoryLoadError => 'Ошибка';

  @override
  String get scheduleDoseTabletsAtTime => 'Таблеток в это время';

  @override
  String get scheduleDoseAmountAtTime => 'Количество в это время';

  @override
  String get schedulePreviewFutureRebuilt =>
      'Будущие дозы будут перестроены с использованием этого расписания.';

  @override
  String get scheduleComplexTitle => 'Сложное расписание';

  @override
  String get scheduleComplexEditSubtitle =>
      'Вы можете изменить время и дозировку для каждого приема.';

  @override
  String get courseTimelineSupplementInfo =>
      'Эта добавка остается в своей категории, но отображается в общей ленте по времени.';

  @override
  String get courseTimelineMedicationInfo =>
      'Это лекарство остается в медицинской категории и отображается в общей ленте по времени.';

  @override
  String get supplementNameHint => 'Название (например, Магний)';

  @override
  String get addDoseAction => 'Добавить дозу';

  @override
  String get addConditionSuggestionsTitle => 'Предложения по заболеваниям';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Выберите заболевание, чтобы увидеть общие шаблоны курсов. Это только отправные точки, и они должны совпадать с реальным рецептом.';

  @override
  String get addConditionSuggestionsEmpty =>
      'Для этого состояния больше нет доступных предложений. Вы можете выбрать другое заболевание или продолжить вручную.';

  @override
  String get addFlowSupplementTitle => 'Как бы вы хотели добавить эту добавку?';

  @override
  String get addFlowMedicationTitle => 'С чего начнем?';

  @override
  String get addFlowSupplementSubtitle =>
      'Большинство людей добавляют добавки вручную, но вы все равно можете использовать быстрые шаблоны, если они подходят.';

  @override
  String get addFlowMedicationSubtitle =>
      'Выберите самый простой путь для начала. Вы сможете настроить каждую деталь на следующем шаге.';

  @override
  String get addFlowByConditionTitle => 'По заболеванию';

  @override
  String get addFlowByConditionSubtitle =>
      'Посмотреть самые частые шаблоны для конкретной проблемы';

  @override
  String get addFlowQuickTemplateTitle => 'Быстрый шаблон';

  @override
  String get addFlowQuickTemplateSubtitle =>
      'Использовать один из распространенных готовых курсов';

  @override
  String get addFlowManualTitle => 'Вручную';

  @override
  String get addFlowManualSubtitle => 'Заполнить курс самостоятельно с нуля';

  @override
  String get addAppearanceTitle => 'Внешний вид';

  @override
  String get addAppearanceSubtitle =>
      'Необязательный шаг. Добавьте фото или настройте таблетку, чтобы её было легче узнать позже.';

  @override
  String get addPhotoLabel => 'Фото';

  @override
  String get addQuickStartTitle => 'Быстрый старт';

  @override
  String get addQuickStartSubtitle =>
      'Используйте один из самых частых шаблонов курса в одно касание.';

  @override
  String get addSkipTemplate => 'Пропустить';

  @override
  String get addUseTemplate => 'Применить шаблон';

  @override
  String get addRecommendedMetricsTitle => 'Рекомендуемые показатели здоровья';

  @override
  String get addRecommendedMetricsSubtitle =>
      'Эти измерения часто отслеживают вместе с этим состоянием. Вы можете записать первые данные прямо сейчас.';

  @override
  String get addSupplementTimelineInfo =>
      'Эта добавка появится вместе с лекарствами в ежедневной ленте расписания.';

  @override
  String get addMedicationTimelineInfo =>
      'Это лекарство появится в общей ежедневной ленте с другими вашими курсами.';

  @override
  String get conditionDiabetesTitle => 'Диабет';

  @override
  String get conditionDiabetesSubtitle => 'Частые схемы долгосрочной терапии';

  @override
  String get conditionHypertensionTitle => 'Гипертония';

  @override
  String get conditionHypertensionSubtitle => 'Частые лекарства от давления';

  @override
  String get conditionCholesterolTitle => 'Высокий холестерин';

  @override
  String get conditionCholesterolSubtitle =>
      'Частая вечерняя терапия по снижению липидов';

  @override
  String get conditionThyroidTitle => 'Гипотиреоз';

  @override
  String get conditionThyroidSubtitle =>
      'Типичная утренняя заместительная терапия';

  @override
  String get conditionGerdTitle => 'Кислотный рефлюкс / ГЭРБ';

  @override
  String get conditionGerdSubtitle => 'Частый контроль симптомов кислоты';

  @override
  String get conditionAsthmaTitle => 'Астма';

  @override
  String get conditionAsthmaSubtitle =>
      'Частые базисные и экстренные ингаляторы';

  @override
  String get conditionAllergyTitle => 'Аллергия';

  @override
  String get conditionAllergySubtitle =>
      'Частый антигистаминный контроль симптомов';

  @override
  String get conditionHeartPreventionTitle => 'Болезни сердца / профилактика';

  @override
  String get conditionHeartPreventionSubtitle =>
      'Частые долгосрочные кардиологические схемы';

  @override
  String get conditionHeartFailureTitle => 'Сердечная недостаточность';

  @override
  String get conditionHeartFailureSubtitle =>
      'Частая поддержка жидкости и давления';

  @override
  String get conditionAtrialFibrillationTitle => 'Мерцательная аритмия';

  @override
  String get conditionAtrialFibrillationSubtitle =>
      'Частая терапия ритма и профилактики инсульта';

  @override
  String get conditionJointPainTitle => 'Боль в суставах / артрит';

  @override
  String get conditionJointPainSubtitle => 'Частый контроль боли и воспаления';

  @override
  String get conditionBphTitle => 'Простата / ДГПЖ';

  @override
  String get conditionBphSubtitle => 'Частый контроль симптомов';

  @override
  String get conditionOsteoporosisTitle => 'Остеопороз / здоровье костей';

  @override
  String get conditionOsteoporosisSubtitle => 'Частые схемы поддержки костей';

  @override
  String get conditionAnemiaTitle => 'Дефицит железа / анемия';

  @override
  String get conditionAnemiaSubtitle => 'Частые схемы восполнения железа';

  @override
  String get suggestionMetforminName => 'Метформин';

  @override
  String get suggestionMetforminNote =>
      'Типичная пероральная терапия. Сверьте точную дозу с рецептом.';

  @override
  String get suggestionInsulinName => 'Инсулин';

  @override
  String get suggestionInsulinNote =>
      'Шаблон инъекции. Настройте тип инсулина, дозу и время под реальный режим.';

  @override
  String get suggestionAmlodipineName => 'Амлодипин';

  @override
  String get suggestionAmlodipineNote =>
      'Частый контроль давления один раз в день.';

  @override
  String get suggestionLosartanName => 'Лозартан';

  @override
  String get suggestionLosartanNote =>
      'Часто используется как ежедневная долгосрочная терапия.';

  @override
  String get suggestionAtorvastatinName => 'Аторвастатин';

  @override
  String get suggestionAtorvastatinNote => 'Частый ежедневный шаблон статина.';

  @override
  String get suggestionLevothyroxineName => 'Левотироксин';

  @override
  String get suggestionLevothyroxineNote => 'Обычно принимается утром натощак.';

  @override
  String get suggestionOmeprazoleName => 'Омепразол';

  @override
  String get suggestionOmeprazoleNote => 'Часто принимается утром натощак.';

  @override
  String get suggestionFamotidineName => 'Фамотидин';

  @override
  String get suggestionFamotidineNote =>
      'Используется при симптомах кислоты, часто вечером.';

  @override
  String get suggestionBudesonideFormoterolName => 'Будесонид/Формотерол';

  @override
  String get suggestionBudesonideFormoterolNote =>
      'Частый шаблон поддерживающего ингалятора.';

  @override
  String get suggestionAlbuterolName => 'Сальбутамол';

  @override
  String get suggestionAlbuterolNote =>
      'Частый экстренный ингалятор по необходимости.';

  @override
  String get suggestionCetirizineName => 'Цетиризин';

  @override
  String get suggestionCetirizineNote =>
      'Часто используется раз в день от симптомов аллергии.';

  @override
  String get suggestionLoratadineName => 'Лоратадин';

  @override
  String get suggestionLoratadineNote =>
      'Частый шаблон дневного антигистаминного средства.';

  @override
  String get suggestionAspirinName => 'Аспирин';

  @override
  String get suggestionAspirinNote =>
      'Частый шаблон низкодозированной профилактики сердечно-сосудистых заболеваний.';

  @override
  String get suggestionClopidogrelName => 'Клопидогрел';

  @override
  String get suggestionClopidogrelNote =>
      'Часто используется как ежедневная антитромбоцитарная терапия.';

  @override
  String get suggestionFurosemideName => 'Фуросемид';

  @override
  String get suggestionFurosemideNote =>
      'Шаблон диуретика, часто принимаемый в первой половине дня.';

  @override
  String get suggestionSpironolactoneName => 'Спиронолактон';

  @override
  String get suggestionSpironolactoneNote =>
      'Частая схема поддерживающей терапии раз в день.';

  @override
  String get suggestionApixabanName => 'Апиксабан';

  @override
  String get suggestionApixabanNote =>
      'Частая схема приема антикоагулянта два раза в день.';

  @override
  String get suggestionMetoprololName => 'Метопролол';

  @override
  String get suggestionMetoprololNote =>
      'Часто используется для контроля сердечного ритма.';

  @override
  String get suggestionIbuprofenName => 'Ибупрофен';

  @override
  String get suggestionIbuprofenNote =>
      'Частый шаблон краткосрочного обезболивания.';

  @override
  String get suggestionDiclofenacGelName => 'Диклофенак гель';

  @override
  String get suggestionDiclofenacGelNote =>
      'Шаблон местного противовоспалительного средства.';

  @override
  String get suggestionTamsulosinName => 'Тамсулозин';

  @override
  String get suggestionTamsulosinNote => 'Часто принимается вечером после еды.';

  @override
  String get suggestionFinasterideName => 'Финастерид';

  @override
  String get suggestionFinasterideNote =>
      'Частая долгосрочная поддержка раз в день.';

  @override
  String get suggestionAlendronateName => 'Алендронат';

  @override
  String get suggestionAlendronateNote =>
      'Типичный утренний еженедельный шаблон натощак.';

  @override
  String get suggestionCalciumVitaminDName => 'Кальций + Витамин D';

  @override
  String get suggestionCalciumVitaminDNote =>
      'Частая рутина добавок для поддержки костей.';

  @override
  String get suggestionFerrousSulfateName => 'Сульфат железа';

  @override
  String get suggestionFerrousSulfateNote =>
      'Частый шаблон восполнения железа.';

  @override
  String get suggestionFolicAcidName => 'Фолиевая кислота';

  @override
  String get suggestionFolicAcidNote =>
      'Частый шаблон поддерживающих витаминов.';

  @override
  String get pdfDoctorReportTitle => 'Отчет для врача';

  @override
  String get pdfSupplementCourseSummary => 'Сводка курса добавок';

  @override
  String get pdfMedicationCourseSummary => 'Сводка курса лекарств';

  @override
  String get pdfCourseProfileTitle => 'Профиль курса';

  @override
  String get pdfScheduleSnapshotTitle => 'Снимок расписания';

  @override
  String get pdfScheduleSnapshotSubtitle =>
      'Типичный день курса с указанием времени и дозировки.';

  @override
  String get pdfAdministrationHistoryTitle => 'История приема';

  @override
  String get pdfAdministrationHistorySubtitle =>
      'Показывает, что было принято, и как это совпадает с планом.';

  @override
  String get pdfAdherenceLabel => 'Соблюдение';

  @override
  String get pdfSnoozedLabel => 'Отложено';

  @override
  String get pdfClinicalSummaryTitle => 'Клиническая сводка';

  @override
  String get pdfPatientLabel => 'Пациент';

  @override
  String get pdfCaregiverLabel => 'Опекун';

  @override
  String get pdfReportPeriodLabel => 'Период отчета';

  @override
  String get pdfOnTimeRateLabel => 'Своевременность';

  @override
  String get pdfAverageDelayLabel => 'Средняя задержка';

  @override
  String get pdfUpcomingDosesLabel => 'Предстоящие дозы';

  @override
  String get pdfStockLeftLabel => 'Остаток запаса';

  @override
  String get pdfNameLabel => 'Название';

  @override
  String get pdfCourseTypeLabel => 'Тип курса';

  @override
  String get pdfDosageLabel => 'Дозировка';

  @override
  String get pdfFrequencyLabel => 'Частота';

  @override
  String get pdfStartedLabel => 'Начато';

  @override
  String get pdfInstructionLabel => 'Инструкция';

  @override
  String get pdfNotesLabel => 'Заметки';

  @override
  String get pdfTimelineEmpty => 'Пока нет записей в истории приема.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return 'Этот PDF показывает последние $visible записей из $total.';
  }

  @override
  String get pdfTableScheduled => 'Запланировано';

  @override
  String get pdfTableActual => 'Фактически';

  @override
  String get pdfTableDose => 'Доза';

  @override
  String get pdfTableStatus => 'Статус';

  @override
  String get pdfTableDelay => 'Задержка';

  @override
  String get pdfOnTime => 'Вовремя';

  @override
  String get pdfMinuteShort => 'мин';

  @override
  String get pdfNoFoodRestriction => 'Без ограничений по еде';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Добавьте новое лекарство или добавку, чтобы они появились здесь.';
}
