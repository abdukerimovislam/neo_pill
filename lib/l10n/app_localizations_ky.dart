// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Бүгүнкү график';

  @override
  String get architectureReady => 'Архитектура даяр. Бардыгы нормалдуу.';

  @override
  String get nextCreateHome => 'Кийинки: Башкы экран';

  @override
  String get statusTaken => 'Кабыл алынды';

  @override
  String get statusSkipped => 'Өткөрүп жиберилди';

  @override
  String get statusSnoozed => '10 мүнөткө жылдырылды';

  @override
  String get statusPending => 'Күтүлүүдө';

  @override
  String get emptySchedule => 'Бул күнгө дарылар пландалган эмес';

  @override
  String get takeAction => 'Ичүү';

  @override
  String get skipAction => 'Өткөрүп жиберүү';

  @override
  String get dosageUnitMg => 'мг';

  @override
  String get dosageUnitMl => 'мл';

  @override
  String get dosageUnitDrops => 'тамчы';

  @override
  String get dosageUnitPcs => 'даана';

  @override
  String get dosageUnitG => 'г';

  @override
  String get dosageUnitMcg => 'мкг';

  @override
  String get dosageUnitIu => 'ХБ';

  @override
  String get addMedicationTitle => 'Дары кошуу';

  @override
  String get medicineNameHint => 'Аталышы (мис. Витамин D)';

  @override
  String get dosageHint => 'Дозасы (мис. 500)';

  @override
  String get saveAction => 'Сактоо жана график түзүү';

  @override
  String get errorEmptyFields => 'Бардык талааларды толтуруңуз';

  @override
  String get profileTitle => 'Профиль';

  @override
  String notificationTitle(String name) {
    return '$name ичүү убактысы келди!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Дозасы: $dosage. Сураныч, унутпаңыз.';
  }

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get adherenceRate => 'Аткаруу көрсөткүчү';

  @override
  String get dosesTaken => 'Ичилгени';

  @override
  String get dosesMissed => 'Өткөрүп жиберилгени';

  @override
  String get activeCourses => 'Активдүү курстар';

  @override
  String get tabHome => 'График';

  @override
  String get tabAnalytics => 'Статистика';

  @override
  String get keepItUp => 'Эң сонун! Ушундай улантыңыз.';

  @override
  String get needsAttention =>
      'Көңүл буруңуз. Дарыны калтырбоого аракет кылыңыз.';

  @override
  String get medicineDetails => 'Дары тууралуу маалымат';

  @override
  String get pillsRemaining => 'Калдыгы';

  @override
  String get deleteCourse => 'Курсту өчүрүү';

  @override
  String get deleteConfirmation =>
      'Чын эле бул курсту жана анын билдирмелерин өчүргүңүз келеби?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" кошулду.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" жаңыртылды.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" өчүрүлдү.';
  }

  @override
  String get cancel => 'Жокко чыгаруу';

  @override
  String get delete => 'Өчүрүү';

  @override
  String get timeOfDay => 'Күн убактысы';

  @override
  String get courseDuration => 'Узактыгы (күн)';

  @override
  String get pillsInPackage => 'Таңгактагы саны';

  @override
  String get addTime => 'Убакыт кошуу';

  @override
  String timeLabel(int number) {
    return 'Убакыт $number';
  }

  @override
  String get foodBefore => 'Тамакка чейин';

  @override
  String get foodWith => 'Тамак менен';

  @override
  String get foodAfter => 'Тамактан кийин';

  @override
  String get foodNoMatter => 'Айырмасы жок';

  @override
  String get unknownMedicine => 'Белгисиз дары';

  @override
  String get addPhoto => 'Сүрөт кошуу';

  @override
  String get takePhoto => 'Сүрөткө тартуу';

  @override
  String get chooseFromGallery => 'Галереядан тандоо';

  @override
  String get medicineInfo => 'Маалымат';

  @override
  String get formTitle => 'Формасы';

  @override
  String get scheduleTitle => 'График';

  @override
  String get everyXDays => 'Ар X күн сайын';

  @override
  String get maxDosesPerDay => 'Күнүнө макс. доза (Коопсуздук)';

  @override
  String get overdoseWarning => 'Ашыкча дозаны алдын алуу үчүн.';

  @override
  String get foodInstructionTitle => 'Тамактануу эрежеси';

  @override
  String doseNumber(int number) {
    return 'Доза $number';
  }

  @override
  String get coursePaused => 'Курс токтотулду';

  @override
  String get resumeCourse => 'Улантуу';

  @override
  String get pauseCourse => 'Токтотуу';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" токтотулду.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" улантылды.';
  }

  @override
  String get doctorReport => 'Дарыгер үчүн отчет';

  @override
  String get generatingReport => 'Отчет түзүлүүдө...';

  @override
  String errorGeneratingReport(String error) {
    return 'Ката: $error';
  }

  @override
  String get editCourse => 'Өзгөртүү';

  @override
  String get saveChanges => 'Сактоо';

  @override
  String get editMedicineInfo => 'Маалыматты өзгөртүү';

  @override
  String lowStockTitle(String name) {
    return 'Аз калды: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Болгону $count $unit калды. Толуктоо убактысы келди!';
  }

  @override
  String get lowStockBadge => 'Аз калды';

  @override
  String get snoozeAction => 'Жылдыруу (30м)';

  @override
  String get undoAction => 'Артка кайтаруу';

  @override
  String get sosPanelTitle => 'Зарылчылыкка жараша (SOS)';

  @override
  String get takeNowAction => 'Азыр ичүү';

  @override
  String get limitReachedAlert => 'Күнүмдүк лимит жетти!';

  @override
  String get addSosMedicine => 'SOS кошуу';

  @override
  String get outOfStockBadge => 'Түгөндү';

  @override
  String get recentHistory => 'Акыркы тарых';

  @override
  String get noHistoryYet => 'Тарых жок';

  @override
  String get lifetimeCourse => 'Туруктуу (Өмүр бою)';

  @override
  String get doneAction => 'Даяр';

  @override
  String get addMeasurement => 'Маалымат кошуу';

  @override
  String get bloodPressure => 'Кан басымы';

  @override
  String get heartRate => 'Пульс';

  @override
  String get weight => 'Салмак';

  @override
  String get bloodSugar => 'Кандагы кант';

  @override
  String get systolic => 'Сис';

  @override
  String get diastolic => 'Диа';

  @override
  String get taperingDosing => 'Динамикалык доза';

  @override
  String stepNumber(int number) {
    return 'Кадам $number';
  }

  @override
  String get addStep => 'Кадам кошуу';

  @override
  String get doseForStep => 'Бул кадам үчүн доза';

  @override
  String get whatWouldYouLikeToDo => 'Эмне кылгыңыз келет?';

  @override
  String get scheduleNewTreatmentCourse => 'Жаңы курс кошуу';

  @override
  String get logHealthMetricsSubtitle => 'Кан басымы, пульс, салмак';

  @override
  String get priorityAction => 'Негизги аракет';

  @override
  String get skipDoseAction => 'Өткөрүп жиберүү';

  @override
  String errorPrefix(String error) {
    return 'Ката: $error';
  }

  @override
  String get goodMorning => 'Кутман таң';

  @override
  String get goodAfternoon => 'Кутман күн';

  @override
  String get goodEvening => 'Кутман кеч';

  @override
  String get dailyProgress => 'Күнүмдүк прогресс';

  @override
  String get sosEmergency => 'SOS';

  @override
  String get adherenceSubtitle => 'Сиздин туруктуулугуңуз';

  @override
  String get healthCorrelationTitle => 'Ден соолук байланышы';

  @override
  String get healthCorrelationSubtitle =>
      'Дары ичүү жана ден соолукту салыштырыңыз';

  @override
  String get last7Days => 'Акыркы 7 күн';

  @override
  String get pillsTaken => 'Дары ичилди';

  @override
  String get overallAdherence => 'Жалпы туруктуулук';

  @override
  String get statusGood => 'Жакшы';

  @override
  String get statusNeedsAttention => 'Көңүл буруңуз';

  @override
  String get statTaken => 'Ичилди';

  @override
  String get statSkipped => 'Өткөрүлдү';

  @override
  String get statTotal => 'Бардыгы';

  @override
  String get completedDosesSubtitle => 'Бүткөн дозалар';

  @override
  String get missedDosesSubtitle => 'Өткөрүп жиберилгендер';

  @override
  String get noDataYet => 'Маалымат жок';

  @override
  String get noDataDescription => 'Бул жерде статистика пайда болот.';

  @override
  String get failedToLoadAdherence => 'Ката';

  @override
  String get failedToLoadChart => 'Ката';

  @override
  String avgAdherence(String value) {
    return 'Орт. $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Орт. $metricName $value';
  }

  @override
  String get addAction => 'Кошуу';

  @override
  String get frequency => 'Жыштыгы';

  @override
  String get form => 'Формасы';

  @override
  String get inventory => 'Калдыгы';

  @override
  String get lowStockAlert => 'АЗ КАЛДЫ';

  @override
  String get asNeededFrequency => 'ЗАРЫЛЧЫЛЫККА ЖАРАША';

  @override
  String get taperingFrequency => 'ДИНАМИКАЛЫК';

  @override
  String get customizePill => 'Өзгөртүү';

  @override
  String get customizePillTitle => 'Таблетканы өзгөртүү';

  @override
  String get shape => 'Формасы';

  @override
  String get color => 'Түсү';

  @override
  String get overview => 'Жалпы маалымат';

  @override
  String get scheduleAndRules => 'График жана эрежелер';

  @override
  String get duration => 'Узактыгы';

  @override
  String get reminders => 'Билдирмелер';

  @override
  String get daysSuffix => 'күн';

  @override
  String get pcsSuffix => 'даана';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Жөндөөлөр';

  @override
  String get personalInfo => 'Жеке маалымат';

  @override
  String get appPreferences => 'Тиркеме жөндөөлөрү';

  @override
  String get darkMode => 'Караңгы режим';

  @override
  String get language => 'Тил';

  @override
  String get notifications => 'Билдирмелер';

  @override
  String get advancedFeatures => 'Кеңейтилген жөндөөлөр';

  @override
  String get caregivers => 'Жардамчылар';

  @override
  String get drugInteractions => 'Өз ара аракеттенүүлөр';

  @override
  String get comingSoon => 'ЖАКЫНДА';

  @override
  String get supportAndAbout => 'Колдоо жана маалымат';

  @override
  String get contactSupport => 'Колдоо кызматы';

  @override
  String get privacyPolicy => 'Купуялык саясаты';

  @override
  String get logout => 'Чыгуу';

  @override
  String get tabSettings => 'Профиль';

  @override
  String get defaultUserName => 'Дос';

  @override
  String get courseKindMedication => 'Дары';

  @override
  String get courseKindSupplement => 'Кошумча';

  @override
  String get courseFilterAll => 'Бардыгы';

  @override
  String get courseFilterMedications => 'Дарылар';

  @override
  String get courseFilterSupplements => 'Кошумчалар';

  @override
  String get homeTakeMedicationNow => 'Бул дарыны азыр ичүү';

  @override
  String get homeTakeSupplementNow => 'Бул кошумчаны азыр ичүү';

  @override
  String get homeEmptyAllTitle => 'Азырынча дарылар жок';

  @override
  String get homeEmptyMedicationsTitle => 'Дарылар жок';

  @override
  String get homeEmptySupplementsTitle => 'Кошумчалар жок';

  @override
  String get homeEmptyAllSubtitle => 'Азыр эч нерсе кылуунун кереги жок.';

  @override
  String get homeEmptyMedicationsSubtitle => 'Бул күнгө пландалган дары жок.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'Бул күнгө пландалган кошумча жок.';

  @override
  String get homeAddSupplementTitle => 'Кошумча кошуу';

  @override
  String get homeAddSupplementSubtitle => 'Витаминдерди пландаштыруу';

  @override
  String get homeForThisDay => 'Бул күн үчүн';

  @override
  String get homeMorningRoutine => 'Эртең менен';

  @override
  String get homeAfternoonRoutine => 'Күндүз';

  @override
  String get homeEveningRoutine => 'Кечинде';

  @override
  String get homeNightRoutine => 'Түнкүсүн';

  @override
  String get homeRoutineSupplementsOnly => 'кошумчалар гана';

  @override
  String get homeRoutineMedicationsOnly => 'дарылар гана';

  @override
  String get homeRoutineMixed => 'аралаш';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нерсе',
      one: '1 нерсе',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Көңүл буруңуз';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    return 'Пландалган $count нерсе.';
  }

  @override
  String get homeNextUpTitle => 'Кийинки';

  @override
  String get homeRefillReminderTitle => 'Калдыкты текшерүү';

  @override
  String homeRefillReminderSubtitle(int count) {
    return '$count курс толуктоону талап кылат.';
  }

  @override
  String get homeEverythingCalmTitle => 'Баары тынч';

  @override
  String get homeEverythingCalmSubtitle => 'Азыр шашылыш эч нерсе жок.';

  @override
  String get homeNoUpcomingItem => 'Жакынкы убакытта план жок.';

  @override
  String homeScheduledFor(String time) {
    return '$time убактысына пландалган';
  }

  @override
  String get calendarToday => 'Бүгүн';

  @override
  String get calendarSelectedDay => 'Тандалган күн';

  @override
  String get calendarShowingToday => 'Бүгүнкү графикти көрсөтүүдө';

  @override
  String get calendarBrowseNearbyDays =>
      'Башка күндү көрүү үчүн дөңгөлөктү айлантыңыз';

  @override
  String get calendarPreviewAnotherDay => 'Алдын ала көрүү.';

  @override
  String get calendarDayWheelSemantics => 'Күн дөңгөлөгү';

  @override
  String get analyticsCourseMix => 'Курстар';

  @override
  String get analyticsCourseMixSubtitle => 'Дарылар жана кошумчалар';

  @override
  String get analyticsCurrentRoutine => 'Учурдагы серия';

  @override
  String get analyticsCurrentRoutineSubtitle => 'Катасыз күндөр';

  @override
  String get analyticsTimingAccuracy => 'Тактык';

  @override
  String get analyticsTimingAccuracySubtitle => '30 мүнөт ичинде ичилген';

  @override
  String get analyticsBestRoutine => 'Мыкты натыйжа';

  @override
  String get analyticsBestRoutineSubtitle => 'Акыркы 90 күндө';

  @override
  String get analyticsRefillRisk => 'Түгөнүү коркунучу';

  @override
  String get analyticsRefillRiskSubtitle => 'Запасы аз калган';

  @override
  String get analyticsAverageDelay => 'Орточо кечигүү';

  @override
  String get analyticsMinutesShort => 'мүн';

  @override
  String get analyticsCoachNote => 'Кеңеш';

  @override
  String get analyticsMissedDoses => 'Өткөрүлгөн дозалар';

  @override
  String analyticsActiveShort(int count) {
    return '$count активдүү';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Ичилди: $taken  Өткөрүлдү: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Колдоо кызматы';

  @override
  String get settingsContactSupportBody => 'Эгер көйгөй болсо бизге жазыңыз.';

  @override
  String get settingsSupportEmailCopied => 'Почта көчүрүлдү';

  @override
  String get settingsCopySupportEmail => 'Почтаны көчүрүү';

  @override
  String get settingsPrivacyTitle => 'Купуялык саясаты';

  @override
  String get settingsPrivacyBodyPrimary => 'Маалыматтарыңыз түзмөктө сакталат.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Сүрөттөр жана отчеттор сиз каалаганда гана түзүлөт.';

  @override
  String get settingsPrivacyLaunchNote => 'Саясатты жарыялаңыз.';

  @override
  String get settingsLanguageEnglish => 'Англис тили';

  @override
  String get settingsLanguageRussian => 'Орус тили';

  @override
  String get settingsYourProfilePreferences => 'Сиздин профиль жана жөндөөлөр';

  @override
  String get settingsComfortModeTitle => 'Комфорт режими';

  @override
  String get settingsComfortModeSubtitle => 'Чоңураак текст';

  @override
  String get settingsNotificationsEnabled => 'Билдирмелер күйгүзүлгөн';

  @override
  String get settingsOn => 'Күйүк';

  @override
  String get settingsSupportAndSafety => 'Колдоо жана коопсуздук';

  @override
  String get settingsShowOnboardingAgain => 'Башкы нускаманы кайра ачуу';

  @override
  String get settingsShowOnboardingAgainSubtitle => 'Нускаманы ачуу';

  @override
  String get settingsFeaturePolishing => 'Бул функция иштелип жатат';

  @override
  String get settingsCaregiverTitle => 'Жардамчылар';

  @override
  String get settingsCaregiverDescription => 'Ишенимдүү адамды кошуңуз.';

  @override
  String get settingsCaregiverName => 'Жардамчынын аты';

  @override
  String get settingsCaregiverRelation => 'Байланыш';

  @override
  String get settingsCaregiverPhone => 'Телефон номери';

  @override
  String get settingsCaregiverShareReports => 'Отчетко кошуу';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Алардын байланышы отчетто болот.';

  @override
  String get settingsCaregiverSaved => 'Сакталды';

  @override
  String get settingsCaregiverRemoved => 'Өчүрүлдү';

  @override
  String get settingsCaregiverRemove => 'Өчүрүү';

  @override
  String get settingsCaregiverEmpty => 'Жардамчы кошуңуз';

  @override
  String get settingsCaregiverAlertsTitle => 'Жардамчыга билдирүү';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Кечигүү болсо билдирүү даярдайт.';

  @override
  String get settingsCaregiverAlertsEmpty => 'Алгач жардамчыны кошуңуз';

  @override
  String get settingsCaregiverAlertsDisabled => 'Билдирүүлөр өчүрүлгөн';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return '$minutes мүнөттөн кийин даяр болот';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Билдирүү даярдоо';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Жөнөтүүгө даяр билдирүү.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Күтүү убактысы';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return '$minutes мүнөт күтүү.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes мүн';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Кечиккен дозалар';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle => 'Кечигүүдө билдирүү.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Өткөрүлгөн дозалар';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle => 'Калтырганда билдирүү.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Кошумчаларды кошуу';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Витаминдер үчүн дагы колдонуу.';

  @override
  String get settingsCaregiverAlertsSaved => 'Эрежелер сакталды';

  @override
  String get settingsCaregiverConnectedTitle => 'Тармактык байланыш';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Билдирмелер үчүн туруктуу байланыш.';

  @override
  String get settingsCaregiverConnectedReady => 'Код даяр.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count билдирүү күтүлүүдө.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Байланыш коду';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Бул кодду жардамчыга бериңиз.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Чыгуучу';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Акыркы: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Кодду көчүрүү';

  @override
  String get settingsCaregiverConnectedCodeCopied => 'Көчүрүлдү';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Тазалоо';

  @override
  String get settingsCaregiverConnectedOutboxCleared => 'Тазаланды';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Тармактык режим';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Бул түзмөк бейтап катары иштейт.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return '$patientName үчүн жардамчы.';
  }

  @override
  String get settingsCaregiverConnectedModeNone => 'Тармакка туташкан эмес.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Байланган код: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle => 'Кирүүчү куту';

  @override
  String get settingsCaregiverConnectedInboxEmpty => 'Жаңы билдирүү жок.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Бейтап катары колдонуу';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Бейтап катары туташты';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Жардамчы катары туташуу';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Кошулуу';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Бейтаптын кодун киргизиңиз.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Туташуу';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Жардамчы катары туташты';

  @override
  String get settingsCaregiverConnectedJoinFailed => 'Код табылган жок';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Ажыратуу';

  @override
  String get settingsCaregiverConnectedDisconnected => 'Тармактан ажыратылды.';

  @override
  String get caregiverCloudNotificationTitle => 'Жардамчыга билдирүү';

  @override
  String get caregiverAlertCardTitle => 'Билдирүү даяр';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName $count нерсе жөнүндө кабардар боло алат.';
  }

  @override
  String get caregiverAlertReviewAction => 'Көрүү жана көчүрүү';

  @override
  String get caregiverAlertSheetTitle => 'Жардамчыга билдирүү';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return '$caregiverName үчүн даярдалган билдирүү.';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return '$minutes мүнөт кечикти';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Өткөрүп жиберилген';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Пландалган $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote => 'Көчүрүп жөнөтүңүз.';

  @override
  String get caregiverAlertCopyMessage => 'Текстти көчүрүү';

  @override
  String get caregiverAlertCopyPhone => 'Номерди көчүрүү';

  @override
  String get caregiverAlertNoPhone => 'Номер жок';

  @override
  String get caregiverAlertMessageCopied => 'Көчүрүлдү';

  @override
  String get caregiverAlertPhoneCopied => 'Номер көчүрүлдү';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Салам, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Бул $patientName үчүн жаңыртуу:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — $time, кечигүү $minutes мүн';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — $time, өткөрүлдү';
  }

  @override
  String get caregiverAlertMessageFooter => 'Көңүл буруп коюңуз.';

  @override
  String get settingsSupportEmailSubtitle => 'Колдоо кызматынын почтасы';

  @override
  String get settingsPrivacySubtitle => 'Маалыматтар кантип сакталат';

  @override
  String get settingsExampleName => 'Мисалы, Алекс';

  @override
  String get settingsSave => 'Сактоо';

  @override
  String get onboardingStartUsing => 'Pillora\'ны баштоо';

  @override
  String get onboardingContinue => 'Улантуу';

  @override
  String get onboardingBack => 'Артка';

  @override
  String get onboardingWelcomeTitle => 'Сиздин ден соолук жардамчыңыз';

  @override
  String get onboardingWelcomeTagline => 'Жөнөкөй жана түшүнүктүү.';

  @override
  String get onboardingWelcomeBody =>
      'Эмнени жана качан ичүү керек экенин көрөсүз.';

  @override
  String get onboardingFeatureEasyInterface => 'Түшүнүктүү интерфейс';

  @override
  String get onboardingFeatureNextDose => 'Кийинки дозага көңүл буруу';

  @override
  String get onboardingFeatureReminders => 'Билдирмелер жана запастар';

  @override
  String get onboardingTailorTitle => 'Тиркемени сизге ыңгайлаштырабыз';

  @override
  String get onboardingTailorSubtitle => 'Профильден өзгөртсө болот.';

  @override
  String get onboardingNamePrompt => 'Атыңыз ким?';

  @override
  String get onboardingLanguageTitle => 'Тил';

  @override
  String get onboardingReadingComfort => 'Окууга ыңгайлуулук';

  @override
  String get onboardingComfortModeTitle => 'Комфорт режими';

  @override
  String get onboardingComfortModeSubtitle => 'Чоң текст.';

  @override
  String get onboardingReadyTitle => 'Баары даяр';

  @override
  String get onboardingReadyBanner => 'Башкы экранда маанилүү нерселер гана.';

  @override
  String get onboardingReadyBody => 'Статистика өзүнчө болот.';

  @override
  String get onboardingReadySummaryHome => 'Жөнөкөй башкы экран';

  @override
  String get onboardingReadySummaryActions => 'Так аракеттер';

  @override
  String get onboardingReadySummaryComfortOn => 'Комфорт режими күйүк';

  @override
  String get onboardingReadySummaryComfortLater => 'Профильден өзгөртсө болот';

  @override
  String get medicineStandardCourse => 'Стандарттуу курс';

  @override
  String get medicineComplexCourse => 'Татаал курс';

  @override
  String get schedulePreviewTitle => 'Алдын ала көрүү';

  @override
  String get scheduleDoseAtTime => 'Дозасы';

  @override
  String get courseTypeLabel => 'Курстун түрү';

  @override
  String get addSupplementScreenTitle => 'Кошумча кошуу';

  @override
  String get editSupplementTitle => 'Өзгөртүү';

  @override
  String get settingsLanguageChangeLater => 'Кийин өзгөртө аласыз';

  @override
  String get homeNothingDueTitle => 'Азырынча эч нерсе жок';

  @override
  String get homeUseDayWheelSubtitle => 'Дөңгөлөктү колдонуңуз.';

  @override
  String get homeNoAttentionRightNow => 'Азыр эч нерсе керек эмес.';

  @override
  String get homeAddItemFab => 'Кошуу';

  @override
  String get homeTimelineSubtitle => 'Убакыт боюнча.';

  @override
  String get analyticsCoachGreat => 'Эң сонун, ушундай улантыңыз!';

  @override
  String get analyticsCoachMissed =>
      'Дайыма бир убакытта ичүүгө аракет кылыңыз.';

  @override
  String get analyticsCoachTiming => 'Тактыкты жакшыртыңыз.';

  @override
  String get medicineFrequencyDaily => 'Күн сайын';

  @override
  String get medicineFrequencySpecificDays => 'Тандалган күндөр';

  @override
  String get medicineFrequencyInterval => 'Интервал менен';

  @override
  String get medicineFrequencyCycle => 'Цикл';

  @override
  String get medicineFormTablet => 'Таблетка';

  @override
  String get medicineFormCapsule => 'Капсула';

  @override
  String get medicineFormLiquid => 'Суюктук';

  @override
  String get medicineFormInjection => 'Инъекция';

  @override
  String get medicineFormDrops => 'Тамчы';

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
  String get medicineTimelineSupplementInfo => 'Графикте көрүнөт.';

  @override
  String get medicineTimelineMedicationInfo => 'Курстун бир бөлүгү.';

  @override
  String get medicineDoseScheduleTitle => 'График';

  @override
  String get medicineDoseScheduleSubtitle => 'Ар бир күнгө.';

  @override
  String get medicineHistoryLoadError => 'Ката';

  @override
  String get scheduleDoseTabletsAtTime => 'Таблеткалар';

  @override
  String get scheduleDoseAmountAtTime => 'Дозасы';

  @override
  String get schedulePreviewFutureRebuilt => 'Келечектеги график.';

  @override
  String get scheduleComplexTitle => 'Татаал график';

  @override
  String get scheduleComplexEditSubtitle => 'Ар бир дозаны өзгөртө аласыз.';

  @override
  String get courseTimelineSupplementInfo => 'Витаминдер бөлүмүндө.';

  @override
  String get courseTimelineMedicationInfo => 'Дарылар бөлүмүндө.';

  @override
  String get supplementNameHint => 'Аты (мис. Магний)';

  @override
  String get addDoseAction => 'Доза кошуу';

  @override
  String get addConditionSuggestionsTitle => 'Сунуштар';

  @override
  String get addConditionSuggestionsSubtitle => 'Үлгүлөр.';

  @override
  String get addConditionSuggestionsEmpty => 'Башка сунуш жок.';

  @override
  String get addFlowSupplementTitle => 'Кантип кошобуз?';

  @override
  String get addFlowMedicationTitle => 'Кантип баштайбыз?';

  @override
  String get addFlowSupplementSubtitle => 'Үлгүлөр бар.';

  @override
  String get addFlowMedicationSubtitle => 'Жөнөкөйүн тандаңыз.';

  @override
  String get addFlowByConditionTitle => 'Оору боюнча';

  @override
  String get addFlowByConditionSubtitle => 'Оорулар үчүн үлгүлөр';

  @override
  String get addFlowQuickTemplateTitle => 'Ыкчам үлгү';

  @override
  String get addFlowQuickTemplateSubtitle => 'Даяр үлгү колдонуу';

  @override
  String get addFlowManualTitle => 'Өз алдынча';

  @override
  String get addFlowManualSubtitle => 'Кол менен толтуруу';

  @override
  String get addAppearanceTitle => 'Көрүнүшү';

  @override
  String get addAppearanceSubtitle => 'Сүрөт кошуңуз.';

  @override
  String get addPhotoLabel => 'Сүрөт';

  @override
  String get addQuickStartTitle => 'Ыкчам баштоо';

  @override
  String get addQuickStartSubtitle => 'Үлгүнү колдонуу.';

  @override
  String get addSkipTemplate => 'Өткөрүү';

  @override
  String get addUseTemplate => 'Колдонуу';

  @override
  String get addRecommendedMetricsTitle => 'Сунушталган көрсөткүчтөр';

  @override
  String get addRecommendedMetricsSubtitle => 'Көп катталат.';

  @override
  String get addSupplementTimelineInfo => 'Графикте чыгат.';

  @override
  String get addMedicationTimelineInfo => 'Графикте чыгат.';

  @override
  String get conditionDiabetesTitle => 'Кант диабети';

  @override
  String get conditionDiabetesSubtitle => 'Узак мөөнөттүү терапия';

  @override
  String get conditionHypertensionTitle => 'Гипертония';

  @override
  String get conditionHypertensionSubtitle => 'Кан басымын көзөмөлдөө';

  @override
  String get conditionCholesterolTitle => 'Жогорку холестерин';

  @override
  String get conditionCholesterolSubtitle => 'Кечки терапия';

  @override
  String get conditionThyroidTitle => 'Калкан бези';

  @override
  String get conditionThyroidSubtitle => 'Эртең менен';

  @override
  String get conditionGerdTitle => 'Ашказан кычкылы';

  @override
  String get conditionGerdSubtitle => 'Көзөмөлдөө';

  @override
  String get conditionAsthmaTitle => 'Астма';

  @override
  String get conditionAsthmaSubtitle => 'Ингаляторлор';

  @override
  String get conditionAllergyTitle => 'Аллергия';

  @override
  String get conditionAllergySubtitle => 'Антигистаминдер';

  @override
  String get conditionHeartPreventionTitle => 'Жүрөк ооруларынын алдын алуу';

  @override
  String get conditionHeartPreventionSubtitle => 'Кардиология';

  @override
  String get conditionHeartFailureTitle => 'Жүрөк жетишсиздиги';

  @override
  String get conditionHeartFailureSubtitle => 'Басымды колдоо';

  @override
  String get conditionAtrialFibrillationTitle => 'Жүрөк ритми';

  @override
  String get conditionAtrialFibrillationSubtitle => 'Инсультту алдын алуу';

  @override
  String get conditionJointPainTitle => 'Муундардын оорусу';

  @override
  String get conditionJointPainSubtitle => 'Ооруну басаңдатуу';

  @override
  String get conditionBphTitle => 'Простата / БПГ';

  @override
  String get conditionBphSubtitle => 'Заара чыгарууну көзөмөлдөө';

  @override
  String get conditionOsteoporosisTitle => 'Остеопороз';

  @override
  String get conditionOsteoporosisSubtitle => 'Сөөктөрдү колдоо';

  @override
  String get conditionAnemiaTitle => 'Анемия';

  @override
  String get conditionAnemiaSubtitle => 'Темир толуктоо';

  @override
  String get suggestionMetforminName => 'Метформин';

  @override
  String get suggestionMetforminNote => 'Оралдык терапия.';

  @override
  String get suggestionInsulinName => 'Инсулин';

  @override
  String get suggestionInsulinNote => 'Инъекция.';

  @override
  String get suggestionAmlodipineName => 'Амлодипин';

  @override
  String get suggestionAmlodipineNote => 'Кан басым.';

  @override
  String get suggestionLosartanName => 'Лозартан';

  @override
  String get suggestionLosartanNote => 'Узак мөөнөттүү.';

  @override
  String get suggestionAtorvastatinName => 'Аторвастатин';

  @override
  String get suggestionAtorvastatinNote => 'Күнүмдүк статин.';

  @override
  String get suggestionLevothyroxineName => 'Левотироксин';

  @override
  String get suggestionLevothyroxineNote => 'Эртең менен тамакка чейин.';

  @override
  String get suggestionOmeprazoleName => 'Омепразол';

  @override
  String get suggestionOmeprazoleNote => 'Эртең менен тамакка чейин.';

  @override
  String get suggestionFamotidineName => 'Фамотидин';

  @override
  String get suggestionFamotidineNote => 'Кечинде.';

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
  String get suggestionAspirinNote => 'Жүрөк.';

  @override
  String get suggestionClopidogrelName => 'Клопидогрел';

  @override
  String get suggestionClopidogrelNote => 'Күнүмдүк.';

  @override
  String get suggestionFurosemideName => 'Фуросемид';

  @override
  String get suggestionFurosemideNote => 'Диуретик.';

  @override
  String get suggestionSpironolactoneName => 'Спиронолактон';

  @override
  String get suggestionSpironolactoneNote => 'Колдоо.';

  @override
  String get suggestionApixabanName => 'Апиксабан';

  @override
  String get suggestionApixabanNote => 'Антикоагулянт.';

  @override
  String get suggestionMetoprololName => 'Метопролол';

  @override
  String get suggestionMetoprololNote => 'Жүрөк ритми.';

  @override
  String get suggestionIbuprofenName => 'Ибупрофен';

  @override
  String get suggestionIbuprofenNote => 'Ооруга каршы.';

  @override
  String get suggestionDiclofenacGelName => 'Диклофенак';

  @override
  String get suggestionDiclofenacGelNote => 'Май.';

  @override
  String get suggestionTamsulosinName => 'Тамсулозин';

  @override
  String get suggestionTamsulosinNote => 'Кечинде.';

  @override
  String get suggestionFinasterideName => 'Финастерид';

  @override
  String get suggestionFinasterideNote => 'Күнүмдүк.';

  @override
  String get suggestionAlendronateName => 'Алендронат';

  @override
  String get suggestionAlendronateNote => 'Жумасына бир жолу.';

  @override
  String get suggestionCalciumVitaminDName => 'Кальций + Витамин D';

  @override
  String get suggestionCalciumVitaminDNote => 'Сөөктөр.';

  @override
  String get suggestionFerrousSulfateName => 'Темир сульфаты';

  @override
  String get suggestionFerrousSulfateNote => 'Темир.';

  @override
  String get suggestionFolicAcidName => 'Фолий кислотасы';

  @override
  String get suggestionFolicAcidNote => 'Витамин.';

  @override
  String get pdfDoctorReportTitle => 'Дарыгер үчүн отчет';

  @override
  String get pdfSupplementCourseSummary => 'Кошумчалар';

  @override
  String get pdfMedicationCourseSummary => 'Дарылар';

  @override
  String get pdfCourseProfileTitle => 'Курс профили';

  @override
  String get pdfScheduleSnapshotTitle => 'График';

  @override
  String get pdfScheduleSnapshotSubtitle => 'Убакыт жана доза.';

  @override
  String get pdfAdministrationHistoryTitle => 'Ичүү тарыхы';

  @override
  String get pdfAdministrationHistorySubtitle => 'Канчалык так ичилгени.';

  @override
  String get pdfAdherenceLabel => 'Туруктуулук';

  @override
  String get pdfSnoozedLabel => 'Жылдырылды';

  @override
  String get pdfClinicalSummaryTitle => 'Клиникалык маалымат';

  @override
  String get pdfPatientLabel => 'Бейтап';

  @override
  String get pdfCaregiverLabel => 'Жардамчы';

  @override
  String get pdfReportPeriodLabel => 'Мезгил';

  @override
  String get pdfOnTimeRateLabel => 'Өз убагында';

  @override
  String get pdfAverageDelayLabel => 'Орточо кечигүү';

  @override
  String get pdfUpcomingDosesLabel => 'Кийинкилер';

  @override
  String get pdfStockLeftLabel => 'Калдык';

  @override
  String get pdfNameLabel => 'Аты';

  @override
  String get pdfCourseTypeLabel => 'Түрү';

  @override
  String get pdfDosageLabel => 'Дозасы';

  @override
  String get pdfFrequencyLabel => 'Жыштыгы';

  @override
  String get pdfStartedLabel => 'Башталды';

  @override
  String get pdfInstructionLabel => 'Эрежеси';

  @override
  String get pdfNotesLabel => 'Эскертүү';

  @override
  String get pdfTimelineEmpty => 'Тарых жок.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return '$total жазуунун $visible көрсөтүлүүдө.';
  }

  @override
  String get pdfTableScheduled => 'План';

  @override
  String get pdfTableActual => 'Чындыгында';

  @override
  String get pdfTableDose => 'Доза';

  @override
  String get pdfTableStatus => 'Статус';

  @override
  String get pdfTableDelay => 'Кечигүү';

  @override
  String get pdfOnTime => 'Өз убагында';

  @override
  String get pdfMinuteShort => 'мүн';

  @override
  String get pdfNoFoodRestriction => 'Айырмасы жок';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Бул жерде көрүү үчүн дары же кошумча кошуңуз.';

  @override
  String get tabScanner => 'Сканнер';

  @override
  String get scannerComingSoonTitle => 'Акылдуу Сканнер';

  @override
  String get scannerComingSoonText =>
      'Маалыматтарды автотолтуруу үчүн камераңызды багыттаңыз. Жакында болот!';

  @override
  String get premiumTitle => 'Pillora Pro';

  @override
  String get premiumSubtitle =>
      'Ден соолук графигиңиздин толук мүмкүнчүлүктөрүн ачыңыз';

  @override
  String get premiumFeatureCaregiver =>
      'Чексиз жардамчылар жана реалдуу убакыт билдирүүлөрү';

  @override
  String get premiumFeatureScanner => 'Ыкчам кошуу үчүн акылдуу сканнер';

  @override
  String get premiumFeatureSchedules =>
      'Татаал графиктер (Циклдер, Динамикалык доза)';

  @override
  String get premiumFeatureReports => 'Дарыгер үчүн PDF отчеттор';

  @override
  String get premiumSubscribeYearly => 'Жылына \$29.99 үчүн Pro\'ну ачуу';

  @override
  String get premiumSubscribeMonthly => 'же айына \$4.99';

  @override
  String get premiumRestorePurchases => 'Сатып алууларды калыбына келтирүү';
}
