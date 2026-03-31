// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Programme d\'aujourd\'hui';

  @override
  String get architectureReady => 'Architecture prête.';

  @override
  String get nextCreateHome => 'Suivant: Créer l\'écran d\'accueil';

  @override
  String get statusTaken => 'Pris';

  @override
  String get statusSkipped => 'Ignoré';

  @override
  String get statusSnoozed => 'Reporté 10 min';

  @override
  String get statusPending => 'En attente';

  @override
  String get emptySchedule => 'Aucun médicament prévu aujourd\'hui';

  @override
  String get takeAction => 'Prendre';

  @override
  String get skipAction => 'Ignorer';

  @override
  String get dosageUnitMg => 'mg';

  @override
  String get dosageUnitMl => 'ml';

  @override
  String get dosageUnitDrops => 'gouttes';

  @override
  String get dosageUnitPcs => 'pcs';

  @override
  String get dosageUnitG => 'g';

  @override
  String get dosageUnitMcg => 'mcg';

  @override
  String get dosageUnitIu => 'UI';

  @override
  String get addMedicationTitle => 'Ajouter un médicament';

  @override
  String get medicineNameHint => 'Nom (ex. Vitamine D)';

  @override
  String get dosageHint => 'Dosage (ex. 500)';

  @override
  String get saveAction => 'Enregistrer et Créer';

  @override
  String get errorEmptyFields => 'Veuillez remplir tous les champs';

  @override
  String get profileTitle => 'Profil';

  @override
  String notificationTitle(String name) {
    return 'Il est temps de prendre $name !';
  }

  @override
  String notificationBody(String dosage) {
    return 'Dose : $dosage. Ne l\'oubliez pas.';
  }

  @override
  String get analyticsTitle => 'Analytique';

  @override
  String get adherenceRate => 'Taux d\'observance';

  @override
  String get dosesTaken => 'Doses prises';

  @override
  String get dosesMissed => 'Doses oubliées';

  @override
  String get activeCourses => 'Traitements actifs';

  @override
  String get tabHome => 'Programme';

  @override
  String get tabAnalytics => 'Stats';

  @override
  String get keepItUp => 'Excellent travail ! Continuez.';

  @override
  String get needsAttention => 'Nécessite de l\'attention.';

  @override
  String get medicineDetails => 'Détails du médicament';

  @override
  String get pillsRemaining => 'Reste en stock';

  @override
  String get deleteCourse => 'Supprimer le traitement';

  @override
  String get deleteConfirmation => 'Êtes-vous sûr de vouloir supprimer ceci ?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" ajouté.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" mis à jour.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" supprimé.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get timeOfDay => 'Heure de la journée';

  @override
  String get courseDuration => 'Durée (jours)';

  @override
  String get pillsInPackage => 'Quantité dans la boîte';

  @override
  String get addTime => 'Ajouter une heure';

  @override
  String timeLabel(int number) {
    return 'Heure $number';
  }

  @override
  String get foodBefore => 'Avant le repas';

  @override
  String get foodWith => 'Pendant le repas';

  @override
  String get foodAfter => 'Après le repas';

  @override
  String get foodNoMatter => 'À tout moment';

  @override
  String get unknownMedicine => 'Médicament inconnu';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get medicineInfo => 'Informations';

  @override
  String get formTitle => 'Forme';

  @override
  String get scheduleTitle => 'Programme';

  @override
  String get everyXDays => 'Tous les X jours';

  @override
  String get maxDosesPerDay => 'Doses max/jour (Sécurité)';

  @override
  String get overdoseWarning => 'Pour éviter un surdosage.';

  @override
  String get foodInstructionTitle => 'Instructions pour les repas';

  @override
  String doseNumber(int number) {
    return 'Dose $number';
  }

  @override
  String get coursePaused => 'Traitement en pause';

  @override
  String get resumeCourse => 'Reprendre';

  @override
  String get pauseCourse => 'Mettre en pause';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" en pause.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" repris.';
  }

  @override
  String get doctorReport => 'Rapport médical';

  @override
  String get generatingReport => 'Création du rapport...';

  @override
  String errorGeneratingReport(String error) {
    return 'Erreur PDF: $error';
  }

  @override
  String get editCourse => 'Modifier';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get editMedicineInfo => 'Modifier les infos';

  @override
  String lowStockTitle(String name) {
    return 'Stock faible : $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return 'Il reste $count $unit. À renouveler !';
  }

  @override
  String get lowStockBadge => 'Stock faible';

  @override
  String get snoozeAction => 'Reporter (30m)';

  @override
  String get undoAction => 'Annuler';

  @override
  String get sosPanelTitle => 'Au besoin (SOS)';

  @override
  String get takeNowAction => 'PRENDRE';

  @override
  String get limitReachedAlert => 'Limite atteinte !';

  @override
  String get addSosMedicine => 'Ajouter SOS';

  @override
  String get outOfStockBadge => 'Épuisé';

  @override
  String get recentHistory => 'Historique récent';

  @override
  String get noHistoryYet => 'Aucun historique';

  @override
  String get lifetimeCourse => 'Continu (À vie)';

  @override
  String get doneAction => 'Terminé';

  @override
  String get addMeasurement => 'Mesures de santé';

  @override
  String get bloodPressure => 'Tension artérielle';

  @override
  String get heartRate => 'Rythme cardiaque';

  @override
  String get weight => 'Poids';

  @override
  String get bloodSugar => 'Glycémie';

  @override
  String get systolic => 'Sys';

  @override
  String get diastolic => 'Dia';

  @override
  String get taperingDosing => 'Dosage dynamique';

  @override
  String stepNumber(int number) {
    return 'Étape $number';
  }

  @override
  String get addStep => 'Ajouter étape';

  @override
  String get doseForStep => 'Dose pour cette étape';

  @override
  String get whatWouldYouLikeToDo => 'Que voulez-vous faire ?';

  @override
  String get scheduleNewTreatmentCourse => 'Nouveau traitement';

  @override
  String get logHealthMetricsSubtitle => 'Tension, rythme, poids';

  @override
  String get priorityAction => 'Action prioritaire';

  @override
  String get skipDoseAction => 'Ignorer la dose';

  @override
  String errorPrefix(String error) {
    return 'Erreur: $error';
  }

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodAfternoon => 'Bon après-midi';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get dailyProgress => 'Progrès quotidien';

  @override
  String get sosEmergency => 'Urgence SOS';

  @override
  String get adherenceSubtitle => 'Votre régularité';

  @override
  String get healthCorrelationTitle => 'Corrélation santé';

  @override
  String get healthCorrelationSubtitle =>
      'Comparez votre observance et votre santé';

  @override
  String get last7Days => '7 derniers jours';

  @override
  String get pillsTaken => 'Pilules prises';

  @override
  String get overallAdherence => 'Observance globale';

  @override
  String get statusGood => 'Bon';

  @override
  String get statusNeedsAttention => 'Attention';

  @override
  String get statTaken => 'Prises';

  @override
  String get statSkipped => 'Ignorées';

  @override
  String get statTotal => 'Total';

  @override
  String get completedDosesSubtitle => 'Doses complétées';

  @override
  String get missedDosesSubtitle => 'Doses manquées';

  @override
  String get noDataYet => 'Pas de données';

  @override
  String get noDataDescription => 'Commencez à suivre vos mesures.';

  @override
  String get failedToLoadAdherence => 'Erreur';

  @override
  String get failedToLoadChart => 'Erreur';

  @override
  String avgAdherence(String value) {
    return 'Moy. observance $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Moy. $metricName $value';
  }

  @override
  String get addAction => 'Ajouter';

  @override
  String get frequency => 'Fréquence';

  @override
  String get form => 'Forme';

  @override
  String get inventory => 'Stock';

  @override
  String get lowStockAlert => 'STOCK FAIBLE';

  @override
  String get asNeededFrequency => 'AU BESOIN';

  @override
  String get taperingFrequency => 'DYNAMIQUE';

  @override
  String get customizePill => 'Personnaliser';

  @override
  String get customizePillTitle => 'Aspect de la pilule';

  @override
  String get shape => 'Forme';

  @override
  String get color => 'Couleur';

  @override
  String get overview => 'Aperçu';

  @override
  String get scheduleAndRules => 'Horaires & Règles';

  @override
  String get duration => 'Durée';

  @override
  String get reminders => 'Rappels';

  @override
  String get daysSuffix => 'jours';

  @override
  String get pcsSuffix => 'pcs';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get personalInfo => 'Informations perso';

  @override
  String get appPreferences => 'Préférences de l\'app';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get language => 'Langue';

  @override
  String get notifications => 'Notifications';

  @override
  String get advancedFeatures => 'Paramètres avancés';

  @override
  String get caregivers => 'Aidants';

  @override
  String get drugInteractions => 'Interactions';

  @override
  String get comingSoon => 'BIENTÔT';

  @override
  String get supportAndAbout => 'Support & À propos';

  @override
  String get contactSupport => 'Contacter le support';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get logout => 'Déconnexion';

  @override
  String get tabSettings => 'Profil';

  @override
  String get defaultUserName => 'Ami';

  @override
  String get courseKindMedication => 'Médicament';

  @override
  String get courseKindSupplement => 'Complément';

  @override
  String get courseFilterAll => 'Tout';

  @override
  String get courseFilterMedications => 'Médicaments';

  @override
  String get courseFilterSupplements => 'Compléments';

  @override
  String get homeTakeMedicationNow => 'Prendre ce médicament';

  @override
  String get homeTakeSupplementNow => 'Prendre ce complément';

  @override
  String get homeEmptyAllTitle => 'Pas encore de médicaments';

  @override
  String get homeEmptyMedicationsTitle => 'Pas de médicaments';

  @override
  String get homeEmptySupplementsTitle => 'Pas de compléments';

  @override
  String get homeEmptyAllSubtitle => 'Rien ne nécessite d\'attention.';

  @override
  String get homeEmptyMedicationsSubtitle => 'Aucun médicament prévu.';

  @override
  String get homeEmptySupplementsSubtitle => 'Aucun complément prévu.';

  @override
  String get homeAddSupplementTitle => 'Ajouter un complément';

  @override
  String get homeAddSupplementSubtitle => 'Planifier vitamines';

  @override
  String get homeForThisDay => 'Pour ce jour';

  @override
  String get homeMorningRoutine => 'Matin';

  @override
  String get homeAfternoonRoutine => 'Après-midi';

  @override
  String get homeEveningRoutine => 'Soir';

  @override
  String get homeNightRoutine => 'Nuit';

  @override
  String get homeRoutineSupplementsOnly => 'compléments';

  @override
  String get homeRoutineMedicationsOnly => 'médicaments';

  @override
  String get homeRoutineMixed => 'mixte';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments',
      one: '1 élément',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Attention requise';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments nécessitent votre attention.',
      one: '1 élément nécessite votre attention.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'À venir';

  @override
  String get homeRefillReminderTitle => 'Renouvellement';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count traitements à renouveler.',
      one: '1 traitement à renouveler.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Tout est calme';

  @override
  String get homeEverythingCalmSubtitle => 'Aucune tâche urgente.';

  @override
  String get homeNoUpcomingItem => 'Aucun élément à venir.';

  @override
  String homeScheduledFor(String time) {
    return 'Prévu à $time';
  }

  @override
  String get calendarToday => 'Aujourd\'hui';

  @override
  String get calendarSelectedDay => 'Jour sélectionné';

  @override
  String get calendarShowingToday => 'Programme d\'aujourd\'hui';

  @override
  String get calendarBrowseNearbyDays => 'Faites défiler pour changer de jour';

  @override
  String get calendarPreviewAnotherDay => 'Aperçu d\'un autre jour.';

  @override
  String get calendarDayWheelSemantics => 'Roue des jours';

  @override
  String get analyticsCourseMix => 'Mix de traitements';

  @override
  String get analyticsCourseMixSubtitle => 'Médicaments et compléments';

  @override
  String get analyticsCurrentRoutine => 'Routine actuelle';

  @override
  String get analyticsCurrentRoutineSubtitle => 'Jours d\'affilée sans oubli';

  @override
  String get analyticsTimingAccuracy => 'Précision';

  @override
  String get analyticsTimingAccuracySubtitle => 'Pris dans les 30 min';

  @override
  String get analyticsBestRoutine => 'Meilleure routine';

  @override
  String get analyticsBestRoutineSubtitle => 'Meilleur résultat sur 90 jours';

  @override
  String get analyticsRefillRisk => 'Risque de rupture';

  @override
  String get analyticsRefillRiskSubtitle => 'Stock faible';

  @override
  String get analyticsAverageDelay => 'Retard moyen';

  @override
  String get analyticsMinutesShort => 'min';

  @override
  String get analyticsCoachNote => 'Note du coach';

  @override
  String get analyticsMissedDoses => 'Doses manquées';

  @override
  String analyticsActiveShort(int count) {
    return '$count actifs';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Prises: $taken  Manquées: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Support';

  @override
  String get settingsContactSupportBody => 'Nous sommes là pour vous aider.';

  @override
  String get settingsSupportEmailCopied => 'Email copié';

  @override
  String get settingsCopySupportEmail => 'Copier l\'email';

  @override
  String get settingsPrivacyTitle => 'Confidentialité';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Vos données restent sur votre appareil.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Les rapports sont créés uniquement sur demande.';

  @override
  String get settingsPrivacyLaunchNote => 'Publiez votre politique.';

  @override
  String get settingsLanguageEnglish => 'Anglais';

  @override
  String get settingsLanguageRussian => 'Russe';

  @override
  String get settingsYourProfilePreferences => 'Vos préférences';

  @override
  String get settingsComfortModeTitle => 'Mode confort';

  @override
  String get settingsComfortModeSubtitle => 'Texte plus grand';

  @override
  String get settingsNotificationsEnabled => 'Rappels activés';

  @override
  String get settingsOn => 'Activé';

  @override
  String get settingsSupportAndSafety => 'Support & Sécurité';

  @override
  String get settingsShowOnboardingAgain => 'Afficher le guide';

  @override
  String get settingsShowOnboardingAgainSubtitle => 'Ouvrir le tutoriel';

  @override
  String get settingsFeaturePolishing => 'En cours de développement';

  @override
  String get settingsCaregiverTitle => 'Partage avec aidant';

  @override
  String get settingsCaregiverDescription =>
      'Ajoutez une personne de confiance.';

  @override
  String get settingsCaregiverName => 'Nom de l\'aidant';

  @override
  String get settingsCaregiverRelation => 'Relation';

  @override
  String get settingsCaregiverPhone => 'Numéro de téléphone';

  @override
  String get settingsCaregiverShareReports => 'Inclure dans les rapports';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Coordonnées dans les rapports';

  @override
  String get settingsCaregiverSaved => 'Paramètres sauvegardés';

  @override
  String get settingsCaregiverRemoved => 'Aidant supprimé';

  @override
  String get settingsCaregiverRemove => 'Supprimer l\'aidant';

  @override
  String get settingsCaregiverEmpty => 'Ajouter un aidant';

  @override
  String get settingsCaregiverAlertsTitle => 'Alertes';

  @override
  String get settingsCaregiverAlertsDescription => 'Si une dose est en retard.';

  @override
  String get settingsCaregiverAlertsEmpty => 'Ajoutez un aidant d\'abord';

  @override
  String get settingsCaregiverAlertsDisabled => 'Les alertes sont désactivées';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'Alerte prête après $minutes min';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Préparer les alertes';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Message prêt à être envoyé.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Délai de grâce';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Attendre $minutes min avant l\'alerte.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes min';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Doses en retard';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Préparer une alerte pour les retards.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Doses ignorées';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Préparer une alerte pour les oublis.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle =>
      'Inclure les compléments';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Utiliser pour les compléments.';

  @override
  String get settingsCaregiverAlertsSaved => 'Règles sauvegardées';

  @override
  String get settingsCaregiverConnectedTitle => 'Mode connecté';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Connexion stable pour les alertes.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Code prêt. Boîte d\'envoi vide.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count alerte(s) en attente.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Code de liaison';

  @override
  String get settingsCaregiverConnectedCodeSubtitle => 'Partagez ce code.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Boîte d\'envoi';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Dernier: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Copier le code';

  @override
  String get settingsCaregiverConnectedCodeCopied => 'Code copié';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Vider la boîte d\'envoi';

  @override
  String get settingsCaregiverConnectedOutboxCleared => 'Boîte d\'envoi vidée';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Lien Cloud';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Cet appareil est le patient.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'Lié en tant qu\'aidant pour $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone => 'Aucun lien cloud.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Code lié: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle =>
      'Aperçu de la boîte de réception';

  @override
  String get settingsCaregiverConnectedInboxEmpty => 'Aucune alerte cloud.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Utiliser comme patient';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Appareil lié comme patient';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Utiliser comme aidant';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Rejoindre';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Saisissez le code du patient.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Connecter';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Appareil lié comme aidant';

  @override
  String get settingsCaregiverConnectedJoinFailed => 'Code non trouvé';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Déconnecter';

  @override
  String get settingsCaregiverConnectedDisconnected => 'Déconnecté.';

  @override
  String get caregiverCloudNotificationTitle => 'Alerte de l\'aidant';

  @override
  String get caregiverAlertCardTitle => 'Alerte prête';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName peut être notifié de $count élément(s).';
  }

  @override
  String get caregiverAlertReviewAction => 'Vérifier et copier';

  @override
  String get caregiverAlertSheetTitle => 'Alerte';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Message préparé pour $caregiverName ($count élément(s)).';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'En retard de $minutes min';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Ignoré';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Prévu à $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote => 'Copiez et envoyez cette alerte.';

  @override
  String get caregiverAlertCopyMessage => 'Copier l\'alerte';

  @override
  String get caregiverAlertCopyPhone => 'Copier le téléphone';

  @override
  String get caregiverAlertNoPhone => 'Ajouter le téléphone dans Paramètres';

  @override
  String get caregiverAlertMessageCopied => 'Alerte copiée';

  @override
  String get caregiverAlertPhoneCopied => 'Téléphone copié';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Bonjour, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Mise à jour pour $patientName:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — prévu à $time, retard $minutes min';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — prévu à $time, ignoré';
  }

  @override
  String get caregiverAlertMessageFooter =>
      'Veuillez vérifier si une aide est nécessaire.';

  @override
  String get settingsSupportEmailSubtitle => 'Email de support';

  @override
  String get settingsPrivacySubtitle => 'Gestion des données';

  @override
  String get settingsExampleName => 'Exemple, Alex';

  @override
  String get settingsSave => 'Enregistrer';

  @override
  String get onboardingStartUsing => 'Commencer avec Pillora';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingBack => 'Retour';

  @override
  String get onboardingWelcomeTitle => 'Restez sur la bonne voie';

  @override
  String get onboardingWelcomeTagline => 'Calme et clair.';

  @override
  String get onboardingWelcomeBody =>
      'Voyez ce qu\'il faut prendre en un coup d\'œil.';

  @override
  String get onboardingFeatureEasyInterface => 'Interface claire';

  @override
  String get onboardingFeatureNextDose => 'Focus sur la prochaine dose';

  @override
  String get onboardingFeatureReminders => 'Rappels et alertes de stock';

  @override
  String get onboardingTailorTitle => 'Personnalisez votre app';

  @override
  String get onboardingTailorSubtitle => 'Modifiable plus tard.';

  @override
  String get onboardingNamePrompt => 'Comment vous appeler ?';

  @override
  String get onboardingLanguageTitle => 'Langue';

  @override
  String get onboardingReadingComfort => 'Confort de lecture';

  @override
  String get onboardingComfortModeTitle => 'Mode confort';

  @override
  String get onboardingComfortModeSubtitle => 'Textes plus grands';

  @override
  String get onboardingReadyTitle => 'Tout est prêt';

  @override
  String get onboardingReadyBanner => 'Focus sur l\'essentiel.';

  @override
  String get onboardingReadyBody => 'L\'écran d\'accueil priorise l\'immédiat.';

  @override
  String get onboardingReadySummaryHome => 'Écran d\'accueil simple';

  @override
  String get onboardingReadySummaryActions => 'Prendre, ignorer, ajouter';

  @override
  String get onboardingReadySummaryComfortOn => 'Mode confort activé';

  @override
  String get onboardingReadySummaryComfortLater =>
      'Le mode confort est disponible';

  @override
  String get medicineStandardCourse => 'Traitement standard';

  @override
  String get medicineComplexCourse => 'Traitement complexe';

  @override
  String get schedulePreviewTitle => 'Aperçu';

  @override
  String get scheduleDoseAtTime => 'Dose à cette heure';

  @override
  String get courseTypeLabel => 'Type de traitement';

  @override
  String get addSupplementScreenTitle => 'Ajouter un complément';

  @override
  String get editSupplementTitle => 'Modifier';

  @override
  String get settingsLanguageChangeLater => 'Modifiable dans Profil';

  @override
  String get homeNothingDueTitle => 'Rien de prévu maintenant';

  @override
  String get homeUseDayWheelSubtitle =>
      'Utilisez la roue pour vérifier un autre jour.';

  @override
  String get homeNoAttentionRightNow => 'Aucun élément urgent.';

  @override
  String get homeAddItemFab => 'Ajouter médicament ou mesure';

  @override
  String get homeTimelineSubtitle => 'Triés par heure.';

  @override
  String get analyticsCoachGreat => 'Routine solide, continuez !';

  @override
  String get analyticsCoachMissed => 'Fixez la première dose de la journée.';

  @override
  String get analyticsCoachTiming => 'Améliorez la précision de l\'horaire.';

  @override
  String get medicineFrequencyDaily => 'Quotidien';

  @override
  String get medicineFrequencySpecificDays => 'Jours spécifiques';

  @override
  String get medicineFrequencyInterval => 'Intervalle';

  @override
  String get medicineFrequencyCycle => 'Cycle';

  @override
  String get medicineFormTablet => 'Comprimé';

  @override
  String get medicineFormCapsule => 'Gélule';

  @override
  String get medicineFormLiquid => 'Liquide';

  @override
  String get medicineFormInjection => 'Injection';

  @override
  String get medicineFormDrops => 'Gouttes';

  @override
  String get medicineFormOintment => 'Pommade';

  @override
  String get medicineFormSpray => 'Spray';

  @override
  String get medicineFormInhaler => 'Inhalateur';

  @override
  String get medicineFormPatch => 'Patch';

  @override
  String get medicineFormSuppository => 'Suppositoire';

  @override
  String get medicineTimelineSupplementInfo => 'Visible dans la chronologie.';

  @override
  String get medicineTimelineMedicationInfo => 'Partie de votre traitement.';

  @override
  String get medicineDoseScheduleTitle => 'Horaires';

  @override
  String get medicineDoseScheduleSubtitle => 'Détails du jour suivant.';

  @override
  String get medicineHistoryLoadError => 'Erreur';

  @override
  String get scheduleDoseTabletsAtTime => 'Comprimés à cette heure';

  @override
  String get scheduleDoseAmountAtTime => 'Dose à cette heure';

  @override
  String get schedulePreviewFutureRebuilt =>
      'Les futures doses utiliseront cet horaire.';

  @override
  String get scheduleComplexTitle => 'Horaires complexes';

  @override
  String get scheduleComplexEditSubtitle => 'Éditez dose et heure.';

  @override
  String get courseTimelineSupplementInfo => 'Reste dans sa propre catégorie.';

  @override
  String get courseTimelineMedicationInfo =>
      'Reste dans la catégorie médicale.';

  @override
  String get supplementNameHint => 'Nom (ex. Magnésium)';

  @override
  String get addDoseAction => 'Ajouter une dose';

  @override
  String get addConditionSuggestionsTitle => 'Suggestions par condition';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Modèles courants. Vérifiez l\'ordonnance.';

  @override
  String get addConditionSuggestionsEmpty => 'Aucune autre suggestion.';

  @override
  String get addFlowSupplementTitle => 'Comment ajouter ceci ?';

  @override
  String get addFlowMedicationTitle => 'Comment commencer ?';

  @override
  String get addFlowSupplementSubtitle => 'Modèles rapides disponibles.';

  @override
  String get addFlowMedicationSubtitle =>
      'Choisissez l\'option la plus simple.';

  @override
  String get addFlowByConditionTitle => 'Par condition';

  @override
  String get addFlowByConditionSubtitle => 'Modèles pour une condition';

  @override
  String get addFlowQuickTemplateTitle => 'Modèle rapide';

  @override
  String get addFlowQuickTemplateSubtitle => 'Utiliser un modèle prédéfini';

  @override
  String get addFlowManualTitle => 'Manuel';

  @override
  String get addFlowManualSubtitle => 'Remplir de zéro';

  @override
  String get addAppearanceTitle => 'Apparence';

  @override
  String get addAppearanceSubtitle => 'Ajouter une photo ou personnaliser.';

  @override
  String get addPhotoLabel => 'Photo';

  @override
  String get addQuickStartTitle => 'Démarrage rapide';

  @override
  String get addQuickStartSubtitle => 'Utiliser un modèle courant.';

  @override
  String get addSkipTemplate => 'Passer';

  @override
  String get addUseTemplate => 'Utiliser';

  @override
  String get addRecommendedMetricsTitle => 'Métriques recommandées';

  @override
  String get addRecommendedMetricsSubtitle => 'Souvent suivies avec ceci.';

  @override
  String get addSupplementTimelineInfo => 'Apparaîtra dans la chronologie.';

  @override
  String get addMedicationTimelineInfo => 'Apparaîtra dans la chronologie.';

  @override
  String get conditionDiabetesTitle => 'Diabète';

  @override
  String get conditionDiabetesSubtitle => 'Thérapies à long terme';

  @override
  String get conditionHypertensionTitle => 'Hypertension';

  @override
  String get conditionHypertensionSubtitle => 'Médicaments pour la tension';

  @override
  String get conditionCholesterolTitle => 'Cholestérol';

  @override
  String get conditionCholesterolSubtitle => 'Thérapie du soir';

  @override
  String get conditionThyroidTitle => 'Hypothyroïdie';

  @override
  String get conditionThyroidSubtitle => 'Remplacement thyroïdien';

  @override
  String get conditionGerdTitle => 'Reflux gastrique';

  @override
  String get conditionGerdSubtitle => 'Contrôle de l\'acidité';

  @override
  String get conditionAsthmaTitle => 'Asthme';

  @override
  String get conditionAsthmaSubtitle => 'Inhalateurs courants';

  @override
  String get conditionAllergyTitle => 'Allergie';

  @override
  String get conditionAllergySubtitle => 'Antihistaminiques';

  @override
  String get conditionHeartPreventionTitle => 'Prévention cardiaque';

  @override
  String get conditionHeartPreventionSubtitle => 'Cardiologie à long terme';

  @override
  String get conditionHeartFailureTitle => 'Insuffisance cardiaque';

  @override
  String get conditionHeartFailureSubtitle => 'Soutien tensionnel';

  @override
  String get conditionAtrialFibrillationTitle => 'Fibrillation atriale';

  @override
  String get conditionAtrialFibrillationSubtitle => 'Prévention des AVC';

  @override
  String get conditionJointPainTitle => 'Douleurs articulaires';

  @override
  String get conditionJointPainSubtitle => 'Contrôle de la douleur';

  @override
  String get conditionBphTitle => 'Prostate / HBP';

  @override
  String get conditionBphSubtitle => 'Symptômes urinaires';

  @override
  String get conditionOsteoporosisTitle => 'Ostéoporose';

  @override
  String get conditionOsteoporosisSubtitle => 'Soutien osseux';

  @override
  String get conditionAnemiaTitle => 'Anémie / Fer';

  @override
  String get conditionAnemiaSubtitle => 'Modèles de remplacement en fer';

  @override
  String get suggestionMetforminName => 'Metformine';

  @override
  String get suggestionMetforminNote => 'Thérapie orale. Vérifiez la dose.';

  @override
  String get suggestionInsulinName => 'Insuline';

  @override
  String get suggestionInsulinNote => 'Modèle d\'injection.';

  @override
  String get suggestionAmlodipineName => 'Amlodipine';

  @override
  String get suggestionAmlodipineNote => 'Tension artérielle.';

  @override
  String get suggestionLosartanName => 'Losartan';

  @override
  String get suggestionLosartanNote => 'Thérapie à long terme.';

  @override
  String get suggestionAtorvastatinName => 'Atorvastatine';

  @override
  String get suggestionAtorvastatinNote => 'Statine quotidienne.';

  @override
  String get suggestionLevothyroxineName => 'Lévothyroxine';

  @override
  String get suggestionLevothyroxineNote => 'Le matin avant manger.';

  @override
  String get suggestionOmeprazoleName => 'Oméprazole';

  @override
  String get suggestionOmeprazoleNote => 'Le matin avant manger.';

  @override
  String get suggestionFamotidineName => 'Famotidine';

  @override
  String get suggestionFamotidineNote => 'Contre l\'acidité.';

  @override
  String get suggestionBudesonideFormoterolName => 'Budésonide/Formotérol';

  @override
  String get suggestionBudesonideFormoterolNote => 'Inhalateur de fond.';

  @override
  String get suggestionAlbuterolName => 'Salbutamol';

  @override
  String get suggestionAlbuterolNote => 'Inhalateur de secours.';

  @override
  String get suggestionCetirizineName => 'Cétirizine';

  @override
  String get suggestionCetirizineNote => 'Allergies.';

  @override
  String get suggestionLoratadineName => 'Loratadine';

  @override
  String get suggestionLoratadineNote => 'Antihistaminique.';

  @override
  String get suggestionAspirinName => 'Aspirine';

  @override
  String get suggestionAspirinNote => 'Prévention cardiaque.';

  @override
  String get suggestionClopidogrelName => 'Clopidogrel';

  @override
  String get suggestionClopidogrelNote => 'Thérapie antiplaquettaire.';

  @override
  String get suggestionFurosemideName => 'Furosémide';

  @override
  String get suggestionFurosemideNote => 'Diurétique.';

  @override
  String get suggestionSpironolactoneName => 'Spironolactone';

  @override
  String get suggestionSpironolactoneNote => 'Soutien quotidien.';

  @override
  String get suggestionApixabanName => 'Apixaban';

  @override
  String get suggestionApixabanNote => 'Anticoagulant.';

  @override
  String get suggestionMetoprololName => 'Métoprolol';

  @override
  String get suggestionMetoprololNote => 'Contrôle du rythme.';

  @override
  String get suggestionIbuprofenName => 'Ibuprofène';

  @override
  String get suggestionIbuprofenNote => 'Douleur.';

  @override
  String get suggestionDiclofenacGelName => 'Diclofénac (gel)';

  @override
  String get suggestionDiclofenacGelNote => 'Anti-inflammatoire topique.';

  @override
  String get suggestionTamsulosinName => 'Tamsulosine';

  @override
  String get suggestionTamsulosinNote => 'Le soir après manger.';

  @override
  String get suggestionFinasterideName => 'Finastéride';

  @override
  String get suggestionFinasterideNote => 'Soutien à long terme.';

  @override
  String get suggestionAlendronateName => 'Alendronate';

  @override
  String get suggestionAlendronateNote => 'Hebdomadaire le matin.';

  @override
  String get suggestionCalciumVitaminDName => 'Calcium + Vitamine D';

  @override
  String get suggestionCalciumVitaminDNote => 'Soutien osseux.';

  @override
  String get suggestionFerrousSulfateName => 'Sulfate ferreux';

  @override
  String get suggestionFerrousSulfateNote => 'Fer oral.';

  @override
  String get suggestionFolicAcidName => 'Acide folique';

  @override
  String get suggestionFolicAcidNote => 'Vitamines.';

  @override
  String get pdfDoctorReportTitle => 'Rapport Médical';

  @override
  String get pdfSupplementCourseSummary => 'Résumé (Complément)';

  @override
  String get pdfMedicationCourseSummary => 'Résumé (Médicament)';

  @override
  String get pdfCourseProfileTitle => 'Profil du traitement';

  @override
  String get pdfScheduleSnapshotTitle => 'Horaires';

  @override
  String get pdfScheduleSnapshotSubtitle => 'Détails du dosage.';

  @override
  String get pdfAdministrationHistoryTitle => 'Historique des prises';

  @override
  String get pdfAdministrationHistorySubtitle =>
      'Prises par rapport aux prévisions.';

  @override
  String get pdfAdherenceLabel => 'Observance';

  @override
  String get pdfSnoozedLabel => 'Reporté';

  @override
  String get pdfClinicalSummaryTitle => 'Résumé clinique';

  @override
  String get pdfPatientLabel => 'Patient';

  @override
  String get pdfCaregiverLabel => 'Aidant';

  @override
  String get pdfReportPeriodLabel => 'Période';

  @override
  String get pdfOnTimeRateLabel => 'Taux à l\'heure';

  @override
  String get pdfAverageDelayLabel => 'Retard moyen';

  @override
  String get pdfUpcomingDosesLabel => 'Prochaines doses';

  @override
  String get pdfStockLeftLabel => 'Stock restant';

  @override
  String get pdfNameLabel => 'Nom';

  @override
  String get pdfCourseTypeLabel => 'Type';

  @override
  String get pdfDosageLabel => 'Dose';

  @override
  String get pdfFrequencyLabel => 'Fréquence';

  @override
  String get pdfStartedLabel => 'Début';

  @override
  String get pdfInstructionLabel => 'Instruction';

  @override
  String get pdfNotesLabel => 'Notes';

  @override
  String get pdfTimelineEmpty => 'Aucun historique.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return '$visible entrées affichées sur $total.';
  }

  @override
  String get pdfTableScheduled => 'Prévu';

  @override
  String get pdfTableActual => 'Réel';

  @override
  String get pdfTableDose => 'Dose';

  @override
  String get pdfTableStatus => 'Statut';

  @override
  String get pdfTableDelay => 'Retard';

  @override
  String get pdfOnTime => 'À l\'heure';

  @override
  String get pdfMinuteShort => 'min';

  @override
  String get pdfNoFoodRestriction => 'Sans restriction';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Ajoutez un médicament pour le voir ici.';

  @override
  String get tabScanner => 'Scanner';

  @override
  String get scannerComingSoonTitle => 'Scanner Intelligent';

  @override
  String get scannerComingSoonText =>
      'Pointez votre appareil photo pour remplir les détails automatiquement. Bientôt !';

  @override
  String get premiumTitle => 'Pillora Pro';

  @override
  String get premiumSubtitle => 'Débloquez tout le potentiel de votre santé';

  @override
  String get premiumFeatureCaregiver => 'Aidants illimités et alertes';

  @override
  String get premiumFeatureScanner => 'Scanner intelligent';

  @override
  String get premiumFeatureSchedules => 'Traitements complexes';

  @override
  String get premiumFeatureReports => 'Exportation de rapports PDF';

  @override
  String get premiumSubscribeYearly => 'Débloquer Pro pour 29.99\$ / an';

  @override
  String get premiumSubscribeMonthly => 'ou 4.99\$ / mois';

  @override
  String get premiumRestorePurchases => 'Restaurer les achats';
}
