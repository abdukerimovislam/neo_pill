// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Heutiger Zeitplan';

  @override
  String get architectureReady => 'Architektur steht. Alle Systeme normal.';

  @override
  String get nextCreateHome => 'Weiter: Startbildschirm';

  @override
  String get statusTaken => 'Eingenommen';

  @override
  String get statusSkipped => 'Übersprungen';

  @override
  String get statusSnoozed => 'Verzögert (10 Min)';

  @override
  String get statusPending => 'Ausstehend';

  @override
  String get emptySchedule => 'Keine Medikamente für heute';

  @override
  String get takeAction => 'Einnehmen';

  @override
  String get skipAction => 'Überspringen';

  @override
  String get dosageUnitMg => 'mg';

  @override
  String get dosageUnitMl => 'ml';

  @override
  String get dosageUnitDrops => 'Tropfen';

  @override
  String get dosageUnitPcs => 'Stk.';

  @override
  String get dosageUnitG => 'g';

  @override
  String get dosageUnitMcg => 'mcg';

  @override
  String get dosageUnitIu => 'IE';

  @override
  String get addMedicationTitle => 'Medikament hinzufügen';

  @override
  String get medicineNameHint => 'Name (z.B. Vitamin D)';

  @override
  String get dosageHint => 'Dosis (z.B. 500)';

  @override
  String get saveAction => 'Speichern & Zeitplan erstellen';

  @override
  String get errorEmptyFields => 'Bitte alle Felder ausfüllen';

  @override
  String get profileTitle => 'Profil';

  @override
  String notificationTitle(String name) {
    return 'Zeit für $name!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Dosis: $dosage. Bitte nicht vergessen.';
  }

  @override
  String get analyticsTitle => 'Analytik';

  @override
  String get adherenceRate => 'Einnahmetreue';

  @override
  String get dosesTaken => 'Eingenommen';

  @override
  String get dosesMissed => 'Verpasst';

  @override
  String get activeCourses => 'Aktive Pläne';

  @override
  String get tabHome => 'Zeitplan';

  @override
  String get tabAnalytics => 'Statistik';

  @override
  String get keepItUp => 'Gut gemacht! Weiter so.';

  @override
  String get needsAttention =>
      'Achtung nötig. Versuche Dosen nicht zu verpassen.';

  @override
  String get medicineDetails => 'Details';

  @override
  String get pillsRemaining => 'Verbleibender Vorrat';

  @override
  String get deleteCourse => 'Plan löschen';

  @override
  String get deleteConfirmation =>
      'Bist du sicher, dass du dies löschen möchtest?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" hinzugefügt.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" aktualisiert.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" gelöscht.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get timeOfDay => 'Tageszeit';

  @override
  String get courseDuration => 'Dauer (Tage)';

  @override
  String get pillsInPackage => 'Menge in Verpackung';

  @override
  String get addTime => 'Zeit hinzufügen';

  @override
  String timeLabel(int number) {
    return 'Zeit $number';
  }

  @override
  String get foodBefore => 'Vor dem Essen';

  @override
  String get foodWith => 'Zum Essen';

  @override
  String get foodAfter => 'Nach dem Essen';

  @override
  String get foodNoMatter => 'Jederzeit';

  @override
  String get unknownMedicine => 'Unbekanntes Medikament';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseFromGallery => 'Aus Galerie';

  @override
  String get medicineInfo => 'Informationen';

  @override
  String get formTitle => 'Form';

  @override
  String get scheduleTitle => 'Zeitplan';

  @override
  String get everyXDays => 'Alle X Tage';

  @override
  String get maxDosesPerDay => 'Max. Dosen/Tag (Sicherheit)';

  @override
  String get overdoseWarning => 'Um Überdosierung zu vermeiden.';

  @override
  String get foodInstructionTitle => 'Nahrungsanweisung';

  @override
  String doseNumber(int number) {
    return 'Dosis $number';
  }

  @override
  String get coursePaused => 'Pausiert';

  @override
  String get resumeCourse => 'Fortsetzen';

  @override
  String get pauseCourse => 'Pausieren';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" pausiert.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" fortgesetzt.';
  }

  @override
  String get doctorReport => 'Arztbericht';

  @override
  String get generatingReport => 'Erstelle Bericht...';

  @override
  String errorGeneratingReport(String error) {
    return 'Fehler: $error';
  }

  @override
  String get editCourse => 'Bearbeiten';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get editMedicineInfo => 'Info bearbeiten';

  @override
  String lowStockTitle(String name) {
    return 'Wenig Vorrat: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Nur noch $count $unit. Bald auffüllen!';
  }

  @override
  String get lowStockBadge => 'Wenig Vorrat';

  @override
  String get snoozeAction => 'Schlummern (30m)';

  @override
  String get undoAction => 'Rückgängig';

  @override
  String get sosPanelTitle => 'Nach Bedarf (SOS)';

  @override
  String get takeNowAction => 'EINNEHMEN';

  @override
  String get limitReachedAlert => 'Tageslimit erreicht!';

  @override
  String get addSosMedicine => 'SOS hinzufügen';

  @override
  String get outOfStockBadge => 'Leer';

  @override
  String get recentHistory => 'Verlauf';

  @override
  String get noHistoryYet => 'Kein Verlauf';

  @override
  String get lifetimeCourse => 'Kontinuierlich (Dauerhaft)';

  @override
  String get doneAction => 'Fertig';

  @override
  String get addMeasurement => 'Daten protokollieren';

  @override
  String get bloodPressure => 'Blutdruck';

  @override
  String get heartRate => 'Herzfrequenz';

  @override
  String get weight => 'Gewicht';

  @override
  String get bloodSugar => 'Blutzucker';

  @override
  String get systolic => 'Sys';

  @override
  String get diastolic => 'Dia';

  @override
  String get taperingDosing => 'Dynamische Dosis';

  @override
  String stepNumber(int number) {
    return 'Schritt $number';
  }

  @override
  String get addStep => 'Schritt hinzufügen';

  @override
  String get doseForStep => 'Dosis für diesen Schritt';

  @override
  String get whatWouldYouLikeToDo => 'Was möchtest du tun?';

  @override
  String get scheduleNewTreatmentCourse => 'Neuen Plan erstellen';

  @override
  String get logHealthMetricsSubtitle => 'Blutdruck, Puls, Gewicht';

  @override
  String get priorityAction => 'Wichtige Aktion';

  @override
  String get skipDoseAction => 'Überspringen';

  @override
  String errorPrefix(String error) {
    return 'Fehler: $error';
  }

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodAfternoon => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get dailyProgress => 'Täglicher Fortschritt';

  @override
  String get sosEmergency => 'SOS Notfall';

  @override
  String get adherenceSubtitle => 'Deine Beständigkeit';

  @override
  String get healthCorrelationTitle => 'Gesundheitskorrelation';

  @override
  String get healthCorrelationSubtitle =>
      'Vergleiche Einnahmen mit deinen Metriken';

  @override
  String get last7Days => 'Letzte 7 Tage';

  @override
  String get pillsTaken => 'Pillen eingenommen';

  @override
  String get overallAdherence => 'Gesamttreue';

  @override
  String get statusGood => 'Gut';

  @override
  String get statusNeedsAttention => 'Achtung nötig';

  @override
  String get statTaken => 'Eingenommen';

  @override
  String get statSkipped => 'Verpasst';

  @override
  String get statTotal => 'Gesamt';

  @override
  String get completedDosesSubtitle => 'Abgeschlossene';

  @override
  String get missedDosesSubtitle => 'Verpasste';

  @override
  String get noDataYet => 'Noch keine Daten';

  @override
  String get noDataDescription => 'Verfolge Messungen für Erkenntnisse.';

  @override
  String get failedToLoadAdherence => 'Fehler';

  @override
  String get failedToLoadChart => 'Fehler';

  @override
  String avgAdherence(String value) {
    return 'Ø Treue $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Ø $metricName $value';
  }

  @override
  String get addAction => 'Hinzufügen';

  @override
  String get frequency => 'Häufigkeit';

  @override
  String get form => 'Form';

  @override
  String get inventory => 'Vorrat';

  @override
  String get lowStockAlert => 'WENIG VORRAT';

  @override
  String get asNeededFrequency => 'NACH BEDARF';

  @override
  String get taperingFrequency => 'DYNAMISCH';

  @override
  String get customizePill => 'Anpassen';

  @override
  String get customizePillTitle => 'Pille anpassen';

  @override
  String get shape => 'Form';

  @override
  String get color => 'Farbe';

  @override
  String get overview => 'Übersicht';

  @override
  String get scheduleAndRules => 'Zeitplan & Regeln';

  @override
  String get duration => 'Dauer';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get daysSuffix => 'Tage';

  @override
  String get pcsSuffix => 'Stk.';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Einstellungen & Profil';

  @override
  String get personalInfo => 'Persönliche Daten';

  @override
  String get appPreferences => 'App-Einstellungen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get language => 'Sprache';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get advancedFeatures => 'Erweiterte Funktionen';

  @override
  String get caregivers => 'Betreuer & Freunde';

  @override
  String get drugInteractions => 'Wechselwirkungen';

  @override
  String get comingSoon => 'BALD';

  @override
  String get supportAndAbout => 'Support & Info';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get logout => 'Abmelden';

  @override
  String get tabSettings => 'Profil';

  @override
  String get defaultUserName => 'Freund';

  @override
  String get courseKindMedication => 'Medikament';

  @override
  String get courseKindSupplement => 'Ergänzungsmittel';

  @override
  String get courseFilterAll => 'Alle';

  @override
  String get courseFilterMedications => 'Medikamente';

  @override
  String get courseFilterSupplements => 'Ergänzungen';

  @override
  String get homeTakeMedicationNow => 'Jetzt einnehmen';

  @override
  String get homeTakeSupplementNow => 'Jetzt einnehmen';

  @override
  String get homeEmptyAllTitle => 'Noch keine Medikamente';

  @override
  String get homeEmptyMedicationsTitle => 'Noch keine Medikamente';

  @override
  String get homeEmptySupplementsTitle => 'Noch keine Ergänzungen';

  @override
  String get homeEmptyAllSubtitle => 'Nichts zu tun. Entspanne dich.';

  @override
  String get homeEmptyMedicationsSubtitle => 'Keine Medikamente jetzt.';

  @override
  String get homeEmptySupplementsSubtitle => 'Keine Ergänzungen jetzt.';

  @override
  String get homeAddSupplementTitle => 'Ergänzung hinzufügen';

  @override
  String get homeAddSupplementSubtitle => 'Vitamine planen';

  @override
  String get homeForThisDay => 'Für diesen Tag';

  @override
  String get homeMorningRoutine => 'Morgenroutine';

  @override
  String get homeAfternoonRoutine => 'Nachmittagsroutine';

  @override
  String get homeEveningRoutine => 'Abendroutine';

  @override
  String get homeNightRoutine => 'Nachtroutine';

  @override
  String get homeRoutineSupplementsOnly => 'Ergänzungen';

  @override
  String get homeRoutineMedicationsOnly => 'Medikamente';

  @override
  String get homeRoutineMixed => 'Gemischt';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Elemente',
      one: '1 Element',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Achtung';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Elemente benötigen Aufmerksamkeit.',
      one: '1 Element benötigt Aufmerksamkeit.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'Als Nächstes';

  @override
  String get homeRefillReminderTitle => 'Erinnerung ans Auffüllen';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pläne auffüllen.',
      one: '1 Plan auffüllen.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Alles ruhig';

  @override
  String get homeEverythingCalmSubtitle => 'Keine Aufgaben im Moment.';

  @override
  String get homeNoUpcomingItem => 'Nichts geplant.';

  @override
  String homeScheduledFor(String time) {
    return 'Geplant für $time';
  }

  @override
  String get calendarToday => 'Heute';

  @override
  String get calendarSelectedDay => 'Ausgewählter Tag';

  @override
  String get calendarShowingToday => 'Zeige heutigen Plan';

  @override
  String get calendarBrowseNearbyDays => 'Drehe das Rad für andere Tage';

  @override
  String get calendarPreviewAnotherDay => 'Vorschau eines anderen Tages.';

  @override
  String get calendarDayWheelSemantics => 'Tagesrad';

  @override
  String get analyticsCourseMix => 'Kursmix';

  @override
  String get analyticsCourseMixSubtitle => 'Medikamente und Ergänzungen';

  @override
  String get analyticsCurrentRoutine => 'Aktuelle Routine';

  @override
  String get analyticsCurrentRoutineSubtitle => 'Tage in Folge ohne Aussetzer';

  @override
  String get analyticsTimingAccuracy => 'Pünktlichkeit';

  @override
  String get analyticsTimingAccuracySubtitle => 'Innerhalb 30 Min';

  @override
  String get analyticsBestRoutine => 'Beste Routine';

  @override
  String get analyticsBestRoutineSubtitle => 'Beste der letzten 90 Tage';

  @override
  String get analyticsRefillRisk => 'Nachfüllrisiko';

  @override
  String get analyticsRefillRiskSubtitle => 'Bald leer';

  @override
  String get analyticsAverageDelay => 'Durchschn. Verzögerung';

  @override
  String get analyticsMinutesShort => 'Min';

  @override
  String get analyticsCoachNote => 'Coach Notiz';

  @override
  String get analyticsMissedDoses => 'Verpasste Dosen';

  @override
  String analyticsActiveShort(int count) {
    return '$count aktiv';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Genommen: $taken  Verpasst: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Support';

  @override
  String get settingsContactSupportBody => 'Wir können helfen.';

  @override
  String get settingsSupportEmailCopied => 'Email kopiert';

  @override
  String get settingsCopySupportEmail => 'Email kopieren';

  @override
  String get settingsPrivacyTitle => 'Datenschutz';

  @override
  String get settingsPrivacyBodyPrimary => 'Daten bleiben auf dem Gerät.';

  @override
  String get settingsPrivacyBodySecondary => 'PDFs nur bei Bedarf.';

  @override
  String get settingsPrivacyLaunchNote => 'Veröffentliche deine Richtlinie.';

  @override
  String get settingsLanguageEnglish => 'Englisch';

  @override
  String get settingsLanguageRussian => 'Russisch';

  @override
  String get settingsYourProfilePreferences => 'Profil und Einstellungen';

  @override
  String get settingsComfortModeTitle => 'Komfortmodus';

  @override
  String get settingsComfortModeSubtitle => 'Größerer Text';

  @override
  String get settingsNotificationsEnabled => 'Erinnerungen an';

  @override
  String get settingsOn => 'An';

  @override
  String get settingsSupportAndSafety => 'Support & Sicherheit';

  @override
  String get settingsShowOnboardingAgain => 'Guide anzeigen';

  @override
  String get settingsShowOnboardingAgainSubtitle => 'Öffne das Tutorial';

  @override
  String get settingsFeaturePolishing => 'Wird bald veröffentlicht';

  @override
  String get settingsCaregiverTitle => 'Teilen mit Betreuer';

  @override
  String get settingsCaregiverDescription =>
      'Füge eine Vertrauensperson hinzu.';

  @override
  String get settingsCaregiverName => 'Name';

  @override
  String get settingsCaregiverRelation => 'Beziehung';

  @override
  String get settingsCaregiverPhone => 'Telefonnummer';

  @override
  String get settingsCaregiverShareReports => 'In Berichte aufnehmen';

  @override
  String get settingsCaregiverShareReportsSubtitle => 'Kontakt im PDF.';

  @override
  String get settingsCaregiverSaved => 'Gespeichert';

  @override
  String get settingsCaregiverRemoved => 'Entfernt';

  @override
  String get settingsCaregiverRemove => 'Betreuer entfernen';

  @override
  String get settingsCaregiverEmpty => 'Füge jemanden hinzu';

  @override
  String get settingsCaregiverAlertsTitle => 'Betreuer-Alarme';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Wenn eine Dosis verspätet ist.';

  @override
  String get settingsCaregiverAlertsEmpty => 'Betreuer fehlt';

  @override
  String get settingsCaregiverAlertsDisabled => 'Alarme deaktiviert';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'Alarm nach $minutes Min';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Alarme vorbereiten';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Nachricht wird vorbereitet.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Toleranzzeit';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Warte $minutes Min.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes min';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Verspätete Dosen';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Bei ausstehenden Dosen.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Übersprungene Dosen';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Wenn explizit übersprungen.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle =>
      'Ergänzungen einschließen';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle => 'Auch für Vitamine.';

  @override
  String get settingsCaregiverAlertsSaved => 'Gespeichert';

  @override
  String get settingsCaregiverConnectedTitle => 'Cloud-Verbindung';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Verbindung für Benachrichtigungen.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Code bereit. Postausgang leer.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count Alarm(e) im Ausgang.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Verbindungscode';

  @override
  String get settingsCaregiverConnectedCodeSubtitle => 'Teile diesen Code.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Postausgang';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Zuletzt: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Code kopieren';

  @override
  String get settingsCaregiverConnectedCodeCopied => 'Kopiert';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Leeren';

  @override
  String get settingsCaregiverConnectedOutboxCleared => 'Geleert';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Cloud-Modus';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Gerät agiert als Patient.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'Als Betreuer für $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone => 'Keine Verbindung.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Verbundener Code: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle => 'Posteingang';

  @override
  String get settingsCaregiverConnectedInboxEmpty => 'Keine Cloud-Alarme.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice => 'Als Patient nutzen';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Als Patient verbunden';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Als Betreuer verbinden';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Beitreten';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Code des Patienten eingeben.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Verbinden';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Als Betreuer verbunden';

  @override
  String get settingsCaregiverConnectedJoinFailed => 'Code nicht gefunden';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Trennen';

  @override
  String get settingsCaregiverConnectedDisconnected => 'Getrennt.';

  @override
  String get caregiverCloudNotificationTitle => 'Betreuer-Alarm';

  @override
  String get caregiverAlertCardTitle => 'Alarm bereit';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName kann über $count Element(e) informiert werden.';
  }

  @override
  String get caregiverAlertReviewAction => 'Überprüfen & Kopieren';

  @override
  String get caregiverAlertSheetTitle => 'Betreuer-Alarm';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Nachricht für $caregiverName bereit ($count Element(e)).';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'Spät um $minutes Min';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Übersprungen';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Geplant für $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote => 'Kopiere diesen Text.';

  @override
  String get caregiverAlertCopyMessage => 'Nachricht kopieren';

  @override
  String get caregiverAlertCopyPhone => 'Telefon kopieren';

  @override
  String get caregiverAlertNoPhone => 'Nummer fehlt';

  @override
  String get caregiverAlertMessageCopied => 'Nachricht kopiert';

  @override
  String get caregiverAlertPhoneCopied => 'Telefon kopiert';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Hallo, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Update für $patientName:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — $time, spät $minutes min';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — $time, übersprungen';
  }

  @override
  String get caregiverAlertMessageFooter =>
      'Bitte prüfen, ob Hilfe benötigt wird.';

  @override
  String get settingsSupportEmailSubtitle => 'Support E-Mail';

  @override
  String get settingsPrivacySubtitle => 'Umgang mit Daten';

  @override
  String get settingsExampleName => 'Z.B. Alex';

  @override
  String get settingsSave => 'Speichern';

  @override
  String get onboardingStartUsing => 'Pillora starten';

  @override
  String get onboardingContinue => 'Weiter';

  @override
  String get onboardingBack => 'Zurück';

  @override
  String get onboardingWelcomeTitle => 'Bleib auf Kurs';

  @override
  String get onboardingWelcomeTagline => 'Ruhig, klar und fokussiert.';

  @override
  String get onboardingWelcomeBody => 'Du siehst sofort, was wann zu tun ist.';

  @override
  String get onboardingFeatureEasyInterface => 'Große Benutzeroberfläche';

  @override
  String get onboardingFeatureNextDose => 'Fokus auf nächste Dosis';

  @override
  String get onboardingFeatureReminders => 'Erinnerungen & Vorrat';

  @override
  String get onboardingTailorTitle => 'Passen wir die App an';

  @override
  String get onboardingTailorSubtitle => 'Kannst du später im Profil ändern.';

  @override
  String get onboardingNamePrompt => 'Wie sollen wir dich nennen?';

  @override
  String get onboardingLanguageTitle => 'Sprache';

  @override
  String get onboardingReadingComfort => 'Lesekomfort';

  @override
  String get onboardingComfortModeTitle => 'Komfortmodus';

  @override
  String get onboardingComfortModeSubtitle => 'Größerer Text.';

  @override
  String get onboardingReadyTitle => 'Alles bereit';

  @override
  String get onboardingReadyBanner => 'Fokus auf die Einnahme.';

  @override
  String get onboardingReadyBody => 'Statistiken sind separat.';

  @override
  String get onboardingReadySummaryHome => 'Ein einfacher Startbildschirm';

  @override
  String get onboardingReadySummaryActions => 'Klare Aktionen';

  @override
  String get onboardingReadySummaryComfortOn => 'Komfortmodus ist an';

  @override
  String get onboardingReadySummaryComfortLater => 'Komfortmodus verfügbar';

  @override
  String get medicineStandardCourse => 'Standardkurs';

  @override
  String get medicineComplexCourse => 'Komplexer Kurs';

  @override
  String get schedulePreviewTitle => 'Vorschau';

  @override
  String get scheduleDoseAtTime => 'Dosis zu dieser Zeit';

  @override
  String get courseTypeLabel => 'Kurs-Typ';

  @override
  String get addSupplementScreenTitle => 'Ergänzungsmittel hinzufügen';

  @override
  String get editSupplementTitle => 'Bearbeiten';

  @override
  String get settingsLanguageChangeLater => 'Später änderbar';

  @override
  String get homeNothingDueTitle => 'Im Moment nichts fällig';

  @override
  String get homeUseDayWheelSubtitle => 'Nutze das Rad für andere Tage.';

  @override
  String get homeNoAttentionRightNow => 'Keine Aufgaben im Moment.';

  @override
  String get homeAddItemFab => 'Hinzufügen';

  @override
  String get homeTimelineSubtitle => 'Chronologisch geordnet.';

  @override
  String get analyticsCoachGreat => 'Tolle Routine. Weiter so!';

  @override
  String get analyticsCoachMissed => 'Vergiss die erste Dosis nicht.';

  @override
  String get analyticsCoachTiming => 'Verbessere die Pünktlichkeit.';

  @override
  String get medicineFrequencyDaily => 'Täglich';

  @override
  String get medicineFrequencySpecificDays => 'Bestimmte Tage';

  @override
  String get medicineFrequencyInterval => 'Intervall';

  @override
  String get medicineFrequencyCycle => 'Zyklus';

  @override
  String get medicineFormTablet => 'Tablette';

  @override
  String get medicineFormCapsule => 'Kapsel';

  @override
  String get medicineFormLiquid => 'Flüssigkeit';

  @override
  String get medicineFormInjection => 'Injektion';

  @override
  String get medicineFormDrops => 'Tropfen';

  @override
  String get medicineFormOintment => 'Salbe';

  @override
  String get medicineFormSpray => 'Spray';

  @override
  String get medicineFormInhaler => 'Inhalator';

  @override
  String get medicineFormPatch => 'Pflaster';

  @override
  String get medicineFormSuppository => 'Zäpfchen';

  @override
  String get medicineTimelineSupplementInfo => 'In der Zeitleiste sichtbar.';

  @override
  String get medicineTimelineMedicationInfo => 'Teil deines Plans.';

  @override
  String get medicineDoseScheduleTitle => 'Zeitplan';

  @override
  String get medicineDoseScheduleSubtitle => 'Dosis für jeden Tag.';

  @override
  String get medicineHistoryLoadError => 'Fehler';

  @override
  String get scheduleDoseTabletsAtTime => 'Tabletten zu dieser Zeit';

  @override
  String get scheduleDoseAmountAtTime => 'Dosis zu dieser Zeit';

  @override
  String get schedulePreviewFutureRebuilt => 'Zukünftige Dosen nutzen dies.';

  @override
  String get scheduleComplexTitle => 'Komplexer Zeitplan';

  @override
  String get scheduleComplexEditSubtitle => 'Dosis und Zeit editieren.';

  @override
  String get courseTimelineSupplementInfo => 'In Wellness-Kategorie.';

  @override
  String get courseTimelineMedicationInfo => 'In Medizin-Kategorie.';

  @override
  String get supplementNameHint => 'Name (z.B. Magnesium)';

  @override
  String get addDoseAction => 'Dosis hinzufügen';

  @override
  String get addConditionSuggestionsTitle => 'Vorschläge nach Krankheit';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Allgemeine Muster. Rezept prüfen.';

  @override
  String get addConditionSuggestionsEmpty => 'Keine weiteren Vorschläge.';

  @override
  String get addFlowSupplementTitle => 'Wie hinzufügen?';

  @override
  String get addFlowMedicationTitle => 'Wie beginnen?';

  @override
  String get addFlowSupplementSubtitle => 'Vorlagen sind verfügbar.';

  @override
  String get addFlowMedicationSubtitle => 'Wähle den einfachsten Weg.';

  @override
  String get addFlowByConditionTitle => 'Nach Krankheit';

  @override
  String get addFlowByConditionSubtitle => 'Muster für Krankheiten';

  @override
  String get addFlowQuickTemplateTitle => 'Schnellvorlage';

  @override
  String get addFlowQuickTemplateSubtitle => 'Einen fertigen Plan nutzen';

  @override
  String get addFlowManualTitle => 'Manuell';

  @override
  String get addFlowManualSubtitle => 'Alles selbst ausfüllen';

  @override
  String get addAppearanceTitle => 'Erscheinungsbild';

  @override
  String get addAppearanceSubtitle => 'Foto hinzufügen oder anpassen.';

  @override
  String get addPhotoLabel => 'Foto';

  @override
  String get addQuickStartTitle => 'Schnellstart';

  @override
  String get addQuickStartSubtitle => 'Häufige Vorlage nutzen.';

  @override
  String get addSkipTemplate => 'Überspringen';

  @override
  String get addUseTemplate => 'Vorlage nutzen';

  @override
  String get addRecommendedMetricsTitle => 'Empfohlene Metriken';

  @override
  String get addRecommendedMetricsSubtitle => 'Häufig zusammen erfasst.';

  @override
  String get addSupplementTimelineInfo => 'Erscheint im Zeitplan.';

  @override
  String get addMedicationTimelineInfo => 'Erscheint im Zeitplan.';

  @override
  String get conditionDiabetesTitle => 'Diabetes';

  @override
  String get conditionDiabetesSubtitle => 'Langzeit-Muster';

  @override
  String get conditionHypertensionTitle => 'Bluthochdruck';

  @override
  String get conditionHypertensionSubtitle => 'Häufige Blutdruckmedikamente';

  @override
  String get conditionCholesterolTitle => 'Hohes Cholesterin';

  @override
  String get conditionCholesterolSubtitle => 'Abendtherapie';

  @override
  String get conditionThyroidTitle => 'Schilddrüse';

  @override
  String get conditionThyroidSubtitle => 'Morgens';

  @override
  String get conditionGerdTitle => 'Sodbrennen';

  @override
  String get conditionGerdSubtitle => 'Säure-Kontrolle';

  @override
  String get conditionAsthmaTitle => 'Asthma';

  @override
  String get conditionAsthmaSubtitle => 'Inhalatoren';

  @override
  String get conditionAllergyTitle => 'Allergie';

  @override
  String get conditionAllergySubtitle => 'Antihistaminika';

  @override
  String get conditionHeartPreventionTitle => 'Herzprävention';

  @override
  String get conditionHeartPreventionSubtitle => 'Kardiologie';

  @override
  String get conditionHeartFailureTitle => 'Herzinsuffizienz';

  @override
  String get conditionHeartFailureSubtitle => 'Blutdruck';

  @override
  String get conditionAtrialFibrillationTitle => 'Vorhofflimmern';

  @override
  String get conditionAtrialFibrillationSubtitle => 'Rhythmus';

  @override
  String get conditionJointPainTitle => 'Gelenkschmerzen';

  @override
  String get conditionJointPainSubtitle => 'Schmerzkontrolle';

  @override
  String get conditionBphTitle => 'Prostata / BPH';

  @override
  String get conditionBphSubtitle => 'Harnsymptome';

  @override
  String get conditionOsteoporosisTitle => 'Osteoporose';

  @override
  String get conditionOsteoporosisSubtitle => 'Knochen';

  @override
  String get conditionAnemiaTitle => 'Eisenmangel';

  @override
  String get conditionAnemiaSubtitle => 'Eisenersatz';

  @override
  String get suggestionMetforminName => 'Metformin';

  @override
  String get suggestionMetforminNote => 'Typisch. Dosis prüfen.';

  @override
  String get suggestionInsulinName => 'Insulin';

  @override
  String get suggestionInsulinNote => 'Injektionsvorlage.';

  @override
  String get suggestionAmlodipineName => 'Amlodipin';

  @override
  String get suggestionAmlodipineNote => 'Blutdruckkontrolle.';

  @override
  String get suggestionLosartanName => 'Losartan';

  @override
  String get suggestionLosartanNote => 'Langzeittherapie.';

  @override
  String get suggestionAtorvastatinName => 'Atorvastatin';

  @override
  String get suggestionAtorvastatinNote => 'Tägliches Statin.';

  @override
  String get suggestionLevothyroxineName => 'Levothyroxin';

  @override
  String get suggestionLevothyroxineNote => 'Morgens vor dem Essen.';

  @override
  String get suggestionOmeprazoleName => 'Omeprazol';

  @override
  String get suggestionOmeprazoleNote => 'Morgens vor dem Essen.';

  @override
  String get suggestionFamotidineName => 'Famotidin';

  @override
  String get suggestionFamotidineNote => 'Gegen Sodbrennen.';

  @override
  String get suggestionBudesonideFormoterolName => 'Budesonid/Formoterol';

  @override
  String get suggestionBudesonideFormoterolNote => 'Wartungs-Inhalator.';

  @override
  String get suggestionAlbuterolName => 'Salbutamol';

  @override
  String get suggestionAlbuterolNote => 'Notfall-Inhalator.';

  @override
  String get suggestionCetirizineName => 'Cetirizin';

  @override
  String get suggestionCetirizineNote => 'Einmal täglich.';

  @override
  String get suggestionLoratadineName => 'Loratadin';

  @override
  String get suggestionLoratadineNote => 'Antihistaminikum.';

  @override
  String get suggestionAspirinName => 'Aspirin';

  @override
  String get suggestionAspirinNote => 'Prävention.';

  @override
  String get suggestionClopidogrelName => 'Clopidogrel';

  @override
  String get suggestionClopidogrelNote => 'Täglich.';

  @override
  String get suggestionFurosemideName => 'Furosemid';

  @override
  String get suggestionFurosemideNote => 'Diuretikum.';

  @override
  String get suggestionSpironolactoneName => 'Spironolacton';

  @override
  String get suggestionSpironolactoneNote => 'Unterstützung.';

  @override
  String get suggestionApixabanName => 'Apixaban';

  @override
  String get suggestionApixabanNote => 'Zweimal täglich.';

  @override
  String get suggestionMetoprololName => 'Metoprolol';

  @override
  String get suggestionMetoprololNote => 'Herzfrequenz.';

  @override
  String get suggestionIbuprofenName => 'Ibuprofen';

  @override
  String get suggestionIbuprofenNote => 'Kurzzeit-Schmerz.';

  @override
  String get suggestionDiclofenacGelName => 'Diclofenac Gel';

  @override
  String get suggestionDiclofenacGelNote => 'Topisch.';

  @override
  String get suggestionTamsulosinName => 'Tamsulosin';

  @override
  String get suggestionTamsulosinNote => 'Abends.';

  @override
  String get suggestionFinasterideName => 'Finasterid';

  @override
  String get suggestionFinasterideNote => 'Langzeit.';

  @override
  String get suggestionAlendronateName => 'Alendronat';

  @override
  String get suggestionAlendronateNote => 'Wöchentlich morgens.';

  @override
  String get suggestionCalciumVitaminDName => 'Calcium + Vitamin D';

  @override
  String get suggestionCalciumVitaminDNote => 'Knochen.';

  @override
  String get suggestionFerrousSulfateName => 'Eisensulfat';

  @override
  String get suggestionFerrousSulfateNote => 'Eisenersatz.';

  @override
  String get suggestionFolicAcidName => 'Folsäure';

  @override
  String get suggestionFolicAcidNote => 'Vitamines.';

  @override
  String get pdfDoctorReportTitle => 'Arztbericht';

  @override
  String get pdfSupplementCourseSummary => 'Zusammenfassung';

  @override
  String get pdfMedicationCourseSummary => 'Zusammenfassung';

  @override
  String get pdfCourseProfileTitle => 'Kursprofil';

  @override
  String get pdfScheduleSnapshotTitle => 'Zeitplan';

  @override
  String get pdfScheduleSnapshotSubtitle => 'Dosis und Zeit.';

  @override
  String get pdfAdministrationHistoryTitle => 'Einnahmeverlauf';

  @override
  String get pdfAdministrationHistorySubtitle => 'Geplant vs. Real.';

  @override
  String get pdfAdherenceLabel => 'Treue';

  @override
  String get pdfSnoozedLabel => 'Pausiert';

  @override
  String get pdfClinicalSummaryTitle => 'Zusammenfassung';

  @override
  String get pdfPatientLabel => 'Patient';

  @override
  String get pdfCaregiverLabel => 'Betreuer';

  @override
  String get pdfReportPeriodLabel => 'Periode';

  @override
  String get pdfOnTimeRateLabel => 'Pünktlichkeitsrate';

  @override
  String get pdfAverageDelayLabel => 'Ø Verzögerung';

  @override
  String get pdfUpcomingDosesLabel => 'Kommende';

  @override
  String get pdfStockLeftLabel => 'Vorrat';

  @override
  String get pdfNameLabel => 'Name';

  @override
  String get pdfCourseTypeLabel => 'Typ';

  @override
  String get pdfDosageLabel => 'Dosis';

  @override
  String get pdfFrequencyLabel => 'Häufigkeit';

  @override
  String get pdfStartedLabel => 'Gestartet';

  @override
  String get pdfInstructionLabel => 'Anweisung';

  @override
  String get pdfNotesLabel => 'Notizen';

  @override
  String get pdfTimelineEmpty => 'Kein Verlauf.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return 'Zeigt $visible von $total.';
  }

  @override
  String get pdfTableScheduled => 'Geplant';

  @override
  String get pdfTableActual => 'Real';

  @override
  String get pdfTableDose => 'Dosis';

  @override
  String get pdfTableStatus => 'Status';

  @override
  String get pdfTableDelay => 'Verzögerung';

  @override
  String get pdfOnTime => 'Pünktlich';

  @override
  String get pdfMinuteShort => 'Min';

  @override
  String get pdfNoFoodRestriction => 'Keine Einschränkung';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Füge ein Medikament hinzu, um es hier zu sehen.';

  @override
  String get tabScanner => 'Scanner';

  @override
  String get scannerComingSoonTitle => 'Smart Scanner';

  @override
  String get scannerComingSoonText =>
      'Richte deine Kamera auf eine Schachtel, um die Details auszufüllen. Bald verfügbar!';

  @override
  String get premiumTitle => 'Pillora Pro';

  @override
  String get premiumSubtitle => 'Entfalte das volle Potenzial deiner Routine';

  @override
  String get premiumFeatureCaregiver => 'Unbegrenzte Betreuer & Alarme';

  @override
  String get premiumFeatureScanner => 'Smart Scanner';

  @override
  String get premiumFeatureSchedules => 'Komplexe Zeitpläne';

  @override
  String get premiumFeatureReports => 'PDF-Berichte exportieren';

  @override
  String get premiumSubscribeYearly => 'Pro für 29.99\$ / Jahr freischalten';

  @override
  String get premiumSubscribeMonthly => 'oder 4.99\$ / Monat';

  @override
  String get premiumRestorePurchases => 'Käufe wiederherstellen';
}
