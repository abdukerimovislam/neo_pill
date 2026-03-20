import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'AI Medication Manager'**
  String get appTitle;

  /// No description provided for @todaySchedule.
  ///
  /// In en, this message translates to:
  /// **'Today Schedule'**
  String get todaySchedule;

  /// No description provided for @architectureReady.
  ///
  /// In en, this message translates to:
  /// **'Architecture is set. All systems normal.'**
  String get architectureReady;

  /// No description provided for @nextCreateHome.
  ///
  /// In en, this message translates to:
  /// **'Next: Create Home Screen'**
  String get nextCreateHome;

  /// No description provided for @statusTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get statusTaken;

  /// No description provided for @statusSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get statusSkipped;

  /// No description provided for @statusSnoozed.
  ///
  /// In en, this message translates to:
  /// **'Snoozed 10 min'**
  String get statusSnoozed;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @emptySchedule.
  ///
  /// In en, this message translates to:
  /// **'No medications scheduled for this day'**
  String get emptySchedule;

  /// No description provided for @takeAction.
  ///
  /// In en, this message translates to:
  /// **'Take'**
  String get takeAction;

  /// No description provided for @skipAction.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipAction;

  /// No description provided for @dosageUnitMg.
  ///
  /// In en, this message translates to:
  /// **'mg'**
  String get dosageUnitMg;

  /// No description provided for @dosageUnitMl.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get dosageUnitMl;

  /// No description provided for @dosageUnitDrops.
  ///
  /// In en, this message translates to:
  /// **'drops'**
  String get dosageUnitDrops;

  /// No description provided for @addMedicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Medication'**
  String get addMedicationTitle;

  /// No description provided for @medicineNameHint.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name (e.g. Vitamin D)'**
  String get medicineNameHint;

  /// No description provided for @dosageHint.
  ///
  /// In en, this message translates to:
  /// **'Dosage (e.g. 500)'**
  String get dosageHint;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save & Create Schedule'**
  String get saveAction;

  /// No description provided for @errorEmptyFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get errorEmptyFields;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to take {name}!'**
  String notificationTitle(String name);

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'Dosage: {dosage}. Please don\'t miss it.'**
  String notificationBody(String dosage);

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// No description provided for @adherenceRate.
  ///
  /// In en, this message translates to:
  /// **'Adherence Rate'**
  String get adherenceRate;

  /// No description provided for @dosesTaken.
  ///
  /// In en, this message translates to:
  /// **'Doses Taken'**
  String get dosesTaken;

  /// No description provided for @dosesMissed.
  ///
  /// In en, this message translates to:
  /// **'Doses Missed'**
  String get dosesMissed;

  /// No description provided for @activeCourses.
  ///
  /// In en, this message translates to:
  /// **'Active Courses'**
  String get activeCourses;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get tabHome;

  /// No description provided for @tabAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get tabAnalytics;

  /// No description provided for @keepItUp.
  ///
  /// In en, this message translates to:
  /// **'Great job! Keep it up.'**
  String get keepItUp;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention. Try not to miss doses.'**
  String get needsAttention;

  /// No description provided for @medicineDetails.
  ///
  /// In en, this message translates to:
  /// **'Medicine Details'**
  String get medicineDetails;

  /// No description provided for @pillsRemaining.
  ///
  /// In en, this message translates to:
  /// **'Pills Remaining'**
  String get pillsRemaining;

  /// No description provided for @deleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this medication and all its reminders?'**
  String get deleteConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @timeOfDay.
  ///
  /// In en, this message translates to:
  /// **'Time of Day'**
  String get timeOfDay;

  /// No description provided for @courseDuration.
  ///
  /// In en, this message translates to:
  /// **'Course Duration (days)'**
  String get courseDuration;

  /// No description provided for @pillsInPackage.
  ///
  /// In en, this message translates to:
  /// **'Pills in Package'**
  String get pillsInPackage;

  /// No description provided for @addTime.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get addTime;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time {number}'**
  String timeLabel(int number);

  /// No description provided for @foodBefore.
  ///
  /// In en, this message translates to:
  /// **'Before food'**
  String get foodBefore;

  /// No description provided for @foodWith.
  ///
  /// In en, this message translates to:
  /// **'With food'**
  String get foodWith;

  /// No description provided for @foodAfter.
  ///
  /// In en, this message translates to:
  /// **'After food'**
  String get foodAfter;

  /// No description provided for @unknownMedicine.
  ///
  /// In en, this message translates to:
  /// **'Unknown medicine'**
  String get unknownMedicine;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @medicineInfo.
  ///
  /// In en, this message translates to:
  /// **'Medicine Info'**
  String get medicineInfo;

  /// No description provided for @formTitle.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get formTitle;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @everyXDays.
  ///
  /// In en, this message translates to:
  /// **'Every X days'**
  String get everyXDays;

  /// No description provided for @maxDosesPerDay.
  ///
  /// In en, this message translates to:
  /// **'Max doses per day (Safety)'**
  String get maxDosesPerDay;

  /// No description provided for @overdoseWarning.
  ///
  /// In en, this message translates to:
  /// **'To prevent accidental overdose.'**
  String get overdoseWarning;

  /// No description provided for @foodInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Instruction'**
  String get foodInstructionTitle;

  /// No description provided for @doseNumber.
  ///
  /// In en, this message translates to:
  /// **'Dose {number}'**
  String doseNumber(int number);

  /// No description provided for @coursePaused.
  ///
  /// In en, this message translates to:
  /// **'Course Paused'**
  String get coursePaused;

  /// No description provided for @resumeCourse.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeCourse;

  /// No description provided for @pauseCourse.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseCourse;

  /// No description provided for @doctorReport.
  ///
  /// In en, this message translates to:
  /// **'Doctor Report'**
  String get doctorReport;

  /// No description provided for @generatingReport.
  ///
  /// In en, this message translates to:
  /// **'Generating Doctor Report...'**
  String get generatingReport;

  /// No description provided for @errorGeneratingReport.
  ///
  /// In en, this message translates to:
  /// **'Error generating PDF: {error}'**
  String errorGeneratingReport(String error);

  /// No description provided for @editCourse.
  ///
  /// In en, this message translates to:
  /// **'Edit Course'**
  String get editCourse;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @editMedicineInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit Medicine Info'**
  String get editMedicineInfo;

  /// No description provided for @lowStockTitle.
  ///
  /// In en, this message translates to:
  /// **'Low Stock: {name}'**
  String lowStockTitle(String name);

  /// No description provided for @lowStockBody.
  ///
  /// In en, this message translates to:
  /// **'Only {count} {unit} left. Time to refill!'**
  String lowStockBody(int count, String unit);

  /// No description provided for @lowStockBadge.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get lowStockBadge;

  /// No description provided for @snoozeAction.
  ///
  /// In en, this message translates to:
  /// **'Snooze (30m)'**
  String get snoozeAction;

  /// No description provided for @undoAction.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoAction;

  /// No description provided for @sosPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'As Needed (SOS)'**
  String get sosPanelTitle;

  /// No description provided for @takeNowAction.
  ///
  /// In en, this message translates to:
  /// **'TAKE NOW'**
  String get takeNowAction;

  /// No description provided for @limitReachedAlert.
  ///
  /// In en, this message translates to:
  /// **'Daily limit reached! Consult your doctor.'**
  String get limitReachedAlert;

  /// No description provided for @addSosMedicine.
  ///
  /// In en, this message translates to:
  /// **'Add SOS'**
  String get addSosMedicine;

  /// No description provided for @outOfStockBadge.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStockBadge;

  /// No description provided for @recentHistory.
  ///
  /// In en, this message translates to:
  /// **'Recent History'**
  String get recentHistory;

  /// No description provided for @noHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get noHistoryYet;

  /// No description provided for @lifetimeCourse.
  ///
  /// In en, this message translates to:
  /// **'Continuous (Lifetime)'**
  String get lifetimeCourse;

  /// No description provided for @doneAction.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAction;

  /// No description provided for @addMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Log Health Data'**
  String get addMeasurement;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get bloodPressure;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @bloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar'**
  String get bloodSugar;

  /// No description provided for @systolic.
  ///
  /// In en, this message translates to:
  /// **'Sys'**
  String get systolic;

  /// No description provided for @diastolic.
  ///
  /// In en, this message translates to:
  /// **'Dia'**
  String get diastolic;

  /// No description provided for @taperingDosing.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Dosing (Tapering)'**
  String get taperingDosing;

  /// No description provided for @stepNumber.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String stepNumber(int number);

  /// No description provided for @addStep.
  ///
  /// In en, this message translates to:
  /// **'Add Step'**
  String get addStep;

  /// No description provided for @doseForStep.
  ///
  /// In en, this message translates to:
  /// **'Dose for this step'**
  String get doseForStep;

  /// No description provided for @whatWouldYouLikeToDo.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do?'**
  String get whatWouldYouLikeToDo;

  /// No description provided for @scheduleNewTreatmentCourse.
  ///
  /// In en, this message translates to:
  /// **'Schedule a new treatment course'**
  String get scheduleNewTreatmentCourse;

  /// No description provided for @logHealthMetricsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log blood pressure, heart rate, weight'**
  String get logHealthMetricsSubtitle;

  /// No description provided for @priorityAction.
  ///
  /// In en, this message translates to:
  /// **'Priority Action'**
  String get priorityAction;

  /// No description provided for @skipDoseAction.
  ///
  /// In en, this message translates to:
  /// **'Skip Dose'**
  String get skipDoseAction;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorPrefix(String error);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @dailyProgress.
  ///
  /// In en, this message translates to:
  /// **'Daily Progress'**
  String get dailyProgress;

  /// No description provided for @sosEmergency.
  ///
  /// In en, this message translates to:
  /// **'SOS Emergency'**
  String get sosEmergency;

  /// No description provided for @adherenceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your medication consistency overview'**
  String get adherenceSubtitle;

  /// No description provided for @healthCorrelationTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Correlation'**
  String get healthCorrelationTitle;

  /// No description provided for @healthCorrelationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compare medication adherence with your health metrics'**
  String get healthCorrelationSubtitle;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get last7Days;

  /// No description provided for @pillsTaken.
  ///
  /// In en, this message translates to:
  /// **'Pills taken'**
  String get pillsTaken;

  /// No description provided for @overallAdherence.
  ///
  /// In en, this message translates to:
  /// **'Overall adherence'**
  String get overallAdherence;

  /// No description provided for @statusGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get statusGood;

  /// No description provided for @statusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get statusNeedsAttention;

  /// No description provided for @statTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get statTaken;

  /// No description provided for @statSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get statSkipped;

  /// No description provided for @statTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @completedDosesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Completed doses'**
  String get completedDosesSubtitle;

  /// No description provided for @missedDosesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Missed doses'**
  String get missedDosesSubtitle;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataYet;

  /// No description provided for @noDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Start tracking measurements and taking medication regularly\nto see correlation insights here.'**
  String get noDataDescription;

  /// No description provided for @failedToLoadAdherence.
  ///
  /// In en, this message translates to:
  /// **'Failed to load adherence'**
  String get failedToLoadAdherence;

  /// No description provided for @failedToLoadChart.
  ///
  /// In en, this message translates to:
  /// **'Failed to load chart'**
  String get failedToLoadChart;

  /// No description provided for @avgAdherence.
  ///
  /// In en, this message translates to:
  /// **'Avg adherence {value}%'**
  String avgAdherence(String value);

  /// No description provided for @avgMetric.
  ///
  /// In en, this message translates to:
  /// **'Avg {metricName} {value}'**
  String avgMetric(String metricName, String value);

  /// No description provided for @addAction.
  ///
  /// In en, this message translates to:
  /// **'Add Log'**
  String get addAction;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @form.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get form;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @lowStockAlert.
  ///
  /// In en, this message translates to:
  /// **'LOW STOCK'**
  String get lowStockAlert;

  /// No description provided for @asNeededFrequency.
  ///
  /// In en, this message translates to:
  /// **'AS NEEDED'**
  String get asNeededFrequency;

  /// No description provided for @taperingFrequency.
  ///
  /// In en, this message translates to:
  /// **'TAPERING'**
  String get taperingFrequency;

  /// No description provided for @customizePill.
  ///
  /// In en, this message translates to:
  /// **'Customize Appearance'**
  String get customizePill;

  /// No description provided for @customizePillTitle.
  ///
  /// In en, this message translates to:
  /// **'Customize Pill'**
  String get customizePillTitle;

  /// No description provided for @shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get shape;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @scheduleAndRules.
  ///
  /// In en, this message translates to:
  /// **'Schedule & Rules'**
  String get scheduleAndRules;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @daysSuffix.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysSuffix;

  /// No description provided for @pcsSuffix.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get pcsSuffix;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Profile'**
  String get settingsTitle;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @advancedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Advanced Features'**
  String get advancedFeatures;

  /// No description provided for @caregivers.
  ///
  /// In en, this message translates to:
  /// **'Med-Friends & Caregivers'**
  String get caregivers;

  /// No description provided for @drugInteractions.
  ///
  /// In en, this message translates to:
  /// **'Drug Interactions'**
  String get drugInteractions;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'SOON'**
  String get comingSoon;

  /// No description provided for @supportAndAbout.
  ///
  /// In en, this message translates to:
  /// **'Support & About'**
  String get supportAndAbout;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
