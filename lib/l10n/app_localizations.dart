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
  /// **'Pillora'**
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

  /// No description provided for @dosageUnitPcs.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get dosageUnitPcs;

  /// No description provided for @dosageUnitG.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get dosageUnitG;

  /// No description provided for @dosageUnitMcg.
  ///
  /// In en, this message translates to:
  /// **'mcg'**
  String get dosageUnitMcg;

  /// No description provided for @dosageUnitIu.
  ///
  /// In en, this message translates to:
  /// **'IU'**
  String get dosageUnitIu;

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
  /// **'Remaining in stock'**
  String get pillsRemaining;

  /// No description provided for @deleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this course and all its reminders?'**
  String get deleteConfirmation;

  /// No description provided for @courseAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'{type} \"{name}\" added.'**
  String courseAddedMessage(String type, String name);

  /// No description provided for @courseUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'{type} \"{name}\" updated.'**
  String courseUpdatedMessage(String type, String name);

  /// No description provided for @courseDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'{type} \"{name}\" deleted.'**
  String courseDeletedMessage(String type, String name);

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
  /// **'Amount in package'**
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

  /// No description provided for @foodNoMatter.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get foodNoMatter;

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

  /// No description provided for @coursePausedMessage.
  ///
  /// In en, this message translates to:
  /// **'{type} \"{name}\" paused.'**
  String coursePausedMessage(String type, String name);

  /// No description provided for @courseResumedMessage.
  ///
  /// In en, this message translates to:
  /// **'{type} \"{name}\" resumed.'**
  String courseResumedMessage(String type, String name);

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

  /// No description provided for @defaultUserName.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get defaultUserName;

  /// No description provided for @courseKindMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get courseKindMedication;

  /// No description provided for @courseKindSupplement.
  ///
  /// In en, this message translates to:
  /// **'Supplement'**
  String get courseKindSupplement;

  /// No description provided for @courseFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get courseFilterAll;

  /// No description provided for @courseFilterMedications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get courseFilterMedications;

  /// No description provided for @courseFilterSupplements.
  ///
  /// In en, this message translates to:
  /// **'Supplements'**
  String get courseFilterSupplements;

  /// No description provided for @homeTakeMedicationNow.
  ///
  /// In en, this message translates to:
  /// **'Take this medication now'**
  String get homeTakeMedicationNow;

  /// No description provided for @homeTakeSupplementNow.
  ///
  /// In en, this message translates to:
  /// **'Take this supplement now'**
  String get homeTakeSupplementNow;

  /// No description provided for @homeEmptyAllTitle.
  ///
  /// In en, this message translates to:
  /// **'You have a quiet moment'**
  String get homeEmptyAllTitle;

  /// No description provided for @homeEmptyMedicationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications are all set'**
  String get homeEmptyMedicationsTitle;

  /// No description provided for @homeEmptySupplementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Supplements are all set'**
  String get homeEmptySupplementsTitle;

  /// No description provided for @homeEmptyAllSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing needs attention right now. You can check another day or add a new course when you are ready.'**
  String get homeEmptyAllSubtitle;

  /// No description provided for @homeEmptyMedicationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No medications need attention on this date. It is a good moment for a calm pause.'**
  String get homeEmptyMedicationsSubtitle;

  /// No description provided for @homeEmptySupplementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No supplements need attention on this date. Your wellness routine is clear for now.'**
  String get homeEmptySupplementsSubtitle;

  /// No description provided for @homeAddSupplementTitle.
  ///
  /// In en, this message translates to:
  /// **'Add supplement'**
  String get homeAddSupplementTitle;

  /// No description provided for @homeAddSupplementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule vitamins and wellness supplements'**
  String get homeAddSupplementSubtitle;

  /// No description provided for @homeForThisDay.
  ///
  /// In en, this message translates to:
  /// **'For this day'**
  String get homeForThisDay;

  /// No description provided for @homeMorningRoutine.
  ///
  /// In en, this message translates to:
  /// **'Morning routine'**
  String get homeMorningRoutine;

  /// No description provided for @homeAfternoonRoutine.
  ///
  /// In en, this message translates to:
  /// **'Afternoon routine'**
  String get homeAfternoonRoutine;

  /// No description provided for @homeEveningRoutine.
  ///
  /// In en, this message translates to:
  /// **'Evening routine'**
  String get homeEveningRoutine;

  /// No description provided for @homeNightRoutine.
  ///
  /// In en, this message translates to:
  /// **'Night routine'**
  String get homeNightRoutine;

  /// No description provided for @homeRoutineSupplementsOnly.
  ///
  /// In en, this message translates to:
  /// **'supplements only'**
  String get homeRoutineSupplementsOnly;

  /// No description provided for @homeRoutineMedicationsOnly.
  ///
  /// In en, this message translates to:
  /// **'medications only'**
  String get homeRoutineMedicationsOnly;

  /// No description provided for @homeRoutineMixed.
  ///
  /// In en, this message translates to:
  /// **'mixed routine'**
  String get homeRoutineMixed;

  /// No description provided for @homeRoutineItemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 item} other{{count} items}}'**
  String homeRoutineItemCount(int count);

  /// No description provided for @homeNeedsAttentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get homeNeedsAttentionTitle;

  /// No description provided for @homeNeedsAttentionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 scheduled item should be taken or reviewed now.} other{{count} scheduled items should be taken or reviewed now.}}'**
  String homeNeedsAttentionSubtitle(int count);

  /// No description provided for @homeNextUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Next up'**
  String get homeNextUpTitle;

  /// No description provided for @homeRefillReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Refill reminder'**
  String get homeRefillReminderTitle;

  /// No description provided for @homeRefillReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 course may need a refill soon.} other{{count} courses may need a refill soon.}}'**
  String homeRefillReminderSubtitle(int count);

  /// No description provided for @homeEverythingCalmTitle.
  ///
  /// In en, this message translates to:
  /// **'Everything is calm'**
  String get homeEverythingCalmTitle;

  /// No description provided for @homeEverythingCalmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No urgent medication or supplement tasks right now.'**
  String get homeEverythingCalmSubtitle;

  /// No description provided for @homeNoUpcomingItem.
  ///
  /// In en, this message translates to:
  /// **'No upcoming item scheduled.'**
  String get homeNoUpcomingItem;

  /// No description provided for @homeScheduledFor.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for {time}'**
  String homeScheduledFor(String time);

  /// No description provided for @calendarToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calendarToday;

  /// No description provided for @calendarSelectedDay.
  ///
  /// In en, this message translates to:
  /// **'Selected day'**
  String get calendarSelectedDay;

  /// No description provided for @calendarShowingToday.
  ///
  /// In en, this message translates to:
  /// **'Showing today\'s schedule'**
  String get calendarShowingToday;

  /// No description provided for @calendarBrowseNearbyDays.
  ///
  /// In en, this message translates to:
  /// **'Scroll the wheel to browse nearby days'**
  String get calendarBrowseNearbyDays;

  /// No description provided for @calendarPreviewAnotherDay.
  ///
  /// In en, this message translates to:
  /// **'The wheel lets you preview another day before the screen updates.'**
  String get calendarPreviewAnotherDay;

  /// No description provided for @calendarDayWheelSemantics.
  ///
  /// In en, this message translates to:
  /// **'Day wheel'**
  String get calendarDayWheelSemantics;

  /// No description provided for @analyticsCourseMix.
  ///
  /// In en, this message translates to:
  /// **'Course mix'**
  String get analyticsCourseMix;

  /// No description provided for @analyticsCourseMixSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Treatment courses and supplements are tracked together, but measured separately here.'**
  String get analyticsCourseMixSubtitle;

  /// No description provided for @analyticsCurrentRoutine.
  ///
  /// In en, this message translates to:
  /// **'Current routine'**
  String get analyticsCurrentRoutine;

  /// No description provided for @analyticsCurrentRoutineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Days in a row without missed doses'**
  String get analyticsCurrentRoutineSubtitle;

  /// No description provided for @analyticsTimingAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Timing accuracy'**
  String get analyticsTimingAccuracy;

  /// No description provided for @analyticsTimingAccuracySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Taken within 30 minutes'**
  String get analyticsTimingAccuracySubtitle;

  /// No description provided for @analyticsBestRoutine.
  ///
  /// In en, this message translates to:
  /// **'Best routine'**
  String get analyticsBestRoutine;

  /// No description provided for @analyticsBestRoutineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Best result in the last 90 days'**
  String get analyticsBestRoutineSubtitle;

  /// No description provided for @analyticsRefillRisk.
  ///
  /// In en, this message translates to:
  /// **'Refill risk'**
  String get analyticsRefillRisk;

  /// No description provided for @analyticsRefillRiskSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Courses close to refill threshold'**
  String get analyticsRefillRiskSubtitle;

  /// No description provided for @analyticsAverageDelay.
  ///
  /// In en, this message translates to:
  /// **'Average delay'**
  String get analyticsAverageDelay;

  /// No description provided for @analyticsMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get analyticsMinutesShort;

  /// No description provided for @analyticsCoachNote.
  ///
  /// In en, this message translates to:
  /// **'Coach note'**
  String get analyticsCoachNote;

  /// No description provided for @analyticsMissedDoses.
  ///
  /// In en, this message translates to:
  /// **'Missed doses'**
  String get analyticsMissedDoses;

  /// No description provided for @analyticsActiveShort.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String analyticsActiveShort(int count);

  /// No description provided for @analyticsTakenMissed.
  ///
  /// In en, this message translates to:
  /// **'Taken: {taken}  Missed: {missed}'**
  String analyticsTakenMissed(int taken, int missed);

  /// No description provided for @settingsContactSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get settingsContactSupportTitle;

  /// No description provided for @settingsContactSupportBody.
  ///
  /// In en, this message translates to:
  /// **'If something feels confusing or isn\'t working as expected, we can help. Include your device model, app version, and a short description of the issue.'**
  String get settingsContactSupportBody;

  /// No description provided for @settingsSupportEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'Support email copied'**
  String get settingsSupportEmailCopied;

  /// No description provided for @settingsCopySupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Copy support email'**
  String get settingsCopySupportEmail;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacyBodyPrimary.
  ///
  /// In en, this message translates to:
  /// **'Pillora stores your course details, reminder settings, and dose history on your device so the app can show your schedule and generate reports.'**
  String get settingsPrivacyBodyPrimary;

  /// No description provided for @settingsPrivacyBodySecondary.
  ///
  /// In en, this message translates to:
  /// **'Medication photos and report exports are created only when you choose to use them. Before launch, replace this in-app summary with your final hosted privacy policy URL.'**
  String get settingsPrivacyBodySecondary;

  /// No description provided for @settingsPrivacyLaunchNote.
  ///
  /// In en, this message translates to:
  /// **'Launch note: publish a full privacy policy on your website or store listing before release.'**
  String get settingsPrivacyLaunchNote;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get settingsLanguageRussian;

  /// No description provided for @settingsYourProfilePreferences.
  ///
  /// In en, this message translates to:
  /// **'Your profile and important preferences'**
  String get settingsYourProfilePreferences;

  /// No description provided for @settingsComfortModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Comfort mode'**
  String get settingsComfortModeTitle;

  /// No description provided for @settingsComfortModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Larger text and calmer visuals'**
  String get settingsComfortModeSubtitle;

  /// No description provided for @settingsNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Medication reminders are enabled'**
  String get settingsNotificationsEnabled;

  /// No description provided for @settingsOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsOn;

  /// No description provided for @settingsSupportAndSafety.
  ///
  /// In en, this message translates to:
  /// **'Support and safety'**
  String get settingsSupportAndSafety;

  /// No description provided for @settingsShowOnboardingAgain.
  ///
  /// In en, this message translates to:
  /// **'Show onboarding again'**
  String get settingsShowOnboardingAgain;

  /// No description provided for @settingsShowOnboardingAgainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open the first-run guide again'**
  String get settingsShowOnboardingAgainSubtitle;

  /// No description provided for @settingsFeaturePolishing.
  ///
  /// In en, this message translates to:
  /// **'This feature is being polished for a later release'**
  String get settingsFeaturePolishing;

  /// No description provided for @settingsCaregiverTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver sharing'**
  String get settingsCaregiverTitle;

  /// No description provided for @settingsCaregiverDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a trusted person so reports can include their contact details and shared care stays organized.'**
  String get settingsCaregiverDescription;

  /// No description provided for @settingsCaregiverName.
  ///
  /// In en, this message translates to:
  /// **'Caregiver name'**
  String get settingsCaregiverName;

  /// No description provided for @settingsCaregiverRelation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get settingsCaregiverRelation;

  /// No description provided for @settingsCaregiverPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get settingsCaregiverPhone;

  /// No description provided for @settingsCaregiverShareReports.
  ///
  /// In en, this message translates to:
  /// **'Include caregiver in reports'**
  String get settingsCaregiverShareReports;

  /// No description provided for @settingsCaregiverShareReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor reports can include caregiver contact details when you share them.'**
  String get settingsCaregiverShareReportsSubtitle;

  /// No description provided for @settingsCaregiverSaved.
  ///
  /// In en, this message translates to:
  /// **'Caregiver settings saved'**
  String get settingsCaregiverSaved;

  /// No description provided for @settingsCaregiverRemoved.
  ///
  /// In en, this message translates to:
  /// **'Caregiver removed'**
  String get settingsCaregiverRemoved;

  /// No description provided for @settingsCaregiverRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove caregiver'**
  String get settingsCaregiverRemove;

  /// No description provided for @settingsCaregiverEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a trusted person for shared care and reports'**
  String get settingsCaregiverEmpty;

  /// No description provided for @settingsCaregiverAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alerts'**
  String get settingsCaregiverAlertsTitle;

  /// No description provided for @settingsCaregiverAlertsDescription.
  ///
  /// In en, this message translates to:
  /// **'If an important dose is late or marked as skipped, Pillora can prepare a ready alert for your caregiver on this device.'**
  String get settingsCaregiverAlertsDescription;

  /// No description provided for @settingsCaregiverAlertsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a caregiver first to prepare missed-dose alerts'**
  String get settingsCaregiverAlertsEmpty;

  /// No description provided for @settingsCaregiverAlertsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Alerts for your caregiver are turned off'**
  String get settingsCaregiverAlertsDisabled;

  /// No description provided for @settingsCaregiverAlertsEnabledSummary.
  ///
  /// In en, this message translates to:
  /// **'An alert is prepared after {minutes} minutes if attention is needed'**
  String settingsCaregiverAlertsEnabledSummary(int minutes);

  /// No description provided for @settingsCaregiverAlertsSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare caregiver alerts'**
  String get settingsCaregiverAlertsSwitchTitle;

  /// No description provided for @settingsCaregiverAlertsSwitchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When a dose needs attention, Pillora will prepare a message you can copy and send.'**
  String get settingsCaregiverAlertsSwitchSubtitle;

  /// No description provided for @settingsCaregiverAlertsGraceTitle.
  ///
  /// In en, this message translates to:
  /// **'Grace period'**
  String get settingsCaregiverAlertsGraceTitle;

  /// No description provided for @settingsCaregiverAlertsGraceDescription.
  ///
  /// In en, this message translates to:
  /// **'Wait {minutes} minutes before preparing an alert for an overdue item.'**
  String settingsCaregiverAlertsGraceDescription(int minutes);

  /// No description provided for @settingsCaregiverAlertsGraceChip.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String settingsCaregiverAlertsGraceChip(int minutes);

  /// No description provided for @settingsCaregiverAlertsOverdueTitle.
  ///
  /// In en, this message translates to:
  /// **'Include overdue doses'**
  String get settingsCaregiverAlertsOverdueTitle;

  /// No description provided for @settingsCaregiverAlertsOverdueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare an alert when a planned dose is still pending after the grace period.'**
  String get settingsCaregiverAlertsOverdueSubtitle;

  /// No description provided for @settingsCaregiverAlertsSkippedTitle.
  ///
  /// In en, this message translates to:
  /// **'Include skipped doses'**
  String get settingsCaregiverAlertsSkippedTitle;

  /// No description provided for @settingsCaregiverAlertsSkippedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare an alert when a dose is explicitly marked as skipped.'**
  String get settingsCaregiverAlertsSkippedSubtitle;

  /// No description provided for @settingsCaregiverAlertsSupplementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Include supplements'**
  String get settingsCaregiverAlertsSupplementsTitle;

  /// No description provided for @settingsCaregiverAlertsSupplementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the same alert flow for supplements, not only medications.'**
  String get settingsCaregiverAlertsSupplementsSubtitle;

  /// No description provided for @settingsCaregiverAlertsSaved.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alert rules saved'**
  String get settingsCaregiverAlertsSaved;

  /// No description provided for @settingsCaregiverConnectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Connected caregiver delivery'**
  String get settingsCaregiverConnectedTitle;

  /// No description provided for @settingsCaregiverConnectedDescription.
  ///
  /// In en, this message translates to:
  /// **'This app-side layer keeps a stable link code and a sync-ready outbox, so direct caregiver device alerts can be connected cleanly when cloud delivery is enabled.'**
  String get settingsCaregiverConnectedDescription;

  /// No description provided for @settingsCaregiverConnectedReady.
  ///
  /// In en, this message translates to:
  /// **'Link-ready code is prepared. No alerts are waiting in the outbox.'**
  String get settingsCaregiverConnectedReady;

  /// No description provided for @settingsCaregiverConnectedPending.
  ///
  /// In en, this message translates to:
  /// **'{count} alert(s) are waiting in the connected-delivery outbox.'**
  String settingsCaregiverConnectedPending(int count);

  /// No description provided for @settingsCaregiverConnectedCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver link code'**
  String get settingsCaregiverConnectedCodeTitle;

  /// No description provided for @settingsCaregiverConnectedCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep this code ready for linking the caregiver device when direct delivery is enabled.'**
  String get settingsCaregiverConnectedCodeSubtitle;

  /// No description provided for @settingsCaregiverConnectedOutboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert outbox'**
  String get settingsCaregiverConnectedOutboxTitle;

  /// No description provided for @settingsCaregiverConnectedLastQueued.
  ///
  /// In en, this message translates to:
  /// **'Last queued: {value}'**
  String settingsCaregiverConnectedLastQueued(String value);

  /// No description provided for @settingsCaregiverConnectedCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy link code'**
  String get settingsCaregiverConnectedCopyCode;

  /// No description provided for @settingsCaregiverConnectedCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Caregiver link code copied'**
  String get settingsCaregiverConnectedCodeCopied;

  /// No description provided for @settingsCaregiverConnectedClearOutbox.
  ///
  /// In en, this message translates to:
  /// **'Clear outbox'**
  String get settingsCaregiverConnectedClearOutbox;

  /// No description provided for @settingsCaregiverConnectedOutboxCleared.
  ///
  /// In en, this message translates to:
  /// **'Caregiver outbox cleared'**
  String get settingsCaregiverConnectedOutboxCleared;

  /// No description provided for @settingsCaregiverConnectedCloudTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud link mode'**
  String get settingsCaregiverConnectedCloudTitle;

  /// No description provided for @settingsCaregiverConnectedModePatient.
  ///
  /// In en, this message translates to:
  /// **'This device is acting as the patient device and mirrors alerts to Firestore.'**
  String get settingsCaregiverConnectedModePatient;

  /// No description provided for @settingsCaregiverConnectedModeCaregiver.
  ///
  /// In en, this message translates to:
  /// **'This device is linked as the caregiver device for {patientName}.'**
  String settingsCaregiverConnectedModeCaregiver(String patientName);

  /// No description provided for @settingsCaregiverConnectedModeNone.
  ///
  /// In en, this message translates to:
  /// **'This device is not linked to the cloud caregiver flow yet.'**
  String get settingsCaregiverConnectedModeNone;

  /// No description provided for @settingsCaregiverConnectedCloudCode.
  ///
  /// In en, this message translates to:
  /// **'Linked code: {code}'**
  String settingsCaregiverConnectedCloudCode(String code);

  /// No description provided for @settingsCaregiverConnectedInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver inbox preview'**
  String get settingsCaregiverConnectedInboxTitle;

  /// No description provided for @settingsCaregiverConnectedInboxEmpty.
  ///
  /// In en, this message translates to:
  /// **'No cloud alerts are waiting right now.'**
  String get settingsCaregiverConnectedInboxEmpty;

  /// No description provided for @settingsCaregiverConnectedUsePatientDevice.
  ///
  /// In en, this message translates to:
  /// **'Use this device as patient'**
  String get settingsCaregiverConnectedUsePatientDevice;

  /// No description provided for @settingsCaregiverConnectedPatientModeSaved.
  ///
  /// In en, this message translates to:
  /// **'This device is now linked as the patient device'**
  String get settingsCaregiverConnectedPatientModeSaved;

  /// No description provided for @settingsCaregiverConnectedUseCaregiverDevice.
  ///
  /// In en, this message translates to:
  /// **'Connect this device as caregiver'**
  String get settingsCaregiverConnectedUseCaregiverDevice;

  /// No description provided for @settingsCaregiverConnectedJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join caregiver link'**
  String get settingsCaregiverConnectedJoinTitle;

  /// No description provided for @settingsCaregiverConnectedJoinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the caregiver link code from the patient device to receive alerts in this app while it is active.'**
  String get settingsCaregiverConnectedJoinSubtitle;

  /// No description provided for @settingsCaregiverConnectedJoinAction.
  ///
  /// In en, this message translates to:
  /// **'Connect caregiver device'**
  String get settingsCaregiverConnectedJoinAction;

  /// No description provided for @settingsCaregiverConnectedCaregiverModeSaved.
  ///
  /// In en, this message translates to:
  /// **'This device is now linked as the caregiver device'**
  String get settingsCaregiverConnectedCaregiverModeSaved;

  /// No description provided for @settingsCaregiverConnectedJoinFailed.
  ///
  /// In en, this message translates to:
  /// **'The caregiver link code was not found'**
  String get settingsCaregiverConnectedJoinFailed;

  /// No description provided for @settingsCaregiverConnectedDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect cloud link'**
  String get settingsCaregiverConnectedDisconnect;

  /// No description provided for @settingsCaregiverConnectedDisconnected.
  ///
  /// In en, this message translates to:
  /// **'This device has been disconnected from the cloud caregiver flow'**
  String get settingsCaregiverConnectedDisconnected;

  /// No description provided for @caregiverCloudNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alert'**
  String get caregiverCloudNotificationTitle;

  /// No description provided for @caregiverAlertCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alert is ready'**
  String get caregiverAlertCardTitle;

  /// No description provided for @caregiverAlertCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{caregiverName} can be notified about {count} item(s) that need attention today.'**
  String caregiverAlertCardSubtitle(String caregiverName, int count);

  /// No description provided for @caregiverAlertReviewAction.
  ///
  /// In en, this message translates to:
  /// **'Review and copy'**
  String get caregiverAlertReviewAction;

  /// No description provided for @caregiverAlertSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alert'**
  String get caregiverAlertSheetTitle;

  /// No description provided for @caregiverAlertSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pillora prepared a ready message for {caregiverName} about {count} item(s) that need attention.'**
  String caregiverAlertSheetSubtitle(String caregiverName, int count);

  /// No description provided for @caregiverAlertReasonOverdue.
  ///
  /// In en, this message translates to:
  /// **'Late by {minutes} min'**
  String caregiverAlertReasonOverdue(int minutes);

  /// No description provided for @caregiverAlertReasonSkipped.
  ///
  /// In en, this message translates to:
  /// **'Marked as skipped'**
  String get caregiverAlertReasonSkipped;

  /// No description provided for @caregiverAlertItemSchedule.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for {time}. {reason}.'**
  String caregiverAlertItemSchedule(String time, String reason);

  /// No description provided for @caregiverAlertManualShareNote.
  ///
  /// In en, this message translates to:
  /// **'This release prepares a ready alert on your device, so you can quickly copy it and send it to your caregiver.'**
  String get caregiverAlertManualShareNote;

  /// No description provided for @caregiverAlertCopyMessage.
  ///
  /// In en, this message translates to:
  /// **'Copy alert text'**
  String get caregiverAlertCopyMessage;

  /// No description provided for @caregiverAlertCopyPhone.
  ///
  /// In en, this message translates to:
  /// **'Copy caregiver phone'**
  String get caregiverAlertCopyPhone;

  /// No description provided for @caregiverAlertNoPhone.
  ///
  /// In en, this message translates to:
  /// **'Add caregiver phone in Settings'**
  String get caregiverAlertNoPhone;

  /// No description provided for @caregiverAlertMessageCopied.
  ///
  /// In en, this message translates to:
  /// **'Caregiver alert copied'**
  String get caregiverAlertMessageCopied;

  /// No description provided for @caregiverAlertPhoneCopied.
  ///
  /// In en, this message translates to:
  /// **'Caregiver phone copied'**
  String get caregiverAlertPhoneCopied;

  /// No description provided for @caregiverAlertMessageGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {caregiverName}.'**
  String caregiverAlertMessageGreeting(String caregiverName);

  /// No description provided for @caregiverAlertMessageIntro.
  ///
  /// In en, this message translates to:
  /// **'Pillora prepared this update for {patientName}. The following doses need attention today:'**
  String caregiverAlertMessageIntro(String patientName);

  /// No description provided for @caregiverAlertMessageLineOverdue.
  ///
  /// In en, this message translates to:
  /// **'{courseName} — scheduled for {time}, now overdue by {minutes} min'**
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  );

  /// No description provided for @caregiverAlertMessageLineSkipped.
  ///
  /// In en, this message translates to:
  /// **'{courseName} — scheduled for {time}, marked as skipped'**
  String caregiverAlertMessageLineSkipped(String courseName, String time);

  /// No description provided for @caregiverAlertMessageFooter.
  ///
  /// In en, this message translates to:
  /// **'Please check in if support is needed.'**
  String get caregiverAlertMessageFooter;

  /// No description provided for @settingsSupportEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support email and launch contact details'**
  String get settingsSupportEmailSubtitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'How reminder data, photos, and reports are handled'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsExampleName.
  ///
  /// In en, this message translates to:
  /// **'For example, Alex'**
  String get settingsExampleName;

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// No description provided for @onboardingStartUsing.
  ///
  /// In en, this message translates to:
  /// **'Start using Pillora'**
  String get onboardingStartUsing;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pillora helps you stay on track'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Calm, clear, and focused.'**
  String get onboardingWelcomeTagline;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Right after opening the app, you will see what medication needs to be taken now and what comes next.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingFeatureEasyInterface.
  ///
  /// In en, this message translates to:
  /// **'Large, easy-to-read interface'**
  String get onboardingFeatureEasyInterface;

  /// No description provided for @onboardingFeatureNextDose.
  ///
  /// In en, this message translates to:
  /// **'Focus on the next dose'**
  String get onboardingFeatureNextDose;

  /// No description provided for @onboardingFeatureReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders and refill awareness'**
  String get onboardingFeatureReminders;

  /// No description provided for @onboardingTailorTitle.
  ///
  /// In en, this message translates to:
  /// **'Let us tailor the app for you'**
  String get onboardingTailorTitle;

  /// No description provided for @onboardingTailorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change these settings later in Profile.'**
  String get onboardingTailorSubtitle;

  /// No description provided for @onboardingNamePrompt.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboardingNamePrompt;

  /// No description provided for @onboardingLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get onboardingLanguageTitle;

  /// No description provided for @onboardingReadingComfort.
  ///
  /// In en, this message translates to:
  /// **'Reading comfort'**
  String get onboardingReadingComfort;

  /// No description provided for @onboardingComfortModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Comfort mode'**
  String get onboardingComfortModeTitle;

  /// No description provided for @onboardingComfortModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Larger text, bigger buttons, and less visual clutter.'**
  String get onboardingComfortModeSubtitle;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'You are all set'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadyBanner.
  ///
  /// In en, this message translates to:
  /// **'The first screen focuses on what to take and when.'**
  String get onboardingReadyBanner;

  /// No description provided for @onboardingReadyBody.
  ///
  /// In en, this message translates to:
  /// **'The home screen shows medications that need attention first, while statistics stay on a separate tab.'**
  String get onboardingReadyBody;

  /// No description provided for @onboardingReadySummaryHome.
  ///
  /// In en, this message translates to:
  /// **'A simpler home screen with less clutter'**
  String get onboardingReadySummaryHome;

  /// No description provided for @onboardingReadySummaryActions.
  ///
  /// In en, this message translates to:
  /// **'Clear actions: take, skip, add'**
  String get onboardingReadySummaryActions;

  /// No description provided for @onboardingReadySummaryComfortOn.
  ///
  /// In en, this message translates to:
  /// **'Comfort mode is already on'**
  String get onboardingReadySummaryComfortOn;

  /// No description provided for @onboardingReadySummaryComfortLater.
  ///
  /// In en, this message translates to:
  /// **'Comfort mode can be turned on later in Profile'**
  String get onboardingReadySummaryComfortLater;

  /// No description provided for @medicineStandardCourse.
  ///
  /// In en, this message translates to:
  /// **'Standard course'**
  String get medicineStandardCourse;

  /// No description provided for @medicineComplexCourse.
  ///
  /// In en, this message translates to:
  /// **'Complex course'**
  String get medicineComplexCourse;

  /// No description provided for @schedulePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule preview'**
  String get schedulePreviewTitle;

  /// No description provided for @scheduleDoseAtTime.
  ///
  /// In en, this message translates to:
  /// **'Dose at this time'**
  String get scheduleDoseAtTime;

  /// No description provided for @courseTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Course type'**
  String get courseTypeLabel;

  /// No description provided for @addSupplementScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Supplement'**
  String get addSupplementScreenTitle;

  /// No description provided for @editSupplementTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Supplement'**
  String get editSupplementTitle;

  /// No description provided for @settingsLanguageChangeLater.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in Profile'**
  String get settingsLanguageChangeLater;

  /// No description provided for @homeNothingDueTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing is due right now'**
  String get homeNothingDueTitle;

  /// No description provided for @homeUseDayWheelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the day wheel above if you want to check another day.'**
  String get homeUseDayWheelSubtitle;

  /// No description provided for @homeNoAttentionRightNow.
  ///
  /// In en, this message translates to:
  /// **'No scheduled medications or supplements need attention right now.'**
  String get homeNoAttentionRightNow;

  /// No description provided for @homeAddItemFab.
  ///
  /// In en, this message translates to:
  /// **'Add medication, supplement or measurement'**
  String get homeAddItemFab;

  /// No description provided for @homeTimelineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Medications and supplements are shown in time order.'**
  String get homeTimelineSubtitle;

  /// No description provided for @analyticsCoachGreat.
  ///
  /// In en, this message translates to:
  /// **'You are building a dependable medication routine. Keep that consistency going.'**
  String get analyticsCoachGreat;

  /// No description provided for @analyticsCoachMissed.
  ///
  /// In en, this message translates to:
  /// **'Most missed doses come from inconsistency, not volume. Make the first dose of the day your anchor.'**
  String get analyticsCoachMissed;

  /// No description provided for @analyticsCoachTiming.
  ///
  /// In en, this message translates to:
  /// **'Your routine is moving in the right direction. The next win is better timing accuracy.'**
  String get analyticsCoachTiming;

  /// No description provided for @medicineFrequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get medicineFrequencyDaily;

  /// No description provided for @medicineFrequencySpecificDays.
  ///
  /// In en, this message translates to:
  /// **'Specific days'**
  String get medicineFrequencySpecificDays;

  /// No description provided for @medicineFrequencyInterval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get medicineFrequencyInterval;

  /// No description provided for @medicineFrequencyCycle.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get medicineFrequencyCycle;

  /// No description provided for @medicineFormTablet.
  ///
  /// In en, this message translates to:
  /// **'Tablet'**
  String get medicineFormTablet;

  /// No description provided for @medicineFormCapsule.
  ///
  /// In en, this message translates to:
  /// **'Capsule'**
  String get medicineFormCapsule;

  /// No description provided for @medicineFormLiquid.
  ///
  /// In en, this message translates to:
  /// **'Liquid'**
  String get medicineFormLiquid;

  /// No description provided for @medicineFormInjection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get medicineFormInjection;

  /// No description provided for @medicineFormDrops.
  ///
  /// In en, this message translates to:
  /// **'Drops'**
  String get medicineFormDrops;

  /// No description provided for @medicineFormOintment.
  ///
  /// In en, this message translates to:
  /// **'Ointment'**
  String get medicineFormOintment;

  /// No description provided for @medicineFormSpray.
  ///
  /// In en, this message translates to:
  /// **'Spray'**
  String get medicineFormSpray;

  /// No description provided for @medicineFormInhaler.
  ///
  /// In en, this message translates to:
  /// **'Inhaler'**
  String get medicineFormInhaler;

  /// No description provided for @medicineFormPatch.
  ///
  /// In en, this message translates to:
  /// **'Patch'**
  String get medicineFormPatch;

  /// No description provided for @medicineFormSuppository.
  ///
  /// In en, this message translates to:
  /// **'Suppository'**
  String get medicineFormSuppository;

  /// No description provided for @medicineTimelineSupplementInfo.
  ///
  /// In en, this message translates to:
  /// **'This supplement appears in the shared daily timeline, while staying separate as a wellness course.'**
  String get medicineTimelineSupplementInfo;

  /// No description provided for @medicineTimelineMedicationInfo.
  ///
  /// In en, this message translates to:
  /// **'This medication appears in the shared daily timeline and stays part of your main treatment plan.'**
  String get medicineTimelineMedicationInfo;

  /// No description provided for @medicineDoseScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose schedule'**
  String get medicineDoseScheduleTitle;

  /// No description provided for @medicineDoseScheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The next day of treatment with time-by-time dosage.'**
  String get medicineDoseScheduleSubtitle;

  /// No description provided for @medicineHistoryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get medicineHistoryLoadError;

  /// No description provided for @scheduleDoseTabletsAtTime.
  ///
  /// In en, this message translates to:
  /// **'Tablets at this time'**
  String get scheduleDoseTabletsAtTime;

  /// No description provided for @scheduleDoseAmountAtTime.
  ///
  /// In en, this message translates to:
  /// **'Dose at this time'**
  String get scheduleDoseAmountAtTime;

  /// No description provided for @schedulePreviewFutureRebuilt.
  ///
  /// In en, this message translates to:
  /// **'Future doses will be rebuilt using this schedule.'**
  String get schedulePreviewFutureRebuilt;

  /// No description provided for @scheduleComplexTitle.
  ///
  /// In en, this message translates to:
  /// **'Complex schedule'**
  String get scheduleComplexTitle;

  /// No description provided for @scheduleComplexEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can edit both time and dosage for each dose.'**
  String get scheduleComplexEditSubtitle;

  /// No description provided for @courseTimelineSupplementInfo.
  ///
  /// In en, this message translates to:
  /// **'This supplement stays in its own category, but appears in the shared time-based timeline.'**
  String get courseTimelineSupplementInfo;

  /// No description provided for @courseTimelineMedicationInfo.
  ///
  /// In en, this message translates to:
  /// **'This medication stays in the medical category and appears in the shared time-based timeline.'**
  String get courseTimelineMedicationInfo;

  /// No description provided for @supplementNameHint.
  ///
  /// In en, this message translates to:
  /// **'Supplement Name (e.g. Magnesium)'**
  String get supplementNameHint;

  /// No description provided for @addDoseAction.
  ///
  /// In en, this message translates to:
  /// **'Add dose'**
  String get addDoseAction;

  /// No description provided for @addConditionSuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Condition-based suggestions'**
  String get addConditionSuggestionsTitle;

  /// No description provided for @addConditionSuggestionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a condition to see common course templates. These are only starting points and should match the real prescription.'**
  String get addConditionSuggestionsSubtitle;

  /// No description provided for @addConditionSuggestionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'There are no visible suggestions left for this condition. You can choose another condition or continue manually.'**
  String get addConditionSuggestionsEmpty;

  /// No description provided for @addFlowSupplementTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to add this supplement?'**
  String get addFlowSupplementTitle;

  /// No description provided for @addFlowMedicationTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to start?'**
  String get addFlowMedicationTitle;

  /// No description provided for @addFlowSupplementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Most people add supplements manually, but you can still use quick templates when they fit.'**
  String get addFlowSupplementSubtitle;

  /// No description provided for @addFlowMedicationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the easiest path first. You can still adjust every detail below.'**
  String get addFlowMedicationSubtitle;

  /// No description provided for @addFlowByConditionTitle.
  ///
  /// In en, this message translates to:
  /// **'By condition'**
  String get addFlowByConditionTitle;

  /// No description provided for @addFlowByConditionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See the most common templates for a condition'**
  String get addFlowByConditionSubtitle;

  /// No description provided for @addFlowQuickTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick template'**
  String get addFlowQuickTemplateTitle;

  /// No description provided for @addFlowQuickTemplateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use one of the common ready-made courses'**
  String get addFlowQuickTemplateSubtitle;

  /// No description provided for @addFlowManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get addFlowManualTitle;

  /// No description provided for @addFlowManualSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill the course yourself from the start'**
  String get addFlowManualSubtitle;

  /// No description provided for @addAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get addAppearanceTitle;

  /// No description provided for @addAppearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional step. Add a photo or customize the pill so it is easier to recognize later.'**
  String get addAppearanceSubtitle;

  /// No description provided for @addPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get addPhotoLabel;

  /// No description provided for @addQuickStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick start'**
  String get addQuickStartTitle;

  /// No description provided for @addQuickStartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use one of the most common course templates in a single tap.'**
  String get addQuickStartSubtitle;

  /// No description provided for @addSkipTemplate.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get addSkipTemplate;

  /// No description provided for @addUseTemplate.
  ///
  /// In en, this message translates to:
  /// **'Use template'**
  String get addUseTemplate;

  /// No description provided for @addRecommendedMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended health metrics'**
  String get addRecommendedMetricsTitle;

  /// No description provided for @addRecommendedMetricsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These measurements are often tracked together with this condition. You can log the first reading right now.'**
  String get addRecommendedMetricsSubtitle;

  /// No description provided for @addSupplementTimelineInfo.
  ///
  /// In en, this message translates to:
  /// **'This supplement will appear together with medications in the daily timeline.'**
  String get addSupplementTimelineInfo;

  /// No description provided for @addMedicationTimelineInfo.
  ///
  /// In en, this message translates to:
  /// **'This medication will appear in the shared daily timeline with your other courses.'**
  String get addMedicationTimelineInfo;

  /// No description provided for @conditionDiabetesTitle.
  ///
  /// In en, this message translates to:
  /// **'Diabetes'**
  String get conditionDiabetesTitle;

  /// No description provided for @conditionDiabetesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common long-term therapy patterns'**
  String get conditionDiabetesSubtitle;

  /// No description provided for @conditionHypertensionTitle.
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get conditionHypertensionTitle;

  /// No description provided for @conditionHypertensionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent blood pressure medications'**
  String get conditionHypertensionSubtitle;

  /// No description provided for @conditionCholesterolTitle.
  ///
  /// In en, this message translates to:
  /// **'High cholesterol'**
  String get conditionCholesterolTitle;

  /// No description provided for @conditionCholesterolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common evening lipid-lowering therapy'**
  String get conditionCholesterolSubtitle;

  /// No description provided for @conditionThyroidTitle.
  ///
  /// In en, this message translates to:
  /// **'Hypothyroidism'**
  String get conditionThyroidTitle;

  /// No description provided for @conditionThyroidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Typical morning thyroid replacement'**
  String get conditionThyroidSubtitle;

  /// No description provided for @conditionGerdTitle.
  ///
  /// In en, this message translates to:
  /// **'Acid reflux / GERD'**
  String get conditionGerdTitle;

  /// No description provided for @conditionGerdSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent acid symptom control'**
  String get conditionGerdSubtitle;

  /// No description provided for @conditionAsthmaTitle.
  ///
  /// In en, this message translates to:
  /// **'Asthma'**
  String get conditionAsthmaTitle;

  /// No description provided for @conditionAsthmaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common controller and rescue patterns'**
  String get conditionAsthmaSubtitle;

  /// No description provided for @conditionAllergyTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergy'**
  String get conditionAllergyTitle;

  /// No description provided for @conditionAllergySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent antihistamine symptom control'**
  String get conditionAllergySubtitle;

  /// No description provided for @conditionHeartPreventionTitle.
  ///
  /// In en, this message translates to:
  /// **'Heart disease / prevention'**
  String get conditionHeartPreventionTitle;

  /// No description provided for @conditionHeartPreventionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent long-term cardiology patterns'**
  String get conditionHeartPreventionSubtitle;

  /// No description provided for @conditionHeartFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'Heart failure'**
  String get conditionHeartFailureTitle;

  /// No description provided for @conditionHeartFailureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent fluid and blood pressure support therapy'**
  String get conditionHeartFailureSubtitle;

  /// No description provided for @conditionAtrialFibrillationTitle.
  ///
  /// In en, this message translates to:
  /// **'Atrial fibrillation'**
  String get conditionAtrialFibrillationTitle;

  /// No description provided for @conditionAtrialFibrillationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common rhythm and stroke prevention therapy'**
  String get conditionAtrialFibrillationSubtitle;

  /// No description provided for @conditionJointPainTitle.
  ///
  /// In en, this message translates to:
  /// **'Joint pain / arthritis'**
  String get conditionJointPainTitle;

  /// No description provided for @conditionJointPainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent pain and inflammation control'**
  String get conditionJointPainSubtitle;

  /// No description provided for @conditionBphTitle.
  ///
  /// In en, this message translates to:
  /// **'Prostate / BPH'**
  String get conditionBphTitle;

  /// No description provided for @conditionBphSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common urinary symptom control'**
  String get conditionBphSubtitle;

  /// No description provided for @conditionOsteoporosisTitle.
  ///
  /// In en, this message translates to:
  /// **'Osteoporosis / bone health'**
  String get conditionOsteoporosisTitle;

  /// No description provided for @conditionOsteoporosisSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent bone support therapy patterns'**
  String get conditionOsteoporosisSubtitle;

  /// No description provided for @conditionAnemiaTitle.
  ///
  /// In en, this message translates to:
  /// **'Iron deficiency / anemia'**
  String get conditionAnemiaTitle;

  /// No description provided for @conditionAnemiaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent iron replacement patterns'**
  String get conditionAnemiaSubtitle;

  /// No description provided for @suggestionMetforminName.
  ///
  /// In en, this message translates to:
  /// **'Metformin'**
  String get suggestionMetforminName;

  /// No description provided for @suggestionMetforminNote.
  ///
  /// In en, this message translates to:
  /// **'Typical oral therapy. Confirm the exact dose with the prescription.'**
  String get suggestionMetforminNote;

  /// No description provided for @suggestionInsulinName.
  ///
  /// In en, this message translates to:
  /// **'Insulin'**
  String get suggestionInsulinName;

  /// No description provided for @suggestionInsulinNote.
  ///
  /// In en, this message translates to:
  /// **'Injection template. Adjust insulin type, dose, and timing to the real regimen.'**
  String get suggestionInsulinNote;

  /// No description provided for @suggestionAmlodipineName.
  ///
  /// In en, this message translates to:
  /// **'Amlodipine'**
  String get suggestionAmlodipineName;

  /// No description provided for @suggestionAmlodipineNote.
  ///
  /// In en, this message translates to:
  /// **'Common once-daily blood pressure control.'**
  String get suggestionAmlodipineNote;

  /// No description provided for @suggestionLosartanName.
  ///
  /// In en, this message translates to:
  /// **'Losartan'**
  String get suggestionLosartanName;

  /// No description provided for @suggestionLosartanNote.
  ///
  /// In en, this message translates to:
  /// **'Often used as daily long-term therapy.'**
  String get suggestionLosartanNote;

  /// No description provided for @suggestionAtorvastatinName.
  ///
  /// In en, this message translates to:
  /// **'Atorvastatin'**
  String get suggestionAtorvastatinName;

  /// No description provided for @suggestionAtorvastatinNote.
  ///
  /// In en, this message translates to:
  /// **'A common daily statin template.'**
  String get suggestionAtorvastatinNote;

  /// No description provided for @suggestionLevothyroxineName.
  ///
  /// In en, this message translates to:
  /// **'Levothyroxine'**
  String get suggestionLevothyroxineName;

  /// No description provided for @suggestionLevothyroxineNote.
  ///
  /// In en, this message translates to:
  /// **'Usually taken in the morning before food.'**
  String get suggestionLevothyroxineNote;

  /// No description provided for @suggestionOmeprazoleName.
  ///
  /// In en, this message translates to:
  /// **'Omeprazole'**
  String get suggestionOmeprazoleName;

  /// No description provided for @suggestionOmeprazoleNote.
  ///
  /// In en, this message translates to:
  /// **'Often taken in the morning before food.'**
  String get suggestionOmeprazoleNote;

  /// No description provided for @suggestionFamotidineName.
  ///
  /// In en, this message translates to:
  /// **'Famotidine'**
  String get suggestionFamotidineName;

  /// No description provided for @suggestionFamotidineNote.
  ///
  /// In en, this message translates to:
  /// **'Used for acid symptoms, often in the evening.'**
  String get suggestionFamotidineNote;

  /// No description provided for @suggestionBudesonideFormoterolName.
  ///
  /// In en, this message translates to:
  /// **'Budesonide/Formoterol'**
  String get suggestionBudesonideFormoterolName;

  /// No description provided for @suggestionBudesonideFormoterolNote.
  ///
  /// In en, this message translates to:
  /// **'Common maintenance inhaler template.'**
  String get suggestionBudesonideFormoterolNote;

  /// No description provided for @suggestionAlbuterolName.
  ///
  /// In en, this message translates to:
  /// **'Albuterol'**
  String get suggestionAlbuterolName;

  /// No description provided for @suggestionAlbuterolNote.
  ///
  /// In en, this message translates to:
  /// **'Common rescue inhaler kept as needed.'**
  String get suggestionAlbuterolNote;

  /// No description provided for @suggestionCetirizineName.
  ///
  /// In en, this message translates to:
  /// **'Cetirizine'**
  String get suggestionCetirizineName;

  /// No description provided for @suggestionCetirizineNote.
  ///
  /// In en, this message translates to:
  /// **'Often used once daily for allergy symptoms.'**
  String get suggestionCetirizineNote;

  /// No description provided for @suggestionLoratadineName.
  ///
  /// In en, this message translates to:
  /// **'Loratadine'**
  String get suggestionLoratadineName;

  /// No description provided for @suggestionLoratadineNote.
  ///
  /// In en, this message translates to:
  /// **'Common daytime antihistamine template.'**
  String get suggestionLoratadineNote;

  /// No description provided for @suggestionAspirinName.
  ///
  /// In en, this message translates to:
  /// **'Aspirin'**
  String get suggestionAspirinName;

  /// No description provided for @suggestionAspirinNote.
  ///
  /// In en, this message translates to:
  /// **'Common low-dose cardiovascular prevention template.'**
  String get suggestionAspirinNote;

  /// No description provided for @suggestionClopidogrelName.
  ///
  /// In en, this message translates to:
  /// **'Clopidogrel'**
  String get suggestionClopidogrelName;

  /// No description provided for @suggestionClopidogrelNote.
  ///
  /// In en, this message translates to:
  /// **'Often used as once-daily antiplatelet therapy.'**
  String get suggestionClopidogrelNote;

  /// No description provided for @suggestionFurosemideName.
  ///
  /// In en, this message translates to:
  /// **'Furosemide'**
  String get suggestionFurosemideName;

  /// No description provided for @suggestionFurosemideNote.
  ///
  /// In en, this message translates to:
  /// **'Diuretic template often taken earlier in the day.'**
  String get suggestionFurosemideNote;

  /// No description provided for @suggestionSpironolactoneName.
  ///
  /// In en, this message translates to:
  /// **'Spironolactone'**
  String get suggestionSpironolactoneName;

  /// No description provided for @suggestionSpironolactoneNote.
  ///
  /// In en, this message translates to:
  /// **'Common once-daily support therapy pattern.'**
  String get suggestionSpironolactoneNote;

  /// No description provided for @suggestionApixabanName.
  ///
  /// In en, this message translates to:
  /// **'Apixaban'**
  String get suggestionApixabanName;

  /// No description provided for @suggestionApixabanNote.
  ///
  /// In en, this message translates to:
  /// **'Common twice-daily anticoagulant pattern.'**
  String get suggestionApixabanNote;

  /// No description provided for @suggestionMetoprololName.
  ///
  /// In en, this message translates to:
  /// **'Metoprolol'**
  String get suggestionMetoprololName;

  /// No description provided for @suggestionMetoprololNote.
  ///
  /// In en, this message translates to:
  /// **'Often used for heart rate control.'**
  String get suggestionMetoprololNote;

  /// No description provided for @suggestionIbuprofenName.
  ///
  /// In en, this message translates to:
  /// **'Ibuprofen'**
  String get suggestionIbuprofenName;

  /// No description provided for @suggestionIbuprofenNote.
  ///
  /// In en, this message translates to:
  /// **'Common short-term pain relief template.'**
  String get suggestionIbuprofenNote;

  /// No description provided for @suggestionDiclofenacGelName.
  ///
  /// In en, this message translates to:
  /// **'Diclofenac gel'**
  String get suggestionDiclofenacGelName;

  /// No description provided for @suggestionDiclofenacGelNote.
  ///
  /// In en, this message translates to:
  /// **'Topical anti-inflammatory symptom relief template.'**
  String get suggestionDiclofenacGelNote;

  /// No description provided for @suggestionTamsulosinName.
  ///
  /// In en, this message translates to:
  /// **'Tamsulosin'**
  String get suggestionTamsulosinName;

  /// No description provided for @suggestionTamsulosinNote.
  ///
  /// In en, this message translates to:
  /// **'Often taken in the evening after food.'**
  String get suggestionTamsulosinNote;

  /// No description provided for @suggestionFinasterideName.
  ///
  /// In en, this message translates to:
  /// **'Finasteride'**
  String get suggestionFinasterideName;

  /// No description provided for @suggestionFinasterideNote.
  ///
  /// In en, this message translates to:
  /// **'Common once-daily long-term support.'**
  String get suggestionFinasterideNote;

  /// No description provided for @suggestionAlendronateName.
  ///
  /// In en, this message translates to:
  /// **'Alendronate'**
  String get suggestionAlendronateName;

  /// No description provided for @suggestionAlendronateNote.
  ///
  /// In en, this message translates to:
  /// **'Typical weekly morning template before food.'**
  String get suggestionAlendronateNote;

  /// No description provided for @suggestionCalciumVitaminDName.
  ///
  /// In en, this message translates to:
  /// **'Calcium + Vitamin D'**
  String get suggestionCalciumVitaminDName;

  /// No description provided for @suggestionCalciumVitaminDNote.
  ///
  /// In en, this message translates to:
  /// **'Common bone support supplement routine.'**
  String get suggestionCalciumVitaminDNote;

  /// No description provided for @suggestionFerrousSulfateName.
  ///
  /// In en, this message translates to:
  /// **'Ferrous sulfate'**
  String get suggestionFerrousSulfateName;

  /// No description provided for @suggestionFerrousSulfateNote.
  ///
  /// In en, this message translates to:
  /// **'Common oral iron replacement template.'**
  String get suggestionFerrousSulfateNote;

  /// No description provided for @suggestionFolicAcidName.
  ///
  /// In en, this message translates to:
  /// **'Folic acid'**
  String get suggestionFolicAcidName;

  /// No description provided for @suggestionFolicAcidNote.
  ///
  /// In en, this message translates to:
  /// **'Common supportive vitamin template.'**
  String get suggestionFolicAcidNote;

  /// No description provided for @pdfDoctorReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor report'**
  String get pdfDoctorReportTitle;

  /// No description provided for @pdfSupplementCourseSummary.
  ///
  /// In en, this message translates to:
  /// **'Supplement course summary'**
  String get pdfSupplementCourseSummary;

  /// No description provided for @pdfMedicationCourseSummary.
  ///
  /// In en, this message translates to:
  /// **'Medication course summary'**
  String get pdfMedicationCourseSummary;

  /// No description provided for @pdfCourseProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Course profile'**
  String get pdfCourseProfileTitle;

  /// No description provided for @pdfScheduleSnapshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule snapshot'**
  String get pdfScheduleSnapshotTitle;

  /// No description provided for @pdfScheduleSnapshotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A representative day of the course with time and dosage.'**
  String get pdfScheduleSnapshotSubtitle;

  /// No description provided for @pdfAdministrationHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Administration history'**
  String get pdfAdministrationHistoryTitle;

  /// No description provided for @pdfAdministrationHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shows what was taken and how it matched the planned schedule.'**
  String get pdfAdministrationHistorySubtitle;

  /// No description provided for @pdfAdherenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Adherence'**
  String get pdfAdherenceLabel;

  /// No description provided for @pdfSnoozedLabel.
  ///
  /// In en, this message translates to:
  /// **'Snoozed'**
  String get pdfSnoozedLabel;

  /// No description provided for @pdfClinicalSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinical summary'**
  String get pdfClinicalSummaryTitle;

  /// No description provided for @pdfPatientLabel.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get pdfPatientLabel;

  /// No description provided for @pdfCaregiverLabel.
  ///
  /// In en, this message translates to:
  /// **'Caregiver'**
  String get pdfCaregiverLabel;

  /// No description provided for @pdfReportPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Report period'**
  String get pdfReportPeriodLabel;

  /// No description provided for @pdfOnTimeRateLabel.
  ///
  /// In en, this message translates to:
  /// **'On-time rate'**
  String get pdfOnTimeRateLabel;

  /// No description provided for @pdfAverageDelayLabel.
  ///
  /// In en, this message translates to:
  /// **'Average delay'**
  String get pdfAverageDelayLabel;

  /// No description provided for @pdfUpcomingDosesLabel.
  ///
  /// In en, this message translates to:
  /// **'Upcoming doses'**
  String get pdfUpcomingDosesLabel;

  /// No description provided for @pdfStockLeftLabel.
  ///
  /// In en, this message translates to:
  /// **'Stock left'**
  String get pdfStockLeftLabel;

  /// No description provided for @pdfNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get pdfNameLabel;

  /// No description provided for @pdfCourseTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Course type'**
  String get pdfCourseTypeLabel;

  /// No description provided for @pdfDosageLabel.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get pdfDosageLabel;

  /// No description provided for @pdfFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get pdfFrequencyLabel;

  /// No description provided for @pdfStartedLabel.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get pdfStartedLabel;

  /// No description provided for @pdfInstructionLabel.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get pdfInstructionLabel;

  /// No description provided for @pdfNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get pdfNotesLabel;

  /// No description provided for @pdfTimelineEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recorded administration history yet.'**
  String get pdfTimelineEmpty;

  /// No description provided for @pdfTimelineTruncated.
  ///
  /// In en, this message translates to:
  /// **'This PDF shows the latest {visible} entries out of {total}.'**
  String pdfTimelineTruncated(int visible, int total);

  /// No description provided for @pdfTableScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get pdfTableScheduled;

  /// No description provided for @pdfTableActual.
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get pdfTableActual;

  /// No description provided for @pdfTableDose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get pdfTableDose;

  /// No description provided for @pdfTableStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get pdfTableStatus;

  /// No description provided for @pdfTableDelay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get pdfTableDelay;

  /// No description provided for @pdfOnTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get pdfOnTime;

  /// No description provided for @pdfMinuteShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get pdfMinuteShort;

  /// No description provided for @pdfNoFoodRestriction.
  ///
  /// In en, this message translates to:
  /// **'No food restriction'**
  String get pdfNoFoodRestriction;
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
