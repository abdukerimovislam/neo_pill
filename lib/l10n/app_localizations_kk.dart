// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Бүгінгі кесте';

  @override
  String get architectureReady => 'Архитектура дайын. Жүйелер қалыпты.';

  @override
  String get nextCreateHome => 'Келесі: Басты экран';

  @override
  String get statusTaken => 'Қабылданды';

  @override
  String get statusSkipped => 'Өткізіп жіберілді';

  @override
  String get statusSnoozed => '10 мин шегерілді';

  @override
  String get statusPending => 'Күтілуде';

  @override
  String get emptySchedule => 'Бұл күнге дәрілер жоспарланбаған';

  @override
  String get takeAction => 'Қабылдау';

  @override
  String get skipAction => 'Өткізіп жіберу';

  @override
  String get dosageUnitMg => 'мг';

  @override
  String get dosageUnitMl => 'мл';

  @override
  String get dosageUnitDrops => 'тамшы';

  @override
  String get dosageUnitPcs => 'дана';

  @override
  String get dosageUnitG => 'г';

  @override
  String get dosageUnitMcg => 'мкг';

  @override
  String get dosageUnitIu => 'ХБ';

  @override
  String get addMedicationTitle => 'Дәрі қосу';

  @override
  String get medicineNameHint => 'Атауы (мыс. Д дәрумені)';

  @override
  String get dosageHint => 'Мөлшері (мыс. 500)';

  @override
  String get saveAction => 'Сақтау және кесте құру';

  @override
  String get errorEmptyFields => 'Барлық өрістерді толтырыңыз';

  @override
  String get profileTitle => 'Профиль';

  @override
  String notificationTitle(String name) {
    return '$name қабылдау уақыты келді!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Мөлшері: $dosage. Ұмытпаңыз.';
  }

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get adherenceRate => 'Сақталу көрсеткіші';

  @override
  String get dosesTaken => 'Қабылданды';

  @override
  String get dosesMissed => 'Өткізілді';

  @override
  String get activeCourses => 'Белсенді курстар';

  @override
  String get tabHome => 'Кесте';

  @override
  String get tabAnalytics => 'Статистика';

  @override
  String get keepItUp => 'Керемет! Осылай жалғастырыңыз.';

  @override
  String get needsAttention =>
      'Назар аударыңыз. Дәріні жіберіп алмауға тырысыңыз.';

  @override
  String get medicineDetails => 'Дәрі туралы ақпарат';

  @override
  String get pillsRemaining => 'Қалдығы';

  @override
  String get deleteCourse => 'Курсты жою';

  @override
  String get deleteConfirmation =>
      'Осы курсты және оның ескертулерін өшіргіңіз келе ме?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" қосылды.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" жаңартылды.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" жойылды.';
  }

  @override
  String get cancel => 'Болдырмау';

  @override
  String get delete => 'Жою';

  @override
  String get timeOfDay => 'Күн уақыты';

  @override
  String get courseDuration => 'Ұзақтығы (күн)';

  @override
  String get pillsInPackage => 'Қаптамадағы саны';

  @override
  String get addTime => 'Уақыт қосу';

  @override
  String timeLabel(int number) {
    return 'Уақыт $number';
  }

  @override
  String get foodBefore => 'Тамаққа дейін';

  @override
  String get foodWith => 'Тамақпен бірге';

  @override
  String get foodAfter => 'Тамақтан кейін';

  @override
  String get foodNoMatter => 'Бәрібір';

  @override
  String get unknownMedicine => 'Белгісіз дәрі';

  @override
  String get addPhoto => 'Сурет қосу';

  @override
  String get takePhoto => 'Суретке түсіру';

  @override
  String get chooseFromGallery => 'Галереядан таңдау';

  @override
  String get medicineInfo => 'Ақпарат';

  @override
  String get formTitle => 'Пішіні';

  @override
  String get scheduleTitle => 'Кесте';

  @override
  String get everyXDays => 'Әр X күн сайын';

  @override
  String get maxDosesPerDay => 'Күніне макс. мөлшер (Қауіпсіздік)';

  @override
  String get overdoseWarning => 'Артық мөлшерді болдырмау үшін.';

  @override
  String get foodInstructionTitle => 'Тамақтану ережесі';

  @override
  String doseNumber(int number) {
    return 'Мөлшер $number';
  }

  @override
  String get coursePaused => 'Курс тоқтатылды';

  @override
  String get resumeCourse => 'Жалғастыру';

  @override
  String get pauseCourse => 'Тоқтату';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" тоқтатылды.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" жалғастырылды.';
  }

  @override
  String get doctorReport => 'Дәрігерге арналған есеп';

  @override
  String get generatingReport => 'Есеп жасалуда...';

  @override
  String errorGeneratingReport(String error) {
    return 'Қате: $error';
  }

  @override
  String get editCourse => 'Өңдеу';

  @override
  String get saveChanges => 'Сақтау';

  @override
  String get editMedicineInfo => 'Ақпаратты өңдеу';

  @override
  String lowStockTitle(String name) {
    return 'Аз қалды: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Барлығы $count $unit қалды. Толықтыратын уақыт!';
  }

  @override
  String get lowStockBadge => 'Аз қалды';

  @override
  String get snoozeAction => 'Кейінге қалдыру (30м)';

  @override
  String get undoAction => 'Болдырмау';

  @override
  String get sosPanelTitle => 'Қажеттілікке қарай (SOS)';

  @override
  String get takeNowAction => 'Қазір қабылдау';

  @override
  String get limitReachedAlert => 'Күнделікті шекке жетті!';

  @override
  String get addSosMedicine => 'SOS қосу';

  @override
  String get outOfStockBadge => 'Таусылды';

  @override
  String get recentHistory => 'Соңғы тарихы';

  @override
  String get noHistoryYet => 'Тарих жоқ';

  @override
  String get lifetimeCourse => 'Тұрақты (Өмір бойы)';

  @override
  String get doneAction => 'Дайын';

  @override
  String get addMeasurement => 'Дерек қосу';

  @override
  String get bloodPressure => 'Қан қысымы';

  @override
  String get heartRate => 'Жүрек соғысы';

  @override
  String get weight => 'Салмақ';

  @override
  String get bloodSugar => 'Қандағы қант';

  @override
  String get systolic => 'Сис';

  @override
  String get diastolic => 'Диа';

  @override
  String get taperingDosing => 'Динамикалық мөлшер';

  @override
  String stepNumber(int number) {
    return 'Қадам $number';
  }

  @override
  String get addStep => 'Қадам қосу';

  @override
  String get doseForStep => 'Осы қадам үшін мөлшер';

  @override
  String get whatWouldYouLikeToDo => 'Не істегіңіз келеді?';

  @override
  String get scheduleNewTreatmentCourse => 'Жаңа курс қосу';

  @override
  String get logHealthMetricsSubtitle => 'Қысым, жүрек соғысы, салмақ';

  @override
  String get priorityAction => 'Негізгі әрекет';

  @override
  String get skipDoseAction => 'Өткізіп жіберу';

  @override
  String errorPrefix(String error) {
    return 'Қате: $error';
  }

  @override
  String get goodMorning => 'Қайырлы таң';

  @override
  String get goodAfternoon => 'Қайырлы күн';

  @override
  String get goodEvening => 'Қайырлы кеш';

  @override
  String get dailyProgress => 'Күнделікті прогресс';

  @override
  String get sosEmergency => 'SOS шұғыл';

  @override
  String get adherenceSubtitle => 'Сіздің тұрақтылығыңыз';

  @override
  String get healthCorrelationTitle => 'Денсаулық байланысы';

  @override
  String get healthCorrelationSubtitle =>
      'Дәрі қабылдау мен денсаулықты салыстырыңыз';

  @override
  String get last7Days => 'Соңғы 7 күн';

  @override
  String get pillsTaken => 'Дәрі қабылданды';

  @override
  String get overallAdherence => 'Жалпы тұрақтылық';

  @override
  String get statusGood => 'Жақсы';

  @override
  String get statusNeedsAttention => 'Назар аударыңыз';

  @override
  String get statTaken => 'Қабылданды';

  @override
  String get statSkipped => 'Өткізілді';

  @override
  String get statTotal => 'Барлығы';

  @override
  String get completedDosesSubtitle => 'Аяқталған дозалар';

  @override
  String get missedDosesSubtitle => 'Өткізіліп кеткендер';

  @override
  String get noDataYet => 'Деректер жоқ';

  @override
  String get noDataDescription => 'Осында статистика пайда болады.';

  @override
  String get failedToLoadAdherence => 'Қате';

  @override
  String get failedToLoadChart => 'Қате';

  @override
  String avgAdherence(String value) {
    return 'Орт. $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Орт. $metricName $value';
  }

  @override
  String get addAction => 'Қосу';

  @override
  String get frequency => 'Жиілігі';

  @override
  String get form => 'Пішіні';

  @override
  String get inventory => 'Қалдығы';

  @override
  String get lowStockAlert => 'АЗ ҚАЛДЫ';

  @override
  String get asNeededFrequency => 'ҚАЖЕТТІЛІК БОЙЫНША';

  @override
  String get taperingFrequency => 'ДИНАМИКАЛЫҚ';

  @override
  String get customizePill => 'Өзгерту';

  @override
  String get customizePillTitle => 'Таблетканы өзгерту';

  @override
  String get shape => 'Пішіні';

  @override
  String get color => 'Түсі';

  @override
  String get overview => 'Жалпы ақпарат';

  @override
  String get scheduleAndRules => 'Кесте және ережелер';

  @override
  String get duration => 'Ұзақтығы';

  @override
  String get reminders => 'Ескертулер';

  @override
  String get daysSuffix => 'күн';

  @override
  String get pcsSuffix => 'дана';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get personalInfo => 'Жеке мәліметтер';

  @override
  String get appPreferences => 'Қосымша баптаулары';

  @override
  String get darkMode => 'Қараңғы режим';

  @override
  String get language => 'Тіл';

  @override
  String get notifications => 'Ескертулер';

  @override
  String get advancedFeatures => 'Қосымша баптаулар';

  @override
  String get caregivers => 'Көмекшілер';

  @override
  String get drugInteractions => 'Өзара әрекеттесулер';

  @override
  String get comingSoon => 'ЖАҚЫНДА';

  @override
  String get supportAndAbout => 'Қолдау және ақпарат';

  @override
  String get contactSupport => 'Қолдау қызметі';

  @override
  String get privacyPolicy => 'Құпиялылық саясаты';

  @override
  String get logout => 'Шығу';

  @override
  String get tabSettings => 'Профиль';

  @override
  String get defaultUserName => 'Дос';

  @override
  String get courseKindMedication => 'Дәрі';

  @override
  String get courseKindSupplement => 'Қосымша';

  @override
  String get courseFilterAll => 'Барлығы';

  @override
  String get courseFilterMedications => 'Дәрілер';

  @override
  String get courseFilterSupplements => 'Қосымшалар';

  @override
  String get homeTakeMedicationNow => 'Дәріні қазір қабылдау';

  @override
  String get homeTakeSupplementNow => 'Қосымшаны қазір қабылдау';

  @override
  String get homeEmptyAllTitle => 'Әзірге дәрілер жоқ';

  @override
  String get homeEmptyMedicationsTitle => 'Дәрілер жоқ';

  @override
  String get homeEmptySupplementsTitle => 'Қосымшалар жоқ';

  @override
  String get homeEmptyAllSubtitle => 'Қазір ештеңе істеудің қажеті жоқ.';

  @override
  String get homeEmptyMedicationsSubtitle => 'Бұл күнге жоспарланған дәрі жоқ.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'Бұл күнге жоспарланған қосымша жоқ.';

  @override
  String get homeAddSupplementTitle => 'Қосымша қосу';

  @override
  String get homeAddSupplementSubtitle => 'Дәрумендерді жоспарлау';

  @override
  String get homeForThisDay => 'Бұл күн үшін';

  @override
  String get homeMorningRoutine => 'Таңертең';

  @override
  String get homeAfternoonRoutine => 'Күндіз';

  @override
  String get homeEveningRoutine => 'Кешке';

  @override
  String get homeNightRoutine => 'Түнде';

  @override
  String get homeRoutineSupplementsOnly => 'тек қосымшалар';

  @override
  String get homeRoutineMedicationsOnly => 'тек дәрілер';

  @override
  String get homeRoutineMixed => 'аралас';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нәрсе',
      one: '1 нәрсе',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Назар аударыңыз';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    return 'Жоспарланған $count нәрсе.';
  }

  @override
  String get homeNextUpTitle => 'Келесі';

  @override
  String get homeRefillReminderTitle => 'Қалдықты тексеру';

  @override
  String homeRefillReminderSubtitle(int count) {
    return '$count курс толықтыруды қажет етеді.';
  }

  @override
  String get homeEverythingCalmTitle => 'Бәрі тыныш';

  @override
  String get homeEverythingCalmSubtitle => 'Қазір шұғыл ештеңе жоқ.';

  @override
  String get homeNoUpcomingItem => 'Жақын арада жоспар жоқ.';

  @override
  String homeScheduledFor(String time) {
    return '$time уақытына жоспарланған';
  }

  @override
  String get calendarToday => 'Бүгін';

  @override
  String get calendarSelectedDay => 'Таңдалған күн';

  @override
  String get calendarShowingToday => 'Бүгінгі кестені көрсетуде';

  @override
  String get calendarBrowseNearbyDays =>
      'Басқа күнді көру үшін дөңгелекті айналдырыңыз';

  @override
  String get calendarPreviewAnotherDay => 'Алдын ала көру.';

  @override
  String get calendarDayWheelSemantics => 'Күн дөңгелегі';

  @override
  String get analyticsCourseMix => 'Курстар';

  @override
  String get analyticsCourseMixSubtitle => 'Дәрілер мен қосымшалар';

  @override
  String get analyticsCurrentRoutine => 'Ағымдағы серия';

  @override
  String get analyticsCurrentRoutineSubtitle => 'Қатесіз күндер';

  @override
  String get analyticsTimingAccuracy => 'Дәлдік';

  @override
  String get analyticsTimingAccuracySubtitle => '30 минут ішінде қабылданған';

  @override
  String get analyticsBestRoutine => 'Үздік нәтиже';

  @override
  String get analyticsBestRoutineSubtitle => 'Соңғы 90 күнде';

  @override
  String get analyticsRefillRisk => 'Таусылу қаупі';

  @override
  String get analyticsRefillRiskSubtitle => 'Қоры аз қалған';

  @override
  String get analyticsAverageDelay => 'Орташа кешігу';

  @override
  String get analyticsMinutesShort => 'мин';

  @override
  String get analyticsCoachNote => 'Кеңес';

  @override
  String get analyticsMissedDoses => 'Өткізілген дозалар';

  @override
  String analyticsActiveShort(int count) {
    return '$count белсенді';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Қабылданды: $taken  Өткізілді: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Қолдау қызметі';

  @override
  String get settingsContactSupportBody => 'Егер мәселе болса бізге жазыңыз.';

  @override
  String get settingsSupportEmailCopied => 'Пошта көшірілді';

  @override
  String get settingsCopySupportEmail => 'Поштаны көшіру';

  @override
  String get settingsPrivacyTitle => 'Құпиялылық саясаты';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Мәліметтеріңіз құрылғыда сақталады.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Суреттер мен есептер сіз қалағанда ғана жасалады.';

  @override
  String get settingsPrivacyLaunchNote => 'Саясатты жариялаңыз.';

  @override
  String get settingsLanguageEnglish => 'Ағылшын тілі';

  @override
  String get settingsLanguageRussian => 'Орыс тілі';

  @override
  String get settingsYourProfilePreferences => 'Профиль және баптаулар';

  @override
  String get settingsComfortModeTitle => 'Жайлылық режимі';

  @override
  String get settingsComfortModeSubtitle => 'Үлкен мәтін';

  @override
  String get settingsNotificationsEnabled => 'Ескертулер қосулы';

  @override
  String get settingsOn => 'Қосулы';

  @override
  String get settingsSupportAndSafety => 'Қолдау және қауіпсіздік';

  @override
  String get settingsShowOnboardingAgain => 'Бастапқы нұсқаулықты қайта ашу';

  @override
  String get settingsShowOnboardingAgainSubtitle => 'Нұсқаулықты ашу';

  @override
  String get settingsFeaturePolishing => 'Бұл функция жасалуда';

  @override
  String get settingsCaregiverTitle => 'Көмекшілер';

  @override
  String get settingsCaregiverDescription => 'Сенімді адамды қосыңыз.';

  @override
  String get settingsCaregiverName => 'Көмекшінің аты';

  @override
  String get settingsCaregiverRelation => 'Байланыс';

  @override
  String get settingsCaregiverPhone => 'Телефон нөмірі';

  @override
  String get settingsCaregiverShareReports => 'Есепке қосу';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Олардың байланысы есепте болады.';

  @override
  String get settingsCaregiverSaved => 'Сақталды';

  @override
  String get settingsCaregiverRemoved => 'Өшірілді';

  @override
  String get settingsCaregiverRemove => 'Өшіру';

  @override
  String get settingsCaregiverEmpty => 'Көмекші қосыңыз';

  @override
  String get settingsCaregiverAlertsTitle => 'Көмекшіге ескерту';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Кешігу болса хабарлама дайындайды.';

  @override
  String get settingsCaregiverAlertsEmpty => 'Алдымен көмекшіні қосыңыз';

  @override
  String get settingsCaregiverAlertsDisabled => 'Ескертулер өшірулі';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return '$minutes минуттан кейін дайын болады';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Хабарлама дайындау';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Жіберуге дайын хабарлама.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Күту уақыты';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return '$minutes минут күту.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes мин';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Кешіккен дозалар';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle => 'Кешігуде хабарлама.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Өткізілген дозалар';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle => 'Қалдырғанда хабарлама.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Қосымшаларды қосу';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Дәрумендер үшін қолдану.';

  @override
  String get settingsCaregiverAlertsSaved => 'Ережелер сақталды';

  @override
  String get settingsCaregiverConnectedTitle => 'Желілік байланыс';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Ескертулер үшін тұрақты байланыс.';

  @override
  String get settingsCaregiverConnectedReady => 'Код дайын.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count хабарлама күтілуде.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Байланыс коды';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Осы кодты көмекшіге беріңіз.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Шығыс хаттар';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Соңғы: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Кодты көшіру';

  @override
  String get settingsCaregiverConnectedCodeCopied => 'Көшірілді';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Тазарту';

  @override
  String get settingsCaregiverConnectedOutboxCleared => 'Тазартылды';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Желілік режим';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Бұл құрылғы емделуші ретінде жұмыс істейді.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return '$patientName үшін көмекші.';
  }

  @override
  String get settingsCaregiverConnectedModeNone => 'Желіге қосылмаған.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Байланған код: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle => 'Кіріс хаттар';

  @override
  String get settingsCaregiverConnectedInboxEmpty => 'Жаңа хабарлама жоқ.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Емделуші ретінде қолдану';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Емделуші ретінде қосылды';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Көмекші ретінде қосылу';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Қосылу';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Емделушінің кодын енгізіңіз.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Қосылу';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Көмекші ретінде қосылды';

  @override
  String get settingsCaregiverConnectedJoinFailed => 'Код табылмады';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Ажырату';

  @override
  String get settingsCaregiverConnectedDisconnected => 'Желіден ажыратылды.';

  @override
  String get caregiverCloudNotificationTitle => 'Көмекшіге хабарлама';

  @override
  String get caregiverAlertCardTitle => 'Хабарлама дайын';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName $count нәрсе туралы хабардар бола алады.';
  }

  @override
  String get caregiverAlertReviewAction => 'Қарау және көшіру';

  @override
  String get caregiverAlertSheetTitle => 'Көмекшіге хабарлама';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return '$caregiverName үшін дайындалған хабарлама.';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return '$minutes минутқа кешікті';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Өткізіп жіберілген';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Жоспарланған $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote => 'Көшіріп жіберіңіз.';

  @override
  String get caregiverAlertCopyMessage => 'Мәтінді көшіру';

  @override
  String get caregiverAlertCopyPhone => 'Нөмірді көшіру';

  @override
  String get caregiverAlertNoPhone => 'Нөмір жоқ';

  @override
  String get caregiverAlertMessageCopied => 'Көшірілді';

  @override
  String get caregiverAlertPhoneCopied => 'Нөмір көшірілді';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Сәлем, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Бұл $patientName үшін жаңарту:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — $time, кешігу $minutes мин';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — $time, өткізілді';
  }

  @override
  String get caregiverAlertMessageFooter => 'Назар аударыңыз.';

  @override
  String get settingsSupportEmailSubtitle => 'Қолдау қызметінің поштасы';

  @override
  String get settingsPrivacySubtitle => 'Деректер қалай сақталады';

  @override
  String get settingsExampleName => 'Мысалы, Алекс';

  @override
  String get settingsSave => 'Сақтау';

  @override
  String get onboardingStartUsing => 'Pillora-ны бастау';

  @override
  String get onboardingContinue => 'Жалғастыру';

  @override
  String get onboardingBack => 'Артқа';

  @override
  String get onboardingWelcomeTitle => 'Сіздің денсаулық көмекшіңіз';

  @override
  String get onboardingWelcomeTagline => 'Қарапайым және түсінікті.';

  @override
  String get onboardingWelcomeBody =>
      'Нені және қашан ішу керек екенін көресіз.';

  @override
  String get onboardingFeatureEasyInterface => 'Түсінікті интерфейс';

  @override
  String get onboardingFeatureNextDose => 'Келесі дозаға назар аудару';

  @override
  String get onboardingFeatureReminders => 'Ескертулер мен қорлар';

  @override
  String get onboardingTailorTitle => 'Қосымшаны сізге бейімдейміз';

  @override
  String get onboardingTailorSubtitle => 'Профильде өзгертуге болады.';

  @override
  String get onboardingNamePrompt => 'Атыңыз кім?';

  @override
  String get onboardingLanguageTitle => 'Тіл';

  @override
  String get onboardingReadingComfort => 'Оқуға ыңғайлылық';

  @override
  String get onboardingComfortModeTitle => 'Жайлылық режимі';

  @override
  String get onboardingComfortModeSubtitle => 'Үлкен мәтін.';

  @override
  String get onboardingReadyTitle => 'Бәрі дайын';

  @override
  String get onboardingReadyBanner => 'Басты экранда маңызды нәрселер ғана.';

  @override
  String get onboardingReadyBody => 'Статистика бөлек болады.';

  @override
  String get onboardingReadySummaryHome => 'Қарапайым басты экран';

  @override
  String get onboardingReadySummaryActions => 'Нақты әрекеттер';

  @override
  String get onboardingReadySummaryComfortOn => 'Жайлылық режимі қосулы';

  @override
  String get onboardingReadySummaryComfortLater => 'Профильде өзгертуге болады';

  @override
  String get medicineStandardCourse => 'Стандартты курс';

  @override
  String get medicineComplexCourse => 'Күрделі курс';

  @override
  String get schedulePreviewTitle => 'Алдын ала көру';

  @override
  String get scheduleDoseAtTime => 'Мөлшері';

  @override
  String get courseTypeLabel => 'Курс түрі';

  @override
  String get addSupplementScreenTitle => 'Қосымша қосу';

  @override
  String get editSupplementTitle => 'Өңдеу';

  @override
  String get settingsLanguageChangeLater => 'Кейін өзгерте аласыз';

  @override
  String get homeNothingDueTitle => 'Әзірге ештеңе жоқ';

  @override
  String get homeUseDayWheelSubtitle => 'Дөңгелекті қолданыңыз.';

  @override
  String get homeNoAttentionRightNow => 'Қазір ештеңе қажет емес.';

  @override
  String get homeAddItemFab => 'Қосу';

  @override
  String get homeTimelineSubtitle => 'Уақыт бойынша.';

  @override
  String get analyticsCoachGreat => 'Керемет, осылай жалғастырыңыз!';

  @override
  String get analyticsCoachMissed => 'Бір уақытта ішуге тырысыңыз.';

  @override
  String get analyticsCoachTiming => 'Дәлдікті жақсартыңыз.';

  @override
  String get medicineFrequencyDaily => 'Күн сайын';

  @override
  String get medicineFrequencySpecificDays => 'Таңдалған күндер';

  @override
  String get medicineFrequencyInterval => 'Интервалмен';

  @override
  String get medicineFrequencyCycle => 'Цикл';

  @override
  String get medicineFormTablet => 'Таблетка';

  @override
  String get medicineFormCapsule => 'Капсула';

  @override
  String get medicineFormLiquid => 'Сұйықтық';

  @override
  String get medicineFormInjection => 'Инъекция';

  @override
  String get medicineFormDrops => 'Тамшы';

  @override
  String get medicineFormOintment => 'Май';

  @override
  String get medicineFormSpray => 'Спрей';

  @override
  String get medicineFormInhaler => 'Ингалятор';

  @override
  String get medicineFormPatch => 'Пластырь';

  @override
  String get medicineFormSuppository => 'Суппозиторий';

  @override
  String get medicineTimelineSupplementInfo => 'Кестеде көрінеді.';

  @override
  String get medicineTimelineMedicationInfo => 'Курстың бір бөлігі.';

  @override
  String get medicineDoseScheduleTitle => 'Кесте';

  @override
  String get medicineDoseScheduleSubtitle => 'Әр күн үшін.';

  @override
  String get medicineHistoryLoadError => 'Қате';

  @override
  String get scheduleDoseTabletsAtTime => 'Таблеткалар';

  @override
  String get scheduleDoseAmountAtTime => 'Мөлшері';

  @override
  String get schedulePreviewFutureRebuilt => 'Болашақтағы кесте.';

  @override
  String get scheduleComplexTitle => 'Күрделі кесте';

  @override
  String get scheduleComplexEditSubtitle => 'Әр дозаны өзгертуге болады.';

  @override
  String get courseTimelineSupplementInfo => 'Дәрумендер бөлімінде.';

  @override
  String get courseTimelineMedicationInfo => 'Дәрілер бөлімінде.';

  @override
  String get supplementNameHint => 'Аты (мыс. Магний)';

  @override
  String get addDoseAction => 'Доза қосу';

  @override
  String get addConditionSuggestionsTitle => 'Ұсыныстар';

  @override
  String get addConditionSuggestionsSubtitle => 'Үлгілер.';

  @override
  String get addConditionSuggestionsEmpty => 'Басқа ұсыныс жоқ.';

  @override
  String get addFlowSupplementTitle => 'Қалай қосамыз?';

  @override
  String get addFlowMedicationTitle => 'Қалай бастаймыз?';

  @override
  String get addFlowSupplementSubtitle => 'Үлгілер бар.';

  @override
  String get addFlowMedicationSubtitle => 'Қарапайымын таңдаңыз.';

  @override
  String get addFlowByConditionTitle => 'Ауру бойынша';

  @override
  String get addFlowByConditionSubtitle => 'Ауруларға арналған үлгілер';

  @override
  String get addFlowQuickTemplateTitle => 'Жылдам үлгі';

  @override
  String get addFlowQuickTemplateSubtitle => 'Дайын үлгіні қолдану';

  @override
  String get addFlowManualTitle => 'Өз бетімен';

  @override
  String get addFlowManualSubtitle => 'Қолмен толтыру';

  @override
  String get addAppearanceTitle => 'Сыртқы түрі';

  @override
  String get addAppearanceSubtitle => 'Сурет қосыңыз.';

  @override
  String get addPhotoLabel => 'Сурет';

  @override
  String get addQuickStartTitle => 'Жылдам бастау';

  @override
  String get addQuickStartSubtitle => 'Үлгіні қолдану.';

  @override
  String get addSkipTemplate => 'Өткізу';

  @override
  String get addUseTemplate => 'Қолдану';

  @override
  String get addRecommendedMetricsTitle => 'Ұсынылған көрсеткіштер';

  @override
  String get addRecommendedMetricsSubtitle => 'Жиі тіркеледі.';

  @override
  String get addSupplementTimelineInfo => 'Кестеде шығады.';

  @override
  String get addMedicationTimelineInfo => 'Кестеде шығады.';

  @override
  String get conditionDiabetesTitle => 'Қант диабеті';

  @override
  String get conditionDiabetesSubtitle => 'Ұзақ мерзімді терапия';

  @override
  String get conditionHypertensionTitle => 'Гипертония';

  @override
  String get conditionHypertensionSubtitle => 'Қан қысымын бақылау';

  @override
  String get conditionCholesterolTitle => 'Жоғары холестерин';

  @override
  String get conditionCholesterolSubtitle => 'Кешкі терапия';

  @override
  String get conditionThyroidTitle => 'Қалқанша без';

  @override
  String get conditionThyroidSubtitle => 'Таңертең';

  @override
  String get conditionGerdTitle => 'Асқазан қышқылы';

  @override
  String get conditionGerdSubtitle => 'Бақылау';

  @override
  String get conditionAsthmaTitle => 'Астма';

  @override
  String get conditionAsthmaSubtitle => 'Ингаляторлар';

  @override
  String get conditionAllergyTitle => 'Аллергия';

  @override
  String get conditionAllergySubtitle => 'Антигистаминдер';

  @override
  String get conditionHeartPreventionTitle => 'Жүрек ауруларының алдын алу';

  @override
  String get conditionHeartPreventionSubtitle => 'Кардиология';

  @override
  String get conditionHeartFailureTitle => 'Жүрек жеткіліксіздігі';

  @override
  String get conditionHeartFailureSubtitle => 'Қысымды қолдау';

  @override
  String get conditionAtrialFibrillationTitle => 'Жүрек ырғағы';

  @override
  String get conditionAtrialFibrillationSubtitle => 'Инсульттің алдын алу';

  @override
  String get conditionJointPainTitle => 'Буын ауруы';

  @override
  String get conditionJointPainSubtitle => 'Ауырсынуды басу';

  @override
  String get conditionBphTitle => 'Простата / Қуық асты безі';

  @override
  String get conditionBphSubtitle => 'Зәр шығаруды бақылау';

  @override
  String get conditionOsteoporosisTitle => 'Остеопороз';

  @override
  String get conditionOsteoporosisSubtitle => 'Сүйектерді қолдау';

  @override
  String get conditionAnemiaTitle => 'Анемия';

  @override
  String get conditionAnemiaSubtitle => 'Темірмен толықтыру';

  @override
  String get suggestionMetforminName => 'Метформин';

  @override
  String get suggestionMetforminNote => 'Оральді терапия.';

  @override
  String get suggestionInsulinName => 'Инсулин';

  @override
  String get suggestionInsulinNote => 'Инъекция.';

  @override
  String get suggestionAmlodipineName => 'Амлодипин';

  @override
  String get suggestionAmlodipineNote => 'Қан қысымы.';

  @override
  String get suggestionLosartanName => 'Лозартан';

  @override
  String get suggestionLosartanNote => 'Ұзақ мерзімді.';

  @override
  String get suggestionAtorvastatinName => 'Аторвастатин';

  @override
  String get suggestionAtorvastatinNote => 'Күнделікті статин.';

  @override
  String get suggestionLevothyroxineName => 'Левотироксин';

  @override
  String get suggestionLevothyroxineNote => 'Таңертең тамаққа дейін.';

  @override
  String get suggestionOmeprazoleName => 'Омепразол';

  @override
  String get suggestionOmeprazoleNote => 'Таңертең тамаққа дейін.';

  @override
  String get suggestionFamotidineName => 'Фамотидин';

  @override
  String get suggestionFamotidineNote => 'Кешке.';

  @override
  String get suggestionBudesonideFormoterolName => 'Будесонид/Формотерол';

  @override
  String get suggestionBudesonideFormoterolNote => 'Ингалятор.';

  @override
  String get suggestionAlbuterolName => 'Сальбутамол';

  @override
  String get suggestionAlbuterolNote => 'SOS ингалятор.';

  @override
  String get suggestionCetirizineName => 'Цетиризин';

  @override
  String get suggestionCetirizineNote => 'Аллергия.';

  @override
  String get suggestionLoratadineName => 'Лоратадин';

  @override
  String get suggestionLoratadineNote => 'Аллергия.';

  @override
  String get suggestionAspirinName => 'Аспирин';

  @override
  String get suggestionAspirinNote => 'Жүрек.';

  @override
  String get suggestionClopidogrelName => 'Клопидогрел';

  @override
  String get suggestionClopidogrelNote => 'Күнделікті.';

  @override
  String get suggestionFurosemideName => 'Фуросемид';

  @override
  String get suggestionFurosemideNote => 'Диуретик.';

  @override
  String get suggestionSpironolactoneName => 'Спиронолактон';

  @override
  String get suggestionSpironolactoneNote => 'Қолдау.';

  @override
  String get suggestionApixabanName => 'Апиксабан';

  @override
  String get suggestionApixabanNote => 'Антикоагулянт.';

  @override
  String get suggestionMetoprololName => 'Метопролол';

  @override
  String get suggestionMetoprololNote => 'Жүрек ырғағы.';

  @override
  String get suggestionIbuprofenName => 'Ибупрофен';

  @override
  String get suggestionIbuprofenNote => 'Ауырсынуға қарсы.';

  @override
  String get suggestionDiclofenacGelName => 'Диклофенак';

  @override
  String get suggestionDiclofenacGelNote => 'Жақпа май.';

  @override
  String get suggestionTamsulosinName => 'Тамсулозин';

  @override
  String get suggestionTamsulosinNote => 'Кешке.';

  @override
  String get suggestionFinasterideName => 'Финастерид';

  @override
  String get suggestionFinasterideNote => 'Күнделікті.';

  @override
  String get suggestionAlendronateName => 'Алендронат';

  @override
  String get suggestionAlendronateNote => 'Аптасына бір рет.';

  @override
  String get suggestionCalciumVitaminDName => 'Кальций + Дәрумен D';

  @override
  String get suggestionCalciumVitaminDNote => 'Сүйектер.';

  @override
  String get suggestionFerrousSulfateName => 'Темір сульфаты';

  @override
  String get suggestionFerrousSulfateNote => 'Темір.';

  @override
  String get suggestionFolicAcidName => 'Фолий қышқылы';

  @override
  String get suggestionFolicAcidNote => 'Дәрумен.';

  @override
  String get pdfDoctorReportTitle => 'Дәрігерге арналған есеп';

  @override
  String get pdfSupplementCourseSummary => 'Қосымшалар';

  @override
  String get pdfMedicationCourseSummary => 'Дәрілер';

  @override
  String get pdfCourseProfileTitle => 'Курс профилі';

  @override
  String get pdfScheduleSnapshotTitle => 'Кесте';

  @override
  String get pdfScheduleSnapshotSubtitle => 'Уақыт пен мөлшер.';

  @override
  String get pdfAdministrationHistoryTitle => 'Қабылдау тарихы';

  @override
  String get pdfAdministrationHistorySubtitle => 'Қаншалықты дәл қабылданды.';

  @override
  String get pdfAdherenceLabel => 'Тұрақтылық';

  @override
  String get pdfSnoozedLabel => 'Шегерілді';

  @override
  String get pdfClinicalSummaryTitle => 'Клиникалық ақпарат';

  @override
  String get pdfPatientLabel => 'Емделуші';

  @override
  String get pdfCaregiverLabel => 'Көмекші';

  @override
  String get pdfReportPeriodLabel => 'Кезең';

  @override
  String get pdfOnTimeRateLabel => 'Уақытылы';

  @override
  String get pdfAverageDelayLabel => 'Орташа кешігу';

  @override
  String get pdfUpcomingDosesLabel => 'Келесі';

  @override
  String get pdfStockLeftLabel => 'Қалдық';

  @override
  String get pdfNameLabel => 'Аты';

  @override
  String get pdfCourseTypeLabel => 'Түрі';

  @override
  String get pdfDosageLabel => 'Мөлшері';

  @override
  String get pdfFrequencyLabel => 'Жиілігі';

  @override
  String get pdfStartedLabel => 'Басталды';

  @override
  String get pdfInstructionLabel => 'Ережесі';

  @override
  String get pdfNotesLabel => 'Ескертпе';

  @override
  String get pdfTimelineEmpty => 'Тарих жоқ.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return '$total жазбаның $visible көрсетілуде.';
  }

  @override
  String get pdfTableScheduled => 'Жоспар';

  @override
  String get pdfTableActual => 'Шын мәнінде';

  @override
  String get pdfTableDose => 'Мөлшері';

  @override
  String get pdfTableStatus => 'Статус';

  @override
  String get pdfTableDelay => 'Кешігу';

  @override
  String get pdfOnTime => 'Уақытылы';

  @override
  String get pdfMinuteShort => 'мин';

  @override
  String get pdfNoFoodRestriction => 'Бәрібір';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Осында көру үшін дәрі немесе қосымша қосыңыз.';

  @override
  String get tabScanner => 'Сканер';

  @override
  String get scannerComingSoonTitle => 'Ақылды Сканер';

  @override
  String get scannerComingSoonText =>
      'Мәліметтерді автотолтыру үшін камераңызды бағыттаңыз. Жақында болады!';

  @override
  String get premiumTitle => 'Pillora Pro';

  @override
  String get premiumSubtitle =>
      'Денсаулық кестеңіздің толық мүмкіндіктерін ашыңыз';

  @override
  String get premiumFeatureCaregiver =>
      'Шексіз көмекшілер және нақты уақыттағы хабарламалар';

  @override
  String get premiumFeatureScanner => 'Жылдам қосу үшін ақылды сканер';

  @override
  String get premiumFeatureSchedules =>
      'Күрделі кестелер (Циклдар, Динамикалық мөлшер)';

  @override
  String get premiumFeatureReports => 'Дәрігерге арналған PDF есептер';

  @override
  String get premiumSubscribeYearly => 'Жылына \$29.99 үшін Pro-ны ашу';

  @override
  String get premiumSubscribeMonthly => 'немесе айына \$4.99';

  @override
  String get premiumRestorePurchases => 'Сатып алуларды қалпына келтіру';
}
