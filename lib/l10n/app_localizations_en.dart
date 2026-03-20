// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AI Medication Manager';

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
  String get pillsRemaining => 'Pills Remaining';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get deleteConfirmation =>
      'Are you sure you want to delete this medication and all its reminders?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get timeOfDay => 'Time of Day';

  @override
  String get courseDuration => 'Course Duration (days)';

  @override
  String get pillsInPackage => 'Pills in Package';

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
}
