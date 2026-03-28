// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Today Schedule';

  @override
  String get architectureReady => 'Architecture is set. All systems normal.';

  @override
  String get nextCreateHome => 'Next: Create Home Screen';

  @override
  String get statusTaken => 'Taken';

  @override
  String get statusSkipped => 'Skipped';

  @override
  String get statusSnoozed => 'Snoozed 10 min';

  @override
  String get statusPending => 'Pending';

  @override
  String get emptySchedule => 'No medications scheduled for this day';

  @override
  String get takeAction => 'Take';

  @override
  String get skipAction => 'Skip';

  @override
  String get dosageUnitMg => 'mg';

  @override
  String get dosageUnitMl => 'ml';

  @override
  String get dosageUnitDrops => 'drops';

  @override
  String get dosageUnitPcs => 'pcs';

  @override
  String get dosageUnitG => 'g';

  @override
  String get dosageUnitMcg => 'mcg';

  @override
  String get dosageUnitIu => 'IU';

  @override
  String get addMedicationTitle => 'Add Medication';

  @override
  String get medicineNameHint => 'Medicine Name (e.g. Vitamin D)';

  @override
  String get dosageHint => 'Dosage (e.g. 500)';

  @override
  String get saveAction => 'Save & Create Schedule';

  @override
  String get errorEmptyFields => 'Please fill in all fields';

  @override
  String get profileTitle => 'Profile';

  @override
  String notificationTitle(String name) {
    return 'Time to take $name!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Dosage: $dosage. Please don\'t miss it.';
  }

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get adherenceRate => 'Adherence Rate';

  @override
  String get dosesTaken => 'Doses Taken';

  @override
  String get dosesMissed => 'Doses Missed';

  @override
  String get activeCourses => 'Active Courses';

  @override
  String get tabHome => 'Schedule';

  @override
  String get tabAnalytics => 'Stats';

  @override
  String get keepItUp => 'Great job! Keep it up.';

  @override
  String get needsAttention => 'Needs attention. Try not to miss doses.';

  @override
  String get medicineDetails => 'Medicine Details';

  @override
  String get pillsRemaining => 'Remaining in stock';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get deleteConfirmation =>
      'Are you sure you want to delete this course and all its reminders?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" added.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" updated.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" deleted.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get timeOfDay => 'Time of Day';

  @override
  String get courseDuration => 'Course Duration (days)';

  @override
  String get pillsInPackage => 'Amount in package';

  @override
  String get addTime => 'Add Time';

  @override
  String timeLabel(int number) {
    return 'Time $number';
  }

  @override
  String get foodBefore => 'Before food';

  @override
  String get foodWith => 'With food';

  @override
  String get foodAfter => 'After food';

  @override
  String get foodNoMatter => 'Any time';

  @override
  String get unknownMedicine => 'Unknown medicine';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get medicineInfo => 'Medicine Info';

  @override
  String get formTitle => 'Form';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get everyXDays => 'Every X days';

  @override
  String get maxDosesPerDay => 'Max doses per day (Safety)';

  @override
  String get overdoseWarning => 'To prevent accidental overdose.';

  @override
  String get foodInstructionTitle => 'Food Instruction';

  @override
  String doseNumber(int number) {
    return 'Dose $number';
  }

  @override
  String get coursePaused => 'Course Paused';

  @override
  String get resumeCourse => 'Resume';

  @override
  String get pauseCourse => 'Pause';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" paused.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" resumed.';
  }

  @override
  String get doctorReport => 'Doctor Report';

  @override
  String get generatingReport => 'Generating Doctor Report...';

  @override
  String errorGeneratingReport(String error) {
    return 'Error generating PDF: $error';
  }

  @override
  String get editCourse => 'Edit Course';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get editMedicineInfo => 'Edit Medicine Info';

  @override
  String lowStockTitle(String name) {
    return 'Low Stock: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Only $count $unit left. Time to refill!';
  }

  @override
  String get lowStockBadge => 'Low Stock';

  @override
  String get snoozeAction => 'Snooze (30m)';

  @override
  String get undoAction => 'Undo';

  @override
  String get sosPanelTitle => 'As Needed (SOS)';

  @override
  String get takeNowAction => 'TAKE NOW';

  @override
  String get limitReachedAlert => 'Daily limit reached! Consult your doctor.';

  @override
  String get addSosMedicine => 'Add SOS';

  @override
  String get outOfStockBadge => 'Out of Stock';

  @override
  String get recentHistory => 'Recent History';

  @override
  String get noHistoryYet => 'No history yet';

  @override
  String get lifetimeCourse => 'Continuous (Lifetime)';

  @override
  String get doneAction => 'Done';

  @override
  String get addMeasurement => 'Log Health Data';

  @override
  String get bloodPressure => 'Blood Pressure';

  @override
  String get heartRate => 'Heart Rate';

  @override
  String get weight => 'Weight';

  @override
  String get bloodSugar => 'Blood Sugar';

  @override
  String get systolic => 'Sys';

  @override
  String get diastolic => 'Dia';

  @override
  String get taperingDosing => 'Dynamic Dosing (Tapering)';

  @override
  String stepNumber(int number) {
    return 'Step $number';
  }

  @override
  String get addStep => 'Add Step';

  @override
  String get doseForStep => 'Dose for this step';

  @override
  String get whatWouldYouLikeToDo => 'What would you like to do?';

  @override
  String get scheduleNewTreatmentCourse => 'Schedule a new treatment course';

  @override
  String get logHealthMetricsSubtitle =>
      'Log blood pressure, heart rate, weight';

  @override
  String get priorityAction => 'Priority Action';

  @override
  String get skipDoseAction => 'Skip Dose';

  @override
  String errorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get dailyProgress => 'Daily Progress';

  @override
  String get sosEmergency => 'SOS Emergency';

  @override
  String get adherenceSubtitle => 'Your medication consistency overview';

  @override
  String get healthCorrelationTitle => 'Health Correlation';

  @override
  String get healthCorrelationSubtitle =>
      'Compare medication adherence with your health metrics';

  @override
  String get last7Days => 'Last 7 days';

  @override
  String get pillsTaken => 'Pills taken';

  @override
  String get overallAdherence => 'Overall adherence';

  @override
  String get statusGood => 'Good';

  @override
  String get statusNeedsAttention => 'Needs attention';

  @override
  String get statTaken => 'Taken';

  @override
  String get statSkipped => 'Skipped';

  @override
  String get statTotal => 'Total';

  @override
  String get completedDosesSubtitle => 'Completed doses';

  @override
  String get missedDosesSubtitle => 'Missed doses';

  @override
  String get noDataYet => 'No data yet';

  @override
  String get noDataDescription =>
      'Start tracking measurements and taking medication regularly\nto see correlation insights here.';

  @override
  String get failedToLoadAdherence => 'Failed to load adherence';

  @override
  String get failedToLoadChart => 'Failed to load chart';

  @override
  String avgAdherence(String value) {
    return 'Avg adherence $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Avg $metricName $value';
  }

  @override
  String get addAction => 'Add Log';

  @override
  String get frequency => 'Frequency';

  @override
  String get form => 'Form';

  @override
  String get inventory => 'Inventory';

  @override
  String get lowStockAlert => 'LOW STOCK';

  @override
  String get asNeededFrequency => 'AS NEEDED';

  @override
  String get taperingFrequency => 'TAPERING';

  @override
  String get customizePill => 'Customize Appearance';

  @override
  String get customizePillTitle => 'Customize Pill';

  @override
  String get shape => 'Shape';

  @override
  String get color => 'Color';

  @override
  String get overview => 'Overview';

  @override
  String get scheduleAndRules => 'Schedule & Rules';

  @override
  String get duration => 'Duration';

  @override
  String get reminders => 'Reminders';

  @override
  String get daysSuffix => 'days';

  @override
  String get pcsSuffix => 'pcs';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Settings & Profile';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get advancedFeatures => 'Advanced Features';

  @override
  String get caregivers => 'Med-Friends & Caregivers';

  @override
  String get drugInteractions => 'Drug Interactions';

  @override
  String get comingSoon => 'SOON';

  @override
  String get supportAndAbout => 'Support & About';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get logout => 'Log Out';

  @override
  String get tabSettings => 'Profile';

  @override
  String get defaultUserName => 'Friend';

  @override
  String get courseKindMedication => 'Medication';

  @override
  String get courseKindSupplement => 'Supplement';

  @override
  String get courseFilterAll => 'All';

  @override
  String get courseFilterMedications => 'Medications';

  @override
  String get courseFilterSupplements => 'Supplements';

  @override
  String get homeTakeMedicationNow => 'Take this medication now';

  @override
  String get homeTakeSupplementNow => 'Take this supplement now';

  @override
  String get homeEmptyAllTitle => 'You have a quiet moment';

  @override
  String get homeEmptyMedicationsTitle => 'Medications are all set';

  @override
  String get homeEmptySupplementsTitle => 'Supplements are all set';

  @override
  String get homeEmptyAllSubtitle =>
      'Nothing needs attention right now. You can check another day or add a new course when you are ready.';

  @override
  String get homeEmptyMedicationsSubtitle =>
      'No medications need attention on this date. It is a good moment for a calm pause.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'No supplements need attention on this date. Your wellness routine is clear for now.';

  @override
  String get homeAddSupplementTitle => 'Add supplement';

  @override
  String get homeAddSupplementSubtitle =>
      'Schedule vitamins and wellness supplements';

  @override
  String get homeForThisDay => 'For this day';

  @override
  String get homeMorningRoutine => 'Morning routine';

  @override
  String get homeAfternoonRoutine => 'Afternoon routine';

  @override
  String get homeEveningRoutine => 'Evening routine';

  @override
  String get homeNightRoutine => 'Night routine';

  @override
  String get homeRoutineSupplementsOnly => 'supplements only';

  @override
  String get homeRoutineMedicationsOnly => 'medications only';

  @override
  String get homeRoutineMixed => 'mixed routine';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Needs attention';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scheduled items should be taken or reviewed now.',
      one: '1 scheduled item should be taken or reviewed now.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'Next up';

  @override
  String get homeRefillReminderTitle => 'Refill reminder';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count courses may need a refill soon.',
      one: '1 course may need a refill soon.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Everything is calm';

  @override
  String get homeEverythingCalmSubtitle =>
      'No urgent medication or supplement tasks right now.';

  @override
  String get homeNoUpcomingItem => 'No upcoming item scheduled.';

  @override
  String homeScheduledFor(String time) {
    return 'Scheduled for $time';
  }

  @override
  String get calendarToday => 'Today';

  @override
  String get calendarSelectedDay => 'Selected day';

  @override
  String get calendarShowingToday => 'Showing today\'s schedule';

  @override
  String get calendarBrowseNearbyDays =>
      'Scroll the wheel to browse nearby days';

  @override
  String get calendarPreviewAnotherDay =>
      'The wheel lets you preview another day before the screen updates.';

  @override
  String get calendarDayWheelSemantics => 'Day wheel';

  @override
  String get analyticsCourseMix => 'Course mix';

  @override
  String get analyticsCourseMixSubtitle =>
      'Treatment courses and supplements are tracked together, but measured separately here.';

  @override
  String get analyticsCurrentRoutine => 'Current routine';

  @override
  String get analyticsCurrentRoutineSubtitle =>
      'Days in a row without missed doses';

  @override
  String get analyticsTimingAccuracy => 'Timing accuracy';

  @override
  String get analyticsTimingAccuracySubtitle => 'Taken within 30 minutes';

  @override
  String get analyticsBestRoutine => 'Best routine';

  @override
  String get analyticsBestRoutineSubtitle => 'Best result in the last 90 days';

  @override
  String get analyticsRefillRisk => 'Refill risk';

  @override
  String get analyticsRefillRiskSubtitle => 'Courses close to refill threshold';

  @override
  String get analyticsAverageDelay => 'Average delay';

  @override
  String get analyticsMinutesShort => 'min';

  @override
  String get analyticsCoachNote => 'Coach note';

  @override
  String get analyticsMissedDoses => 'Missed doses';

  @override
  String analyticsActiveShort(int count) {
    return '$count active';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Taken: $taken  Missed: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Contact support';

  @override
  String get settingsContactSupportBody =>
      'If something feels confusing or isn\'t working as expected, we can help. Include your device model, app version, and a short description of the issue.';

  @override
  String get settingsSupportEmailCopied => 'Support email copied';

  @override
  String get settingsCopySupportEmail => 'Copy support email';

  @override
  String get settingsPrivacyTitle => 'Privacy policy';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Pillora stores your course details, reminder settings, and dose history on your device so the app can show your schedule and generate reports.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Medication photos and report exports are created only when you choose to use them. Before launch, replace this in-app summary with your final hosted privacy policy URL.';

  @override
  String get settingsPrivacyLaunchNote =>
      'Launch note: publish a full privacy policy on your website or store listing before release.';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageRussian => 'Russian';

  @override
  String get settingsYourProfilePreferences =>
      'Your profile and important preferences';

  @override
  String get settingsComfortModeTitle => 'Comfort mode';

  @override
  String get settingsComfortModeSubtitle => 'Larger text and calmer visuals';

  @override
  String get settingsNotificationsEnabled => 'Medication reminders are enabled';

  @override
  String get settingsOn => 'On';

  @override
  String get settingsSupportAndSafety => 'Support and safety';

  @override
  String get settingsShowOnboardingAgain => 'Show onboarding again';

  @override
  String get settingsShowOnboardingAgainSubtitle =>
      'Open the first-run guide again';

  @override
  String get settingsFeaturePolishing =>
      'This feature is being polished for a later release';

  @override
  String get settingsCaregiverTitle => 'Caregiver sharing';

  @override
  String get settingsCaregiverDescription =>
      'Add a trusted person so reports can include their contact details and shared care stays organized.';

  @override
  String get settingsCaregiverName => 'Caregiver name';

  @override
  String get settingsCaregiverRelation => 'Relation';

  @override
  String get settingsCaregiverPhone => 'Phone number';

  @override
  String get settingsCaregiverShareReports => 'Include caregiver in reports';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Doctor reports can include caregiver contact details when you share them.';

  @override
  String get settingsCaregiverSaved => 'Caregiver settings saved';

  @override
  String get settingsCaregiverRemoved => 'Caregiver removed';

  @override
  String get settingsCaregiverRemove => 'Remove caregiver';

  @override
  String get settingsCaregiverEmpty =>
      'Add a trusted person for shared care and reports';

  @override
  String get settingsCaregiverAlertsTitle => 'Caregiver alerts';

  @override
  String get settingsCaregiverAlertsDescription =>
      'If an important dose is late or marked as skipped, Pillora can prepare a ready alert for your caregiver on this device.';

  @override
  String get settingsCaregiverAlertsEmpty =>
      'Add a caregiver first to prepare missed-dose alerts';

  @override
  String get settingsCaregiverAlertsDisabled =>
      'Alerts for your caregiver are turned off';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'An alert is prepared after $minutes minutes if attention is needed';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Prepare caregiver alerts';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'When a dose needs attention, Pillora will prepare a message you can copy and send.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Grace period';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Wait $minutes minutes before preparing an alert for an overdue item.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes min';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Include overdue doses';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Prepare an alert when a planned dose is still pending after the grace period.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Include skipped doses';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Prepare an alert when a dose is explicitly marked as skipped.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Include supplements';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Use the same alert flow for supplements, not only medications.';

  @override
  String get settingsCaregiverAlertsSaved => 'Caregiver alert rules saved';

  @override
  String get settingsCaregiverConnectedTitle => 'Connected caregiver delivery';

  @override
  String get settingsCaregiverConnectedDescription =>
      'This app-side layer keeps a stable link code and a sync-ready outbox, so direct caregiver device alerts can be connected cleanly when cloud delivery is enabled.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Link-ready code is prepared. No alerts are waiting in the outbox.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count alert(s) are waiting in the connected-delivery outbox.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Caregiver link code';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Keep this code ready for linking the caregiver device when direct delivery is enabled.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Alert outbox';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Last queued: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Copy link code';

  @override
  String get settingsCaregiverConnectedCodeCopied =>
      'Caregiver link code copied';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Clear outbox';

  @override
  String get settingsCaregiverConnectedOutboxCleared =>
      'Caregiver outbox cleared';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Cloud link mode';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'This device is acting as the patient device and mirrors alerts to Firestore.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'This device is linked as the caregiver device for $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone =>
      'This device is not linked to the cloud caregiver flow yet.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Linked code: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle => 'Caregiver inbox preview';

  @override
  String get settingsCaregiverConnectedInboxEmpty =>
      'No cloud alerts are waiting right now.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Use this device as patient';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'This device is now linked as the patient device';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Connect this device as caregiver';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Join caregiver link';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Enter the caregiver link code from the patient device to receive alerts in this app while it is active.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Connect caregiver device';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'This device is now linked as the caregiver device';

  @override
  String get settingsCaregiverConnectedJoinFailed =>
      'The caregiver link code was not found';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Disconnect cloud link';

  @override
  String get settingsCaregiverConnectedDisconnected =>
      'This device has been disconnected from the cloud caregiver flow';

  @override
  String get caregiverCloudNotificationTitle => 'Caregiver alert';

  @override
  String get caregiverAlertCardTitle => 'Caregiver alert is ready';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName can be notified about $count item(s) that need attention today.';
  }

  @override
  String get caregiverAlertReviewAction => 'Review and copy';

  @override
  String get caregiverAlertSheetTitle => 'Caregiver alert';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Pillora prepared a ready message for $caregiverName about $count item(s) that need attention.';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'Late by $minutes min';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Marked as skipped';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Scheduled for $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote =>
      'This release prepares a ready alert on your device, so you can quickly copy it and send it to your caregiver.';

  @override
  String get caregiverAlertCopyMessage => 'Copy alert text';

  @override
  String get caregiverAlertCopyPhone => 'Copy caregiver phone';

  @override
  String get caregiverAlertNoPhone => 'Add caregiver phone in Settings';

  @override
  String get caregiverAlertMessageCopied => 'Caregiver alert copied';

  @override
  String get caregiverAlertPhoneCopied => 'Caregiver phone copied';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Hello, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Pillora prepared this update for $patientName. The following doses need attention today:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — scheduled for $time, now overdue by $minutes min';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — scheduled for $time, marked as skipped';
  }

  @override
  String get caregiverAlertMessageFooter =>
      'Please check in if support is needed.';

  @override
  String get settingsSupportEmailSubtitle =>
      'Support email and launch contact details';

  @override
  String get settingsPrivacySubtitle =>
      'How reminder data, photos, and reports are handled';

  @override
  String get settingsExampleName => 'For example, Alex';

  @override
  String get settingsSave => 'Save';

  @override
  String get onboardingStartUsing => 'Start using Pillora';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingWelcomeTitle => 'Pillora helps you stay on track';

  @override
  String get onboardingWelcomeTagline => 'Calm, clear, and focused.';

  @override
  String get onboardingWelcomeBody =>
      'Right after opening the app, you will see what medication needs to be taken now and what comes next.';

  @override
  String get onboardingFeatureEasyInterface => 'Large, easy-to-read interface';

  @override
  String get onboardingFeatureNextDose => 'Focus on the next dose';

  @override
  String get onboardingFeatureReminders => 'Reminders and refill awareness';

  @override
  String get onboardingTailorTitle => 'Let us tailor the app for you';

  @override
  String get onboardingTailorSubtitle =>
      'You can change these settings later in Profile.';

  @override
  String get onboardingNamePrompt => 'What should we call you?';

  @override
  String get onboardingLanguageTitle => 'Language';

  @override
  String get onboardingReadingComfort => 'Reading comfort';

  @override
  String get onboardingComfortModeTitle => 'Comfort mode';

  @override
  String get onboardingComfortModeSubtitle =>
      'Larger text, bigger buttons, and less visual clutter.';

  @override
  String get onboardingReadyTitle => 'You are all set';

  @override
  String get onboardingReadyBanner =>
      'The first screen focuses on what to take and when.';

  @override
  String get onboardingReadyBody =>
      'The home screen shows medications that need attention first, while statistics stay on a separate tab.';

  @override
  String get onboardingReadySummaryHome =>
      'A simpler home screen with less clutter';

  @override
  String get onboardingReadySummaryActions => 'Clear actions: take, skip, add';

  @override
  String get onboardingReadySummaryComfortOn => 'Comfort mode is already on';

  @override
  String get onboardingReadySummaryComfortLater =>
      'Comfort mode can be turned on later in Profile';

  @override
  String get medicineStandardCourse => 'Standard course';

  @override
  String get medicineComplexCourse => 'Complex course';

  @override
  String get schedulePreviewTitle => 'Schedule preview';

  @override
  String get scheduleDoseAtTime => 'Dose at this time';

  @override
  String get courseTypeLabel => 'Course type';

  @override
  String get addSupplementScreenTitle => 'Add Supplement';

  @override
  String get editSupplementTitle => 'Edit Supplement';

  @override
  String get settingsLanguageChangeLater =>
      'You can change this later in Profile';

  @override
  String get homeNothingDueTitle => 'Nothing is due right now';

  @override
  String get homeUseDayWheelSubtitle =>
      'Use the day wheel above if you want to check another day.';

  @override
  String get homeNoAttentionRightNow =>
      'No scheduled medications or supplements need attention right now.';

  @override
  String get homeAddItemFab => 'Add medication, supplement or measurement';

  @override
  String get homeTimelineSubtitle =>
      'Medications and supplements are shown in time order.';

  @override
  String get analyticsCoachGreat =>
      'You are building a dependable medication routine. Keep that consistency going.';

  @override
  String get analyticsCoachMissed =>
      'Most missed doses come from inconsistency, not volume. Make the first dose of the day your anchor.';

  @override
  String get analyticsCoachTiming =>
      'Your routine is moving in the right direction. The next win is better timing accuracy.';

  @override
  String get medicineFrequencyDaily => 'Daily';

  @override
  String get medicineFrequencySpecificDays => 'Specific days';

  @override
  String get medicineFrequencyInterval => 'Interval';

  @override
  String get medicineFrequencyCycle => 'Cycle';

  @override
  String get medicineFormTablet => 'Tablet';

  @override
  String get medicineFormCapsule => 'Capsule';

  @override
  String get medicineFormLiquid => 'Liquid';

  @override
  String get medicineFormInjection => 'Injection';

  @override
  String get medicineFormDrops => 'Drops';

  @override
  String get medicineFormOintment => 'Ointment';

  @override
  String get medicineFormSpray => 'Spray';

  @override
  String get medicineFormInhaler => 'Inhaler';

  @override
  String get medicineFormPatch => 'Patch';

  @override
  String get medicineFormSuppository => 'Suppository';

  @override
  String get medicineTimelineSupplementInfo =>
      'This supplement appears in the shared daily timeline, while staying separate as a wellness course.';

  @override
  String get medicineTimelineMedicationInfo =>
      'This medication appears in the shared daily timeline and stays part of your main treatment plan.';

  @override
  String get medicineDoseScheduleTitle => 'Dose schedule';

  @override
  String get medicineDoseScheduleSubtitle =>
      'The next day of treatment with time-by-time dosage.';

  @override
  String get medicineHistoryLoadError => 'Error';

  @override
  String get scheduleDoseTabletsAtTime => 'Tablets at this time';

  @override
  String get scheduleDoseAmountAtTime => 'Dose at this time';

  @override
  String get schedulePreviewFutureRebuilt =>
      'Future doses will be rebuilt using this schedule.';

  @override
  String get scheduleComplexTitle => 'Complex schedule';

  @override
  String get scheduleComplexEditSubtitle =>
      'You can edit both time and dosage for each dose.';

  @override
  String get courseTimelineSupplementInfo =>
      'This supplement stays in its own category, but appears in the shared time-based timeline.';

  @override
  String get courseTimelineMedicationInfo =>
      'This medication stays in the medical category and appears in the shared time-based timeline.';

  @override
  String get supplementNameHint => 'Supplement Name (e.g. Magnesium)';

  @override
  String get addDoseAction => 'Add dose';

  @override
  String get addConditionSuggestionsTitle => 'Condition-based suggestions';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Pick a condition to see common course templates. These are only starting points and should match the real prescription.';

  @override
  String get addConditionSuggestionsEmpty =>
      'There are no visible suggestions left for this condition. You can choose another condition or continue manually.';

  @override
  String get addFlowSupplementTitle =>
      'How would you like to add this supplement?';

  @override
  String get addFlowMedicationTitle => 'How would you like to start?';

  @override
  String get addFlowSupplementSubtitle =>
      'Most people add supplements manually, but you can still use quick templates when they fit.';

  @override
  String get addFlowMedicationSubtitle =>
      'Choose the easiest path first. You can still adjust every detail below.';

  @override
  String get addFlowByConditionTitle => 'By condition';

  @override
  String get addFlowByConditionSubtitle =>
      'See the most common templates for a condition';

  @override
  String get addFlowQuickTemplateTitle => 'Quick template';

  @override
  String get addFlowQuickTemplateSubtitle =>
      'Use one of the common ready-made courses';

  @override
  String get addFlowManualTitle => 'Manual';

  @override
  String get addFlowManualSubtitle => 'Fill the course yourself from the start';

  @override
  String get addAppearanceTitle => 'Appearance';

  @override
  String get addAppearanceSubtitle =>
      'Optional step. Add a photo or customize the pill so it is easier to recognize later.';

  @override
  String get addPhotoLabel => 'Photo';

  @override
  String get addQuickStartTitle => 'Quick start';

  @override
  String get addQuickStartSubtitle =>
      'Use one of the most common course templates in a single tap.';

  @override
  String get addSkipTemplate => 'Skip';

  @override
  String get addUseTemplate => 'Use template';

  @override
  String get addRecommendedMetricsTitle => 'Recommended health metrics';

  @override
  String get addRecommendedMetricsSubtitle =>
      'These measurements are often tracked together with this condition. You can log the first reading right now.';

  @override
  String get addSupplementTimelineInfo =>
      'This supplement will appear together with medications in the daily timeline.';

  @override
  String get addMedicationTimelineInfo =>
      'This medication will appear in the shared daily timeline with your other courses.';

  @override
  String get conditionDiabetesTitle => 'Diabetes';

  @override
  String get conditionDiabetesSubtitle => 'Common long-term therapy patterns';

  @override
  String get conditionHypertensionTitle => 'Hypertension';

  @override
  String get conditionHypertensionSubtitle =>
      'Frequent blood pressure medications';

  @override
  String get conditionCholesterolTitle => 'High cholesterol';

  @override
  String get conditionCholesterolSubtitle =>
      'Common evening lipid-lowering therapy';

  @override
  String get conditionThyroidTitle => 'Hypothyroidism';

  @override
  String get conditionThyroidSubtitle => 'Typical morning thyroid replacement';

  @override
  String get conditionGerdTitle => 'Acid reflux / GERD';

  @override
  String get conditionGerdSubtitle => 'Frequent acid symptom control';

  @override
  String get conditionAsthmaTitle => 'Asthma';

  @override
  String get conditionAsthmaSubtitle => 'Common controller and rescue patterns';

  @override
  String get conditionAllergyTitle => 'Allergy';

  @override
  String get conditionAllergySubtitle =>
      'Frequent antihistamine symptom control';

  @override
  String get conditionHeartPreventionTitle => 'Heart disease / prevention';

  @override
  String get conditionHeartPreventionSubtitle =>
      'Frequent long-term cardiology patterns';

  @override
  String get conditionHeartFailureTitle => 'Heart failure';

  @override
  String get conditionHeartFailureSubtitle =>
      'Frequent fluid and blood pressure support therapy';

  @override
  String get conditionAtrialFibrillationTitle => 'Atrial fibrillation';

  @override
  String get conditionAtrialFibrillationSubtitle =>
      'Common rhythm and stroke prevention therapy';

  @override
  String get conditionJointPainTitle => 'Joint pain / arthritis';

  @override
  String get conditionJointPainSubtitle =>
      'Frequent pain and inflammation control';

  @override
  String get conditionBphTitle => 'Prostate / BPH';

  @override
  String get conditionBphSubtitle => 'Common urinary symptom control';

  @override
  String get conditionOsteoporosisTitle => 'Osteoporosis / bone health';

  @override
  String get conditionOsteoporosisSubtitle =>
      'Frequent bone support therapy patterns';

  @override
  String get conditionAnemiaTitle => 'Iron deficiency / anemia';

  @override
  String get conditionAnemiaSubtitle => 'Frequent iron replacement patterns';

  @override
  String get suggestionMetforminName => 'Metformin';

  @override
  String get suggestionMetforminNote =>
      'Typical oral therapy. Confirm the exact dose with the prescription.';

  @override
  String get suggestionInsulinName => 'Insulin';

  @override
  String get suggestionInsulinNote =>
      'Injection template. Adjust insulin type, dose, and timing to the real regimen.';

  @override
  String get suggestionAmlodipineName => 'Amlodipine';

  @override
  String get suggestionAmlodipineNote =>
      'Common once-daily blood pressure control.';

  @override
  String get suggestionLosartanName => 'Losartan';

  @override
  String get suggestionLosartanNote => 'Often used as daily long-term therapy.';

  @override
  String get suggestionAtorvastatinName => 'Atorvastatin';

  @override
  String get suggestionAtorvastatinNote => 'A common daily statin template.';

  @override
  String get suggestionLevothyroxineName => 'Levothyroxine';

  @override
  String get suggestionLevothyroxineNote =>
      'Usually taken in the morning before food.';

  @override
  String get suggestionOmeprazoleName => 'Omeprazole';

  @override
  String get suggestionOmeprazoleNote =>
      'Often taken in the morning before food.';

  @override
  String get suggestionFamotidineName => 'Famotidine';

  @override
  String get suggestionFamotidineNote =>
      'Used for acid symptoms, often in the evening.';

  @override
  String get suggestionBudesonideFormoterolName => 'Budesonide/Formoterol';

  @override
  String get suggestionBudesonideFormoterolNote =>
      'Common maintenance inhaler template.';

  @override
  String get suggestionAlbuterolName => 'Albuterol';

  @override
  String get suggestionAlbuterolNote => 'Common rescue inhaler kept as needed.';

  @override
  String get suggestionCetirizineName => 'Cetirizine';

  @override
  String get suggestionCetirizineNote =>
      'Often used once daily for allergy symptoms.';

  @override
  String get suggestionLoratadineName => 'Loratadine';

  @override
  String get suggestionLoratadineNote =>
      'Common daytime antihistamine template.';

  @override
  String get suggestionAspirinName => 'Aspirin';

  @override
  String get suggestionAspirinNote =>
      'Common low-dose cardiovascular prevention template.';

  @override
  String get suggestionClopidogrelName => 'Clopidogrel';

  @override
  String get suggestionClopidogrelNote =>
      'Often used as once-daily antiplatelet therapy.';

  @override
  String get suggestionFurosemideName => 'Furosemide';

  @override
  String get suggestionFurosemideNote =>
      'Diuretic template often taken earlier in the day.';

  @override
  String get suggestionSpironolactoneName => 'Spironolactone';

  @override
  String get suggestionSpironolactoneNote =>
      'Common once-daily support therapy pattern.';

  @override
  String get suggestionApixabanName => 'Apixaban';

  @override
  String get suggestionApixabanNote =>
      'Common twice-daily anticoagulant pattern.';

  @override
  String get suggestionMetoprololName => 'Metoprolol';

  @override
  String get suggestionMetoprololNote => 'Often used for heart rate control.';

  @override
  String get suggestionIbuprofenName => 'Ibuprofen';

  @override
  String get suggestionIbuprofenNote =>
      'Common short-term pain relief template.';

  @override
  String get suggestionDiclofenacGelName => 'Diclofenac gel';

  @override
  String get suggestionDiclofenacGelNote =>
      'Topical anti-inflammatory symptom relief template.';

  @override
  String get suggestionTamsulosinName => 'Tamsulosin';

  @override
  String get suggestionTamsulosinNote =>
      'Often taken in the evening after food.';

  @override
  String get suggestionFinasterideName => 'Finasteride';

  @override
  String get suggestionFinasterideNote =>
      'Common once-daily long-term support.';

  @override
  String get suggestionAlendronateName => 'Alendronate';

  @override
  String get suggestionAlendronateNote =>
      'Typical weekly morning template before food.';

  @override
  String get suggestionCalciumVitaminDName => 'Calcium + Vitamin D';

  @override
  String get suggestionCalciumVitaminDNote =>
      'Common bone support supplement routine.';

  @override
  String get suggestionFerrousSulfateName => 'Ferrous sulfate';

  @override
  String get suggestionFerrousSulfateNote =>
      'Common oral iron replacement template.';

  @override
  String get suggestionFolicAcidName => 'Folic acid';

  @override
  String get suggestionFolicAcidNote => 'Common supportive vitamin template.';

  @override
  String get pdfDoctorReportTitle => 'Doctor report';

  @override
  String get pdfSupplementCourseSummary => 'Supplement course summary';

  @override
  String get pdfMedicationCourseSummary => 'Medication course summary';

  @override
  String get pdfCourseProfileTitle => 'Course profile';

  @override
  String get pdfScheduleSnapshotTitle => 'Schedule snapshot';

  @override
  String get pdfScheduleSnapshotSubtitle =>
      'A representative day of the course with time and dosage.';

  @override
  String get pdfAdministrationHistoryTitle => 'Administration history';

  @override
  String get pdfAdministrationHistorySubtitle =>
      'Shows what was taken and how it matched the planned schedule.';

  @override
  String get pdfAdherenceLabel => 'Adherence';

  @override
  String get pdfSnoozedLabel => 'Snoozed';

  @override
  String get pdfClinicalSummaryTitle => 'Clinical summary';

  @override
  String get pdfPatientLabel => 'Patient';

  @override
  String get pdfCaregiverLabel => 'Caregiver';

  @override
  String get pdfReportPeriodLabel => 'Report period';

  @override
  String get pdfOnTimeRateLabel => 'On-time rate';

  @override
  String get pdfAverageDelayLabel => 'Average delay';

  @override
  String get pdfUpcomingDosesLabel => 'Upcoming doses';

  @override
  String get pdfStockLeftLabel => 'Stock left';

  @override
  String get pdfNameLabel => 'Name';

  @override
  String get pdfCourseTypeLabel => 'Course type';

  @override
  String get pdfDosageLabel => 'Dosage';

  @override
  String get pdfFrequencyLabel => 'Frequency';

  @override
  String get pdfStartedLabel => 'Started';

  @override
  String get pdfInstructionLabel => 'Instruction';

  @override
  String get pdfNotesLabel => 'Notes';

  @override
  String get pdfTimelineEmpty => 'No recorded administration history yet.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return 'This PDF shows the latest $visible entries out of $total.';
  }

  @override
  String get pdfTableScheduled => 'Scheduled';

  @override
  String get pdfTableActual => 'Actual';

  @override
  String get pdfTableDose => 'Dose';

  @override
  String get pdfTableStatus => 'Status';

  @override
  String get pdfTableDelay => 'Delay';

  @override
  String get pdfOnTime => 'On time';

  @override
  String get pdfMinuteShort => 'min';

  @override
  String get pdfNoFoodRestriction => 'No food restriction';
}
