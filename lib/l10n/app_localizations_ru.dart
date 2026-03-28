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
  String get architectureReady => 'Архитектура заложена. Все системы в норме.';

  @override
  String get nextCreateHome => 'Далее: Создать Главный экран';

  @override
  String get statusTaken => 'Принято';

  @override
  String get statusSkipped => 'Пропущено';

  @override
  String get statusSnoozed => 'Отложить на 10 мин';

  @override
  String get statusPending => 'Ожидается';

  @override
  String get emptySchedule => 'На этот день лекарств не назначено';

  @override
  String get takeAction => 'Принять';

  @override
  String get skipAction => 'Пропустить';

  @override
  String get dosageUnitMg => 'мг';

  @override
  String get dosageUnitMl => 'мл';

  @override
  String get dosageUnitDrops => 'капель';

  @override
  String get dosageUnitPcs => 'шт';

  @override
  String get dosageUnitG => 'г';

  @override
  String get dosageUnitMcg => 'мкг';

  @override
  String get dosageUnitIu => 'МЕ';

  @override
  String get addMedicationTitle => 'Добавить лекарство';

  @override
  String get medicineNameHint => 'Название (например, Витамин Д)';

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
    return 'Дозировка: $dosage. Пожалуйста, не пропустите.';
  }

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get adherenceRate => 'Соблюдение курса';

  @override
  String get dosesTaken => 'Принято доз';

  @override
  String get dosesMissed => 'Пропущено доз';

  @override
  String get activeCourses => 'Активные курсы';

  @override
  String get tabHome => 'Расписание';

  @override
  String get tabAnalytics => 'Статистика';

  @override
  String get keepItUp => 'Отличная работа! Так держать.';

  @override
  String get needsAttention => 'Обратите внимание. Старайтесь не пропускать.';

  @override
  String get medicineDetails => 'Детали лекарства';

  @override
  String get pillsRemaining => 'Осталось в запасе';

  @override
  String get deleteCourse => 'Удалить курс';

  @override
  String get deleteConfirmation =>
      'Вы уверены, что хотите удалить этот курс и все его напоминания?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type «$name» добавлен.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type «$name» обновлен.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type «$name» удален.';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get timeOfDay => 'Время приема';

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
  String get takePhoto => 'Сделать снимок';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get medicineInfo => 'Информация о лекарстве';

  @override
  String get formTitle => 'Форма выпуска';

  @override
  String get scheduleTitle => 'Расписание';

  @override
  String get everyXDays => 'Каждые X дней';

  @override
  String get maxDosesPerDay => 'Макс. доз в день (Безопасность)';

  @override
  String get overdoseWarning => 'Для предотвращения случайной передозировки.';

  @override
  String get foodInstructionTitle => 'Прием пищи';

  @override
  String doseNumber(int number) {
    return 'Прием $number';
  }

  @override
  String get coursePaused => 'Курс приостановлен';

  @override
  String get resumeCourse => 'Возобновить';

  @override
  String get pauseCourse => 'Пауза';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type «$name» приостановлен.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type «$name» возобновлен.';
  }

  @override
  String get doctorReport => 'Отчет для врача';

  @override
  String get generatingReport => 'Создание отчета...';

  @override
  String errorGeneratingReport(String error) {
    return 'Ошибка создания PDF: $error';
  }

  @override
  String get editCourse => 'Изменить курс';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get editMedicineInfo => 'Изменить информацию';

  @override
  String lowStockTitle(String name) {
    return 'Заканчивается: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Осталось всего $count $unit. Пора в аптеку!';
  }

  @override
  String get lowStockBadge => 'Мало запасов';

  @override
  String get snoozeAction => 'Отложить (30м)';

  @override
  String get undoAction => 'Отменить';

  @override
  String get sosPanelTitle => 'Экстренно (SOS)';

  @override
  String get takeNowAction => 'ПРИНЯТЬ СЕЙЧАС';

  @override
  String get limitReachedAlert => 'Дневной лимит исчерпан! Обратитесь к врачу.';

  @override
  String get addSosMedicine => 'Добавить SOS';

  @override
  String get outOfStockBadge => 'Закончилось';

  @override
  String get recentHistory => 'Недавняя история';

  @override
  String get noHistoryYet => 'Истории пока нет';

  @override
  String get lifetimeCourse => 'Постоянный прием (Всю жизнь)';

  @override
  String get doneAction => 'Готово';

  @override
  String get addMeasurement => 'Новый замер';

  @override
  String get bloodPressure => 'Давление';

  @override
  String get heartRate => 'Пульс';

  @override
  String get weight => 'Вес';

  @override
  String get bloodSugar => 'Сахар';

  @override
  String get systolic => 'Сист';

  @override
  String get diastolic => 'Диаст';

  @override
  String get taperingDosing => 'Динамическая (Ступенчатая)';

  @override
  String stepNumber(int number) {
    return 'Шаг $number';
  }

  @override
  String get addStep => 'Добавить шаг';

  @override
  String get doseForStep => 'Доза для этого шага';

  @override
  String get whatWouldYouLikeToDo => 'Что бы вы хотели сделать?';

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
  String get dailyProgress => 'Прогресс за день';

  @override
  String get sosEmergency => 'Экстренная помощь';

  @override
  String get adherenceSubtitle => 'Обзор регулярности приема лекарств';

  @override
  String get healthCorrelationTitle => 'Связь со здоровьем';

  @override
  String get healthCorrelationSubtitle =>
      'Сравните прием лекарств с показателями вашего здоровья';

  @override
  String get last7Days => 'Последние 7 дней';

  @override
  String get pillsTaken => 'Принято таблеток';

  @override
  String get overallAdherence => 'Общий показатель';

  @override
  String get statusGood => 'Отлично';

  @override
  String get statusNeedsAttention => 'Требует внимания';

  @override
  String get statTaken => 'Принято';

  @override
  String get statSkipped => 'Пропущено';

  @override
  String get statTotal => 'Всего';

  @override
  String get completedDosesSubtitle => 'Завершенные приемы';

  @override
  String get missedDosesSubtitle => 'Пропущенные приемы';

  @override
  String get noDataYet => 'Пока нет данных';

  @override
  String get noDataDescription =>
      'Начните регулярно принимать лекарства и вносить измерения,\nчтобы увидеть аналитику здесь.';

  @override
  String get failedToLoadAdherence => 'Не удалось загрузить данные';

  @override
  String get failedToLoadChart => 'Не удалось загрузить график';

  @override
  String avgAdherence(String value) {
    return 'Ср. показатель $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Ср. $metricName $value';
  }

  @override
  String get addAction => 'Добавить';

  @override
  String get frequency => 'Частота';

  @override
  String get form => 'Форма';

  @override
  String get inventory => 'Запасы';

  @override
  String get lowStockAlert => 'МАЛО';

  @override
  String get asNeededFrequency => 'ПО ПОТРЕБНОСТИ';

  @override
  String get taperingFrequency => 'ТИТРАЦИЯ';

  @override
  String get customizePill => 'Настроить вид';

  @override
  String get customizePillTitle => 'Внешний вид';

  @override
  String get shape => 'Форма';

  @override
  String get color => 'Цвет';

  @override
  String get overview => 'Основное';

  @override
  String get scheduleAndRules => 'Расписание и правила';

  @override
  String get duration => 'Длительность';

  @override
  String get reminders => 'Напоминания';

  @override
  String get daysSuffix => 'дней';

  @override
  String get pcsSuffix => 'шт';

  @override
  String get details => 'Детали';

  @override
  String get settingsTitle => 'Настройки и профиль';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get appPreferences => 'Настройки приложения';

  @override
  String get darkMode => 'Темная тема';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Уведомления';

  @override
  String get advancedFeatures => 'Продвинутые функции';

  @override
  String get caregivers => 'Мед-друзья и близкие';

  @override
  String get drugInteractions => 'Совместимость лекарств';

  @override
  String get comingSoon => 'СКОРО';

  @override
  String get supportAndAbout => 'Поддержка и инфо';

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
  String get courseKindSupplement => 'БАД';

  @override
  String get courseFilterAll => 'Все';

  @override
  String get courseFilterMedications => 'Лекарства';

  @override
  String get courseFilterSupplements => 'БАДы';

  @override
  String get homeTakeMedicationNow => 'Примите это лекарство сейчас';

  @override
  String get homeTakeSupplementNow => 'Примите этот БАД сейчас';

  @override
  String get homeEmptyAllTitle => 'Сейчас все спокойно';

  @override
  String get homeEmptyMedicationsTitle => 'С лекарствами все в порядке';

  @override
  String get homeEmptySupplementsTitle => 'С БАДами все в порядке';

  @override
  String get homeEmptyAllSubtitle =>
      'Сейчас ничего не требует внимания. Можно проверить другой день или добавить новый курс, когда будете готовы.';

  @override
  String get homeEmptyMedicationsSubtitle =>
      'На эту дату лекарства не требуют внимания. Можно просто следовать привычному режиму.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'На эту дату БАДы не требуют внимания. Можно спокойно продолжать привычный режим приема.';

  @override
  String get homeAddSupplementTitle => 'Добавить БАД';

  @override
  String get homeAddSupplementSubtitle =>
      'Запланируйте витамины и полезные добавки';

  @override
  String get homeForThisDay => 'На этот день';

  @override
  String get homeMorningRoutine => 'Утренние приемы';

  @override
  String get homeAfternoonRoutine => 'Дневные приемы';

  @override
  String get homeEveningRoutine => 'Вечерние приемы';

  @override
  String get homeNightRoutine => 'Ночные приемы';

  @override
  String get homeRoutineSupplementsOnly => 'только БАДы';

  @override
  String get homeRoutineMedicationsOnly => 'только лекарства';

  @override
  String get homeRoutineMixed => 'смешанные приемы';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пункта',
      many: '$count пунктов',
      few: '$count пункта',
      one: '$count пункт',
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
          '$count запланированных пункта нужно принять или проверить сейчас.',
      many:
          '$count запланированных пунктов нужно принять или проверить сейчас.',
      few: '$count запланированных пункта нужно принять или проверить сейчас.',
      one: '$count запланированный пункт нужно принять или проверить сейчас.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'Дальше';

  @override
  String get homeRefillReminderTitle => 'Напоминание о пополнении';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count курсам скоро может понадобиться пополнение.',
      many: '$count курсам скоро может понадобиться пополнение.',
      few: '$count курсам скоро может понадобиться пополнение.',
      one: '$count курсу скоро может понадобиться пополнение.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Сейчас все спокойно';

  @override
  String get homeEverythingCalmSubtitle =>
      'Сейчас нет срочных задач по лекарствам или БАДам.';

  @override
  String get homeNoUpcomingItem => 'Ближайший прием не запланирован.';

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
      'Прокручивайте колесо, чтобы посмотреть соседние дни';

  @override
  String get calendarPreviewAnotherDay =>
      'Колесо позволяет предварительно посмотреть другой день до обновления экрана.';

  @override
  String get calendarDayWheelSemantics => 'Колесо дней';

  @override
  String get analyticsCourseMix => 'Курсы по типам';

  @override
  String get analyticsCourseMixSubtitle =>
      'Лечение и БАДы отслеживаются вместе, но здесь считаются отдельно.';

  @override
  String get analyticsCurrentRoutine => 'Текущая серия';

  @override
  String get analyticsCurrentRoutineSubtitle =>
      'Дни подряд без пропущенных доз';

  @override
  String get analyticsTimingAccuracy => 'Точность по времени';

  @override
  String get analyticsTimingAccuracySubtitle => 'Принято в пределах 30 минут';

  @override
  String get analyticsBestRoutine => 'Лучшая серия';

  @override
  String get analyticsBestRoutineSubtitle =>
      'Лучший результат за последние 90 дней';

  @override
  String get analyticsRefillRisk => 'Риск пополнения';

  @override
  String get analyticsRefillRiskSubtitle =>
      'Курсы, близкие к порогу пополнения';

  @override
  String get analyticsAverageDelay => 'Средняя задержка';

  @override
  String get analyticsMinutesShort => 'мин';

  @override
  String get analyticsCoachNote => 'Подсказка';

  @override
  String get analyticsMissedDoses => 'Пропущенные дозы';

  @override
  String analyticsActiveShort(int count) {
    return '$count активных';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Принято: $taken  Пропущено: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Связаться с поддержкой';

  @override
  String get settingsContactSupportBody =>
      'Если что-то выглядит непонятно или работает не так, мы поможем. Укажите модель устройства, версию приложения и коротко опишите проблему.';

  @override
  String get settingsSupportEmailCopied => 'Почта поддержки скопирована';

  @override
  String get settingsCopySupportEmail => 'Скопировать почту поддержки';

  @override
  String get settingsPrivacyTitle => 'Политика конфиденциальности';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Pillora хранит данные о курсах, настройках напоминаний и истории приемов на вашем устройстве, чтобы показывать расписание и формировать отчеты.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Фотографии лекарств и экспорт отчетов создаются только когда вы сами выбираете эти функции. Перед релизом замените это краткое описание внутри приложения на финальную ссылку на политику конфиденциальности.';

  @override
  String get settingsPrivacyLaunchNote =>
      'Примечание к релизу: опубликуйте полную политику конфиденциальности на сайте или в карточке приложения до выпуска.';

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
      'Более крупный текст и меньше визуального шума';

  @override
  String get settingsNotificationsEnabled =>
      'Напоминания о лекарствах включены';

  @override
  String get settingsOn => 'Вкл';

  @override
  String get settingsSupportAndSafety => 'Поддержка и безопасность';

  @override
  String get settingsShowOnboardingAgain =>
      'Показать приветственное руководство снова';

  @override
  String get settingsShowOnboardingAgainSubtitle =>
      'Снова открыть руководство по началу работы';

  @override
  String get settingsFeaturePolishing =>
      'Эта функция дорабатывается к следующему релизу';

  @override
  String get settingsCaregiverTitle => 'Доступ для близкого человека';

  @override
  String get settingsCaregiverDescription =>
      'Добавьте доверенного человека, чтобы в отчетах были его контакты и совместная забота оставалась понятной.';

  @override
  String get settingsCaregiverName => 'Имя близкого человека';

  @override
  String get settingsCaregiverRelation => 'Кто вам этот человек';

  @override
  String get settingsCaregiverPhone => 'Номер телефона';

  @override
  String get settingsCaregiverShareReports =>
      'Добавлять близкого человека в отчеты';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Контакты этого человека будут включаться в отчеты, которыми вы делитесь.';

  @override
  String get settingsCaregiverSaved => 'Данные близкого человека сохранены';

  @override
  String get settingsCaregiverRemoved => 'Близкий человек удален';

  @override
  String get settingsCaregiverRemove => 'Удалить близкого человека';

  @override
  String get settingsCaregiverEmpty =>
      'Добавьте доверенного человека для совместной заботы и отчетов';

  @override
  String get settingsCaregiverAlertsTitle => 'Оповещения для близкого человека';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Если важный прием просрочен или отмечен как пропущенный, Pillora подготовит на этом устройстве готовое сообщение для близкого человека.';

  @override
  String get settingsCaregiverAlertsEmpty =>
      'Сначала добавьте близкого человека, чтобы включить такие оповещения';

  @override
  String get settingsCaregiverAlertsDisabled =>
      'Оповещения для близкого человека отключены';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'Сообщение готовится через $minutes мин., если приему требуется внимание';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle =>
      'Готовить сообщения для близкого человека';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Когда прием требует внимания, Pillora подготовит сообщение, которое можно быстро скопировать и отправить.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Пауза перед оповещением';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Подождать $minutes мин. перед подготовкой сообщения о просроченном приеме.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes мин.';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle =>
      'Учитывать просроченные приемы';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Готовить сообщение, если прием все еще не отмечен после выбранной паузы.';

  @override
  String get settingsCaregiverAlertsSkippedTitle =>
      'Учитывать пропущенные приемы';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Готовить сообщение, если прием явно отмечен как пропущенный.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Учитывать БАДы';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Использовать тот же сценарий не только для лекарств, но и для БАДов.';

  @override
  String get settingsCaregiverAlertsSaved =>
      'Правила оповещений для близкого человека сохранены';

  @override
  String get settingsCaregiverConnectedTitle => 'Связь с устройством близкого';

  @override
  String get settingsCaregiverConnectedDescription =>
      'На стороне приложения уже подготовлены постоянный код связи и outbox для оповещений, чтобы прямую доставку на устройство близкого можно было аккуратно подключить через облачный слой.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Код связи уже готов. В outbox сейчас нет ожидающих оповещений.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return 'В outbox для связанной доставки ожидают $count оповещений.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Код связи для близкого';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Сохраните этот код для будущей привязки устройства близкого, когда будет включена прямая доставка.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Outbox оповещений';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Последний раз добавлено: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Скопировать код связи';

  @override
  String get settingsCaregiverConnectedCodeCopied =>
      'Код связи для близкого скопирован';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Очистить outbox';

  @override
  String get settingsCaregiverConnectedOutboxCleared =>
      'Outbox близкого очищен';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Режим облачной связи';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Это устройство работает как устройство пациента и зеркалит оповещения в Firestore.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'Это устройство связано как устройство близкого человека для $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone =>
      'Это устройство пока не подключено к облачному caregiver-сценарию.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Связанный код: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle =>
      'Предпросмотр caregiver inbox';

  @override
  String get settingsCaregiverConnectedInboxEmpty =>
      'Сейчас в облачном inbox нет ожидающих оповещений.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Использовать это устройство как устройство пациента';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Это устройство теперь связано как устройство пациента';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Подключить это устройство как устройство близкого';

  @override
  String get settingsCaregiverConnectedJoinTitle =>
      'Подключение устройства близкого';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Введите код связи с устройства пациента, чтобы получать оповещения в этом приложении, пока оно активно.';

  @override
  String get settingsCaregiverConnectedJoinAction =>
      'Подключить устройство близкого';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Это устройство теперь связано как устройство близкого человека';

  @override
  String get settingsCaregiverConnectedJoinFailed =>
      'Код связи для близкого не найден';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Отключить облачную связь';

  @override
  String get settingsCaregiverConnectedDisconnected =>
      'Это устройство отключено от облачного caregiver-сценария';

  @override
  String get caregiverCloudNotificationTitle => 'Оповещение для близкого';

  @override
  String get caregiverAlertCardTitle => 'Сообщение для близкого уже готово';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName можно быстро сообщить о $count пунктах, которым сегодня нужно внимание.';
  }

  @override
  String get caregiverAlertReviewAction => 'Открыть и скопировать';

  @override
  String get caregiverAlertSheetTitle => 'Сообщение для близкого человека';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Pillora подготовил готовое сообщение для $caregiverName о $count пунктах, которым нужно внимание.';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'Просрочено на $minutes мин.';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Отмечено как пропущенное';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'По плану в $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote =>
      'В этой версии Pillora готовит сообщение на вашем устройстве, чтобы вы могли быстро скопировать его и отправить близкому человеку.';

  @override
  String get caregiverAlertCopyMessage => 'Скопировать текст сообщения';

  @override
  String get caregiverAlertCopyPhone => 'Скопировать номер близкого';

  @override
  String get caregiverAlertNoPhone => 'Добавьте номер близкого в настройках';

  @override
  String get caregiverAlertMessageCopied =>
      'Сообщение для близкого скопировано';

  @override
  String get caregiverAlertPhoneCopied => 'Номер близкого скопирован';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Здравствуйте, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Pillora подготовил это обновление для $patientName. Сегодня внимания требуют следующие приемы:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — по плану в $time, сейчас просрочено на $minutes мин.';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — по плану в $time, отмечено как пропущенное';
  }

  @override
  String get caregiverAlertMessageFooter =>
      'Пожалуйста, свяжитесь с человеком, если нужна поддержка.';

  @override
  String get settingsSupportEmailSubtitle =>
      'Почта поддержки для вопросов и сообщений об ошибках';

  @override
  String get settingsPrivacySubtitle =>
      'Как обрабатываются данные напоминаний, фото и отчетов';

  @override
  String get settingsExampleName => 'Например, Алексей';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get onboardingStartUsing => 'Начать использовать Pillora';

  @override
  String get onboardingContinue => 'Продолжить';

  @override
  String get onboardingBack => 'Назад';

  @override
  String get onboardingWelcomeTitle =>
      'Pillora помогает держать лечение под контролем';

  @override
  String get onboardingWelcomeTagline => 'Спокойно, понятно и по делу.';

  @override
  String get onboardingWelcomeBody =>
      'Сразу после открытия приложения вы увидите, что нужно принять сейчас и что будет дальше.';

  @override
  String get onboardingFeatureEasyInterface =>
      'Крупный и легко читаемый интерфейс';

  @override
  String get onboardingFeatureNextDose => 'Фокус на ближайшем приеме';

  @override
  String get onboardingFeatureReminders => 'Напоминания и контроль запаса';

  @override
  String get onboardingTailorTitle => 'Давайте настроим приложение под вас';

  @override
  String get onboardingTailorSubtitle =>
      'Позже эти настройки можно изменить в профиле.';

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
      'Более крупный текст, большие кнопки и меньше визуального шума.';

  @override
  String get onboardingReadyTitle => 'Все готово';

  @override
  String get onboardingReadyBanner =>
      'Первый экран показывает, что и когда нужно принять.';

  @override
  String get onboardingReadyBody =>
      'На главном экране сначала показываются самые важные приемы, а статистика остается на отдельной вкладке.';

  @override
  String get onboardingReadySummaryHome =>
      'Более простой главный экран без лишнего шума';

  @override
  String get onboardingReadySummaryActions =>
      'Понятные действия: принять, пропустить, добавить';

  @override
  String get onboardingReadySummaryComfortOn => 'Комфортный режим уже включен';

  @override
  String get onboardingReadySummaryComfortLater =>
      'Комфортный режим можно включить позже в профиле';

  @override
  String get medicineStandardCourse => 'Обычный курс';

  @override
  String get medicineComplexCourse => 'Сложный курс';

  @override
  String get schedulePreviewTitle => 'Предпросмотр расписания';

  @override
  String get scheduleDoseAtTime => 'Доза в это время';

  @override
  String get courseTypeLabel => 'Тип курса';

  @override
  String get addSupplementScreenTitle => 'Добавить БАД';

  @override
  String get editSupplementTitle => 'Редактировать БАД';

  @override
  String get settingsLanguageChangeLater =>
      'Позже это можно изменить в профиле';

  @override
  String get homeNothingDueTitle => 'Сейчас ничего не запланировано';

  @override
  String get homeUseDayWheelSubtitle =>
      'Используйте колесо дней выше, если хотите посмотреть другой день.';

  @override
  String get homeNoAttentionRightNow =>
      'Сейчас ни лекарства, ни БАДы не требуют внимания.';

  @override
  String get homeAddItemFab => 'Добавить лекарство, БАД или измерение';

  @override
  String get homeTimelineSubtitle => 'Лекарства и БАДы показаны по времени.';

  @override
  String get analyticsCoachGreat =>
      'У вас формируется надежный режим приема. Продолжайте в том же духе.';

  @override
  String get analyticsCoachMissed =>
      'Большинство пропусков связано не с количеством, а с нерегулярностью. Сделайте первый прием дня своей опорной точкой.';

  @override
  String get analyticsCoachTiming =>
      'Ваш режим движется в правильную сторону. Следующий шаг — точнее соблюдать время.';

  @override
  String get medicineFrequencyDaily => 'Ежедневно';

  @override
  String get medicineFrequencySpecificDays => 'Определенные дни';

  @override
  String get medicineFrequencyInterval => 'Интервал';

  @override
  String get medicineFrequencyCycle => 'Цикл';

  @override
  String get medicineFormTablet => 'Таблетка';

  @override
  String get medicineFormCapsule => 'Капсула';

  @override
  String get medicineFormLiquid => 'Жидкость';

  @override
  String get medicineFormInjection => 'Инъекция';

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
  String get medicineFormSuppository => 'Суппозиторий';

  @override
  String get medicineTimelineSupplementInfo =>
      'Этот БАД показывается в общей дневной ленте, но остается отдельным курсом.';

  @override
  String get medicineTimelineMedicationInfo =>
      'Это лекарство показывается в общей дневной ленте и остается частью основного плана лечения.';

  @override
  String get medicineDoseScheduleTitle => 'Схема доз';

  @override
  String get medicineDoseScheduleSubtitle =>
      'Следующий день курса с дозировкой по времени.';

  @override
  String get medicineHistoryLoadError => 'Ошибка';

  @override
  String get scheduleDoseTabletsAtTime => 'Таблеток в это время';

  @override
  String get scheduleDoseAmountAtTime => 'Доза в это время';

  @override
  String get schedulePreviewFutureRebuilt =>
      'Будущие дозы будут пересобраны по этому расписанию.';

  @override
  String get scheduleComplexTitle => 'Сложное расписание';

  @override
  String get scheduleComplexEditSubtitle =>
      'Можно отдельно редактировать и время, и дозировку для каждой дозы.';

  @override
  String get courseTimelineSupplementInfo =>
      'Этот БАД остается в своей категории, но показывается в общей ленте по времени.';

  @override
  String get courseTimelineMedicationInfo =>
      'Это лекарство остается в своей категории и показывается в общей ленте по времени.';

  @override
  String get supplementNameHint => 'Название БАДа (например, Магний)';

  @override
  String get addDoseAction => 'Добавить дозу';

  @override
  String get addConditionSuggestionsTitle => 'Подсказки по заболеванию';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Выберите заболевание, чтобы увидеть частые шаблоны курсов. Это только ориентиры, их нужно сверять с реальным назначением.';

  @override
  String get addConditionSuggestionsEmpty =>
      'Для этого заболевания больше нет видимых подсказок. Можно выбрать другое заболевание или продолжить вручную.';

  @override
  String get addFlowSupplementTitle => 'Как вы хотите добавить этот БАД?';

  @override
  String get addFlowMedicationTitle => 'С чего начать?';

  @override
  String get addFlowSupplementSubtitle =>
      'БАДы чаще добавляют вручную, но можно выбрать и готовый шаблон, если он подходит.';

  @override
  String get addFlowMedicationSubtitle =>
      'Сначала выберите удобный способ добавления. Ниже все детали можно изменить вручную.';

  @override
  String get addFlowByConditionTitle => 'По заболеванию';

  @override
  String get addFlowByConditionSubtitle =>
      'Посмотреть частые шаблоны для заболевания';

  @override
  String get addFlowQuickTemplateTitle => 'Быстрый шаблон';

  @override
  String get addFlowQuickTemplateSubtitle =>
      'Использовать один из частых готовых курсов';

  @override
  String get addFlowManualTitle => 'Вручную';

  @override
  String get addFlowManualSubtitle => 'Заполнить курс самостоятельно с нуля';

  @override
  String get addAppearanceTitle => 'Внешний вид';

  @override
  String get addAppearanceSubtitle =>
      'Необязательный шаг. Добавьте фото или настройте вид таблетки, чтобы потом ее было легче узнать.';

  @override
  String get addPhotoLabel => 'Фото';

  @override
  String get addQuickStartTitle => 'Быстрый старт';

  @override
  String get addQuickStartSubtitle =>
      'Используйте один из самых частых шаблонов курса одним нажатием.';

  @override
  String get addSkipTemplate => 'Пропустить';

  @override
  String get addUseTemplate => 'Использовать шаблон';

  @override
  String get addRecommendedMetricsTitle => 'Рекомендуемые показатели здоровья';

  @override
  String get addRecommendedMetricsSubtitle =>
      'Эти измерения часто ведут вместе с этим заболеванием. Можно сразу внести первое значение.';

  @override
  String get addSupplementTimelineInfo =>
      'Этот БАД будет показываться вместе с лекарствами в дневной ленте.';

  @override
  String get addMedicationTimelineInfo =>
      'Это лекарство будет показываться в общей дневной ленте вместе с другими курсами.';

  @override
  String get conditionDiabetesTitle => 'Сахарный диабет';

  @override
  String get conditionDiabetesSubtitle => 'Частые схемы длительной терапии';

  @override
  String get conditionHypertensionTitle => 'Гипертония';

  @override
  String get conditionHypertensionSubtitle =>
      'Частые препараты для контроля давления';

  @override
  String get conditionCholesterolTitle => 'Высокий холестерин';

  @override
  String get conditionCholesterolSubtitle =>
      'Частая вечерняя гиполипидемическая терапия';

  @override
  String get conditionThyroidTitle => 'Гипотиреоз';

  @override
  String get conditionThyroidSubtitle =>
      'Типичная утренняя заместительная терапия';

  @override
  String get conditionGerdTitle => 'Рефлюкс / ГЭРБ';

  @override
  String get conditionGerdSubtitle => 'Частый контроль симптомов кислотности';

  @override
  String get conditionAsthmaTitle => 'Астма';

  @override
  String get conditionAsthmaSubtitle =>
      'Частые поддерживающие схемы и варианты для быстрого облегчения';

  @override
  String get conditionAllergyTitle => 'Аллергия';

  @override
  String get conditionAllergySubtitle =>
      'Частый контроль симптомов антигистаминными';

  @override
  String get conditionHeartPreventionTitle =>
      'Заболевания сердца / профилактика';

  @override
  String get conditionHeartPreventionSubtitle =>
      'Частые долгосрочные кардиологические схемы';

  @override
  String get conditionHeartFailureTitle => 'Сердечная недостаточность';

  @override
  String get conditionHeartFailureSubtitle =>
      'Частая поддерживающая терапия для жидкости и давления';

  @override
  String get conditionAtrialFibrillationTitle => 'Фибрилляция предсердий';

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
  String get conditionBphSubtitle => 'Частый контроль мочевых симптомов';

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
      'Типичная таблетированная терапия. Точную дозу сверяйте с назначением.';

  @override
  String get suggestionInsulinName => 'Инсулин';

  @override
  String get suggestionInsulinNote =>
      'Шаблон для инъекций. Тип инсулина, дозу и время нужно подстроить под реальную схему.';

  @override
  String get suggestionAmlodipineName => 'Амлодипин';

  @override
  String get suggestionAmlodipineNote =>
      'Частый прием один раз в день для контроля давления.';

  @override
  String get suggestionLosartanName => 'Лозартан';

  @override
  String get suggestionLosartanNote =>
      'Часто используется как ежедневная длительная терапия.';

  @override
  String get suggestionAtorvastatinName => 'Аторвастатин';

  @override
  String get suggestionAtorvastatinNote =>
      'Частый шаблон ежедневного приема статина.';

  @override
  String get suggestionLevothyroxineName => 'Левотироксин';

  @override
  String get suggestionLevothyroxineNote => 'Обычно принимается утром до еды.';

  @override
  String get suggestionOmeprazoleName => 'Омепразол';

  @override
  String get suggestionOmeprazoleNote => 'Часто принимается утром до еды.';

  @override
  String get suggestionFamotidineName => 'Фамотидин';

  @override
  String get suggestionFamotidineNote =>
      'Используется при симптомах кислотности, часто вечером.';

  @override
  String get suggestionBudesonideFormoterolName => 'Будесонид/Формотерол';

  @override
  String get suggestionBudesonideFormoterolNote =>
      'Частый шаблон поддерживающего ингалятора.';

  @override
  String get suggestionAlbuterolName => 'Альбутерол';

  @override
  String get suggestionAlbuterolNote =>
      'Частый ингалятор для быстрого облегчения по потребности.';

  @override
  String get suggestionCetirizineName => 'Цетиризин';

  @override
  String get suggestionCetirizineNote =>
      'Часто используется один раз в день при симптомах аллергии.';

  @override
  String get suggestionLoratadineName => 'Лоратадин';

  @override
  String get suggestionLoratadineNote =>
      'Частый дневной шаблон антигистаминного.';

  @override
  String get suggestionAspirinName => 'Аспирин';

  @override
  String get suggestionAspirinNote =>
      'Частый шаблон низкой дозы для кардиопрофилактики.';

  @override
  String get suggestionClopidogrelName => 'Клопидогрел';

  @override
  String get suggestionClopidogrelNote =>
      'Часто используется как антиагрегант один раз в день.';

  @override
  String get suggestionFurosemideName => 'Фуросемид';

  @override
  String get suggestionFurosemideNote =>
      'Шаблон диуретика, который часто принимают в первой половине дня.';

  @override
  String get suggestionSpironolactoneName => 'Спиронолактон';

  @override
  String get suggestionSpironolactoneNote =>
      'Частая поддерживающая терапия один раз в день.';

  @override
  String get suggestionApixabanName => 'Апиксабан';

  @override
  String get suggestionApixabanNote =>
      'Частый режим антикоагулянта два раза в день.';

  @override
  String get suggestionMetoprololName => 'Метопролол';

  @override
  String get suggestionMetoprololNote =>
      'Часто используется для контроля частоты пульса.';

  @override
  String get suggestionIbuprofenName => 'Ибупрофен';

  @override
  String get suggestionIbuprofenNote =>
      'Частый шаблон для кратковременного снятия боли.';

  @override
  String get suggestionDiclofenacGelName => 'Гель диклофенак';

  @override
  String get suggestionDiclofenacGelNote =>
      'Шаблон местного противовоспалительного средства для снятия симптомов.';

  @override
  String get suggestionTamsulosinName => 'Тамсулозин';

  @override
  String get suggestionTamsulosinNote => 'Часто принимается вечером после еды.';

  @override
  String get suggestionFinasterideName => 'Финастерид';

  @override
  String get suggestionFinasterideNote =>
      'Частая долгосрочная поддержка один раз в день.';

  @override
  String get suggestionAlendronateName => 'Алендронат';

  @override
  String get suggestionAlendronateNote =>
      'Типичный утренний еженедельный шаблон до еды.';

  @override
  String get suggestionCalciumVitaminDName => 'Кальций + витамин D';

  @override
  String get suggestionCalciumVitaminDNote =>
      'Частый курс БАДов для поддержки костей.';

  @override
  String get suggestionFerrousSulfateName => 'Сульфат железа';

  @override
  String get suggestionFerrousSulfateNote =>
      'Частый шаблон перорального восполнения железа.';

  @override
  String get suggestionFolicAcidName => 'Фолиевая кислота';

  @override
  String get suggestionFolicAcidNote =>
      'Частый шаблон поддерживающего витамина.';

  @override
  String get pdfDoctorReportTitle => 'Отчет для врача';

  @override
  String get pdfSupplementCourseSummary => 'Сводка по курсу БАДов';

  @override
  String get pdfMedicationCourseSummary => 'Сводка по курсу лечения';

  @override
  String get pdfCourseProfileTitle => 'Профиль курса';

  @override
  String get pdfScheduleSnapshotTitle => 'Снимок расписания';

  @override
  String get pdfScheduleSnapshotSubtitle =>
      'Показательный день курса с временем и дозировкой.';

  @override
  String get pdfAdministrationHistoryTitle => 'История приемов';

  @override
  String get pdfAdministrationHistorySubtitle =>
      'Показывает, что было принято и насколько это совпадало с планом.';

  @override
  String get pdfAdherenceLabel => 'Соблюдение';

  @override
  String get pdfSnoozedLabel => 'Отложено';

  @override
  String get pdfClinicalSummaryTitle => 'Клиническая сводка';

  @override
  String get pdfPatientLabel => 'Пациент';

  @override
  String get pdfCaregiverLabel => 'Помогающий человек';

  @override
  String get pdfReportPeriodLabel => 'Период отчета';

  @override
  String get pdfOnTimeRateLabel => 'Точность по времени';

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
  String get pdfStartedLabel => 'Начало';

  @override
  String get pdfInstructionLabel => 'Инструкция';

  @override
  String get pdfNotesLabel => 'Заметки';

  @override
  String get pdfTimelineEmpty => 'Записанной истории приемов пока нет.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return 'В PDF показаны последние $visible записей из $total.';
  }

  @override
  String get pdfTableScheduled => 'По плану';

  @override
  String get pdfTableActual => 'Фактически';

  @override
  String get pdfTableDose => 'Доза';

  @override
  String get pdfTableStatus => 'Статус';

  @override
  String get pdfTableDelay => 'Отклонение';

  @override
  String get pdfOnTime => 'Вовремя';

  @override
  String get pdfMinuteShort => 'мин';

  @override
  String get pdfNoFoodRestriction => 'Без ограничений по еде';
}
