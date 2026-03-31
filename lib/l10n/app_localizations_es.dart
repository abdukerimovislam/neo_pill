// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pillora';

  @override
  String get todaySchedule => 'Horario de hoy';

  @override
  String get architectureReady =>
      'Arquitectura lista. Todos los sistemas normales.';

  @override
  String get nextCreateHome => 'Siguiente: Crear pantalla de inicio';

  @override
  String get statusTaken => 'Tomado';

  @override
  String get statusSkipped => 'Omitido';

  @override
  String get statusSnoozed => 'Pospuesto 10 min';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get emptySchedule => 'No hay medicamentos programados para este día';

  @override
  String get takeAction => 'Tomar';

  @override
  String get skipAction => 'Omitir';

  @override
  String get dosageUnitMg => 'mg';

  @override
  String get dosageUnitMl => 'ml';

  @override
  String get dosageUnitDrops => 'gotas';

  @override
  String get dosageUnitPcs => 'ud.';

  @override
  String get dosageUnitG => 'g';

  @override
  String get dosageUnitMcg => 'mcg';

  @override
  String get dosageUnitIu => 'UI';

  @override
  String get addMedicationTitle => 'Añadir medicamento';

  @override
  String get medicineNameHint => 'Nombre del medicamento (ej. Vitamina D)';

  @override
  String get dosageHint => 'Dosis (ej. 500)';

  @override
  String get saveAction => 'Guardar y crear horario';

  @override
  String get errorEmptyFields => 'Por favor, rellena todos los campos';

  @override
  String get profileTitle => 'Perfil';

  @override
  String notificationTitle(String name) {
    return '¡Es hora de tomar $name!';
  }

  @override
  String notificationBody(String dosage) {
    return 'Dosis: $dosage. Por favor, no lo olvides.';
  }

  @override
  String get analyticsTitle => 'Análisis';

  @override
  String get adherenceRate => 'Tasa de adherencia';

  @override
  String get dosesTaken => 'Dosis tomadas';

  @override
  String get dosesMissed => 'Dosis omitidas';

  @override
  String get activeCourses => 'Cursos activos';

  @override
  String get tabHome => 'Horario';

  @override
  String get tabAnalytics => 'Estadísticas';

  @override
  String get keepItUp => '¡Buen trabajo! Sigue así.';

  @override
  String get needsAttention => 'Requiere atención. Intenta no olvidar dosis.';

  @override
  String get medicineDetails => 'Detalles del medicamento';

  @override
  String get pillsRemaining => 'Restante en stock';

  @override
  String get deleteCourse => 'Eliminar curso';

  @override
  String get deleteConfirmation =>
      '¿Estás seguro de que quieres eliminar este curso y todos sus recordatorios?';

  @override
  String courseAddedMessage(String type, String name) {
    return '$type \"$name\" añadido.';
  }

  @override
  String courseUpdatedMessage(String type, String name) {
    return '$type \"$name\" actualizado.';
  }

  @override
  String courseDeletedMessage(String type, String name) {
    return '$type \"$name\" eliminado.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get timeOfDay => 'Hora del día';

  @override
  String get courseDuration => 'Duración del curso (días)';

  @override
  String get pillsInPackage => 'Cantidad en envase';

  @override
  String get addTime => 'Añadir hora';

  @override
  String timeLabel(int number) {
    return 'Hora $number';
  }

  @override
  String get foodBefore => 'Antes de comer';

  @override
  String get foodWith => 'Con comida';

  @override
  String get foodAfter => 'Después de comer';

  @override
  String get foodNoMatter => 'Cualquier momento';

  @override
  String get unknownMedicine => 'Medicamento desconocido';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get takePhoto => 'Tomar una foto';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get medicineInfo => 'Información';

  @override
  String get formTitle => 'Forma';

  @override
  String get scheduleTitle => 'Horario';

  @override
  String get everyXDays => 'Cada X días';

  @override
  String get maxDosesPerDay => 'Dosis máximas por día (Seguridad)';

  @override
  String get overdoseWarning => 'Para evitar sobredosis accidental.';

  @override
  String get foodInstructionTitle => 'Instrucción de comida';

  @override
  String doseNumber(int number) {
    return 'Dosis $number';
  }

  @override
  String get coursePaused => 'Curso pausado';

  @override
  String get resumeCourse => 'Reanudar';

  @override
  String get pauseCourse => 'Pausar';

  @override
  String coursePausedMessage(String type, String name) {
    return '$type \"$name\" pausado.';
  }

  @override
  String courseResumedMessage(String type, String name) {
    return '$type \"$name\" reanudado.';
  }

  @override
  String get doctorReport => 'Informe médico';

  @override
  String get generatingReport => 'Generando informe...';

  @override
  String errorGeneratingReport(String error) {
    return 'Error al generar PDF: $error';
  }

  @override
  String get editCourse => 'Editar curso';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get editMedicineInfo => 'Editar información';

  @override
  String lowStockTitle(String name) {
    return 'Poco stock: $name';
  }

  @override
  String lowStockBody(int count, String unit) {
    return '¡Solo quedan $count $unit. Hora de reponer!';
  }

  @override
  String get lowStockBadge => 'Poco stock';

  @override
  String get snoozeAction => 'Posponer (30m)';

  @override
  String get undoAction => 'Deshacer';

  @override
  String get sosPanelTitle => 'Según necesidad (SOS)';

  @override
  String get takeNowAction => 'TOMAR AHORA';

  @override
  String get limitReachedAlert =>
      '¡Límite diario alcanzado! Consulta a tu médico.';

  @override
  String get addSosMedicine => 'Añadir SOS';

  @override
  String get outOfStockBadge => 'Agotado';

  @override
  String get recentHistory => 'Historial reciente';

  @override
  String get noHistoryYet => 'Sin historial aún';

  @override
  String get lifetimeCourse => 'Continuo (De por vida)';

  @override
  String get doneAction => 'Hecho';

  @override
  String get addMeasurement => 'Registrar datos';

  @override
  String get bloodPressure => 'Presión arterial';

  @override
  String get heartRate => 'Frecuencia cardíaca';

  @override
  String get weight => 'Peso';

  @override
  String get bloodSugar => 'Azúcar en sangre';

  @override
  String get systolic => 'Sis';

  @override
  String get diastolic => 'Dia';

  @override
  String get taperingDosing => 'Dosis dinámica';

  @override
  String stepNumber(int number) {
    return 'Paso $number';
  }

  @override
  String get addStep => 'Añadir paso';

  @override
  String get doseForStep => 'Dosis para este paso';

  @override
  String get whatWouldYouLikeToDo => '¿Qué te gustaría hacer?';

  @override
  String get scheduleNewTreatmentCourse => 'Programar nuevo curso';

  @override
  String get logHealthMetricsSubtitle => 'Registrar presión, ritmo, peso';

  @override
  String get priorityAction => 'Acción prioritaria';

  @override
  String get skipDoseAction => 'Omitir dosis';

  @override
  String errorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodAfternoon => 'Buenas tardes';

  @override
  String get goodEvening => 'Buenas noches';

  @override
  String get dailyProgress => 'Progreso diario';

  @override
  String get sosEmergency => 'Emergencia SOS';

  @override
  String get adherenceSubtitle => 'Tu consistencia con la medicación';

  @override
  String get healthCorrelationTitle => 'Correlación de salud';

  @override
  String get healthCorrelationSubtitle =>
      'Compara la adherencia con tus métricas';

  @override
  String get last7Days => 'Últimos 7 días';

  @override
  String get pillsTaken => 'Pastillas tomadas';

  @override
  String get overallAdherence => 'Adherencia general';

  @override
  String get statusGood => 'Bien';

  @override
  String get statusNeedsAttention => 'Requiere atención';

  @override
  String get statTaken => 'Tomadas';

  @override
  String get statSkipped => 'Omitidas';

  @override
  String get statTotal => 'Total';

  @override
  String get completedDosesSubtitle => 'Dosis completadas';

  @override
  String get missedDosesSubtitle => 'Dosis omitidas';

  @override
  String get noDataYet => 'Sin datos aún';

  @override
  String get noDataDescription =>
      'Registra mediciones y tomas regularmente\npara ver correlaciones aquí.';

  @override
  String get failedToLoadAdherence => 'Error al cargar adherencia';

  @override
  String get failedToLoadChart => 'Error al cargar gráfico';

  @override
  String avgAdherence(String value) {
    return 'Adherencia media $value%';
  }

  @override
  String avgMetric(String metricName, String value) {
    return 'Media $metricName $value';
  }

  @override
  String get addAction => 'Añadir registro';

  @override
  String get frequency => 'Frecuencia';

  @override
  String get form => 'Forma';

  @override
  String get inventory => 'Inventario';

  @override
  String get lowStockAlert => 'POCO STOCK';

  @override
  String get asNeededFrequency => 'SEGÚN NECESIDAD';

  @override
  String get taperingFrequency => 'DINÁMICA';

  @override
  String get customizePill => 'Personalizar';

  @override
  String get customizePillTitle => 'Personalizar pastilla';

  @override
  String get shape => 'Forma';

  @override
  String get color => 'Color';

  @override
  String get overview => 'Resumen';

  @override
  String get scheduleAndRules => 'Horarios y reglas';

  @override
  String get duration => 'Duración';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get daysSuffix => 'días';

  @override
  String get pcsSuffix => 'ud.';

  @override
  String get details => 'Details';

  @override
  String get settingsTitle => 'Ajustes y perfil';

  @override
  String get personalInfo => 'Información personal';

  @override
  String get appPreferences => 'Preferencias de la app';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get advancedFeatures => 'Ajustes avanzados';

  @override
  String get caregivers => 'Cuidadores y amigos';

  @override
  String get drugInteractions => 'Interacciones';

  @override
  String get comingSoon => 'PRONTO';

  @override
  String get supportAndAbout => 'Soporte y acerca de';

  @override
  String get contactSupport => 'Contactar soporte';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get tabSettings => 'Perfil';

  @override
  String get defaultUserName => 'Amigo';

  @override
  String get courseKindMedication => 'Medicamento';

  @override
  String get courseKindSupplement => 'Suplemento';

  @override
  String get courseFilterAll => 'Todo';

  @override
  String get courseFilterMedications => 'Medicamentos';

  @override
  String get courseFilterSupplements => 'Suplementos';

  @override
  String get homeTakeMedicationNow => 'Tomar este medicamento ahora';

  @override
  String get homeTakeSupplementNow => 'Tomar este suplemento ahora';

  @override
  String get homeEmptyAllTitle => 'No hay medicamentos aún';

  @override
  String get homeEmptyMedicationsTitle => 'No hay medicamentos aún';

  @override
  String get homeEmptySupplementsTitle => 'No hay suplementos aún';

  @override
  String get homeEmptyAllSubtitle =>
      'Nada requiere atención ahora. Puedes revisar otro día o añadir un nuevo curso.';

  @override
  String get homeEmptyMedicationsSubtitle =>
      'No hay medicamentos pendientes hoy. Es un buen momento de pausa.';

  @override
  String get homeEmptySupplementsSubtitle =>
      'No hay suplementos pendientes hoy. Tu rutina está despejada.';

  @override
  String get homeAddSupplementTitle => 'Añadir suplemento';

  @override
  String get homeAddSupplementSubtitle => 'Programa vitaminas y suplementos';

  @override
  String get homeForThisDay => 'Para este día';

  @override
  String get homeMorningRoutine => 'Rutina de mañana';

  @override
  String get homeAfternoonRoutine => 'Rutina de tarde';

  @override
  String get homeEveningRoutine => 'Rutina de noche';

  @override
  String get homeNightRoutine => 'Rutina nocturna';

  @override
  String get homeRoutineSupplementsOnly => 'solo suplementos';

  @override
  String get homeRoutineMedicationsOnly => 'solo medicamentos';

  @override
  String get homeRoutineMixed => 'rutina mixta';

  @override
  String homeRoutineItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artículos',
      one: '1 artículo',
    );
    return '$_temp0';
  }

  @override
  String get homeNeedsAttentionTitle => 'Requiere atención';

  @override
  String homeNeedsAttentionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artículos programados deben revisarse.',
      one: '1 artículo programado debe tomarse o revisarse.',
    );
    return '$_temp0';
  }

  @override
  String get homeNextUpTitle => 'A continuación';

  @override
  String get homeRefillReminderTitle => 'Recordatorio de reposición';

  @override
  String homeRefillReminderSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cursos necesitan reposición pronto.',
      one: '1 curso necesita reposición pronto.',
    );
    return '$_temp0';
  }

  @override
  String get homeEverythingCalmTitle => 'Todo está tranquilo';

  @override
  String get homeEverythingCalmSubtitle => 'No hay tareas urgentes ahora.';

  @override
  String get homeNoUpcomingItem => 'No hay próximos elementos programados.';

  @override
  String homeScheduledFor(String time) {
    return 'Programado para $time';
  }

  @override
  String get calendarToday => 'Hoy';

  @override
  String get calendarSelectedDay => 'Día seleccionado';

  @override
  String get calendarShowingToday => 'Mostrando horario de hoy';

  @override
  String get calendarBrowseNearbyDays => 'Desliza la rueda para ver otros días';

  @override
  String get calendarPreviewAnotherDay =>
      'La rueda te permite previsualizar otro día.';

  @override
  String get calendarDayWheelSemantics => 'Rueda de días';

  @override
  String get analyticsCourseMix => 'Mezcla de cursos';

  @override
  String get analyticsCourseMixSubtitle =>
      'Cursos y suplementos se miden por separado aquí.';

  @override
  String get analyticsCurrentRoutine => 'Rutina actual';

  @override
  String get analyticsCurrentRoutineSubtitle =>
      'Días seguidos sin omitir dosis';

  @override
  String get analyticsTimingAccuracy => 'Precisión de tiempo';

  @override
  String get analyticsTimingAccuracySubtitle => 'Tomado dentro de 30 minutos';

  @override
  String get analyticsBestRoutine => 'Mejor rutina';

  @override
  String get analyticsBestRoutineSubtitle =>
      'Mejor resultado en últimos 90 días';

  @override
  String get analyticsRefillRisk => 'Riesgo de reposición';

  @override
  String get analyticsRefillRiskSubtitle => 'Cursos cerca del umbral';

  @override
  String get analyticsAverageDelay => 'Retraso medio';

  @override
  String get analyticsMinutesShort => 'min';

  @override
  String get analyticsCoachNote => 'Nota del coach';

  @override
  String get analyticsMissedDoses => 'Dosis omitidas';

  @override
  String analyticsActiveShort(int count) {
    return '$count activos';
  }

  @override
  String analyticsTakenMissed(int taken, int missed) {
    return 'Tomadas: $taken  Omitidas: $missed';
  }

  @override
  String get settingsContactSupportTitle => 'Contactar soporte';

  @override
  String get settingsContactSupportBody =>
      'Si algo no funciona, podemos ayudarte. Incluye el modelo de dispositivo y descripción del problema.';

  @override
  String get settingsSupportEmailCopied => 'Correo copiado';

  @override
  String get settingsCopySupportEmail => 'Copiar correo';

  @override
  String get settingsPrivacyTitle => 'Política de privacidad';

  @override
  String get settingsPrivacyBodyPrimary =>
      'Pillora almacena tus datos en tu dispositivo.';

  @override
  String get settingsPrivacyBodySecondary =>
      'Las fotos y reportes se crean solo cuando los usas.';

  @override
  String get settingsPrivacyLaunchNote =>
      'Nota: publica tu política de privacidad.';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageRussian => 'Ruso';

  @override
  String get settingsYourProfilePreferences => 'Tu perfil y preferencias';

  @override
  String get settingsComfortModeTitle => 'Modo confort';

  @override
  String get settingsComfortModeSubtitle =>
      'Textos más grandes y visuales relajados';

  @override
  String get settingsNotificationsEnabled => 'Recordatorios activados';

  @override
  String get settingsOn => 'Activado';

  @override
  String get settingsSupportAndSafety => 'Soporte y seguridad';

  @override
  String get settingsShowOnboardingAgain => 'Mostrar guía inicial de nuevo';

  @override
  String get settingsShowOnboardingAgainSubtitle => 'Abre el tutorial inicial';

  @override
  String get settingsFeaturePolishing => 'Esta función está en desarrollo';

  @override
  String get settingsCaregiverTitle => 'Compartir con cuidador';

  @override
  String get settingsCaregiverDescription =>
      'Añade a una persona de confianza para que los reportes incluyan su contacto.';

  @override
  String get settingsCaregiverName => 'Nombre del cuidador';

  @override
  String get settingsCaregiverRelation => 'Relación';

  @override
  String get settingsCaregiverPhone => 'Número de teléfono';

  @override
  String get settingsCaregiverShareReports => 'Incluir en reportes';

  @override
  String get settingsCaregiverShareReportsSubtitle =>
      'Los reportes pueden incluir su contacto.';

  @override
  String get settingsCaregiverSaved => 'Ajustes de cuidador guardados';

  @override
  String get settingsCaregiverRemoved => 'Cuidador eliminado';

  @override
  String get settingsCaregiverRemove => 'Eliminar cuidador';

  @override
  String get settingsCaregiverEmpty => 'Añade una persona de confianza';

  @override
  String get settingsCaregiverAlertsTitle => 'Alertas para cuidador';

  @override
  String get settingsCaregiverAlertsDescription =>
      'Si una dosis se retrasa, Pillora prepara una alerta para tu cuidador.';

  @override
  String get settingsCaregiverAlertsEmpty => 'Añade un cuidador primero';

  @override
  String get settingsCaregiverAlertsDisabled => 'Las alertas están apagadas';

  @override
  String settingsCaregiverAlertsEnabledSummary(int minutes) {
    return 'Alerta preparada tras $minutes minutos';
  }

  @override
  String get settingsCaregiverAlertsSwitchTitle => 'Preparar alertas';

  @override
  String get settingsCaregiverAlertsSwitchSubtitle =>
      'Pillora preparará un mensaje para enviar.';

  @override
  String get settingsCaregiverAlertsGraceTitle => 'Período de gracia';

  @override
  String settingsCaregiverAlertsGraceDescription(int minutes) {
    return 'Esperar $minutes minutos antes de alertar.';
  }

  @override
  String settingsCaregiverAlertsGraceChip(int minutes) {
    return '$minutes min';
  }

  @override
  String get settingsCaregiverAlertsOverdueTitle => 'Incluir dosis retrasadas';

  @override
  String get settingsCaregiverAlertsOverdueSubtitle =>
      'Preparar alerta cuando una dosis esté pendiente.';

  @override
  String get settingsCaregiverAlertsSkippedTitle => 'Incluir dosis omitidas';

  @override
  String get settingsCaregiverAlertsSkippedSubtitle =>
      'Preparar alerta al omitir una dosis explícitamente.';

  @override
  String get settingsCaregiverAlertsSupplementsTitle => 'Incluir suplementos';

  @override
  String get settingsCaregiverAlertsSupplementsSubtitle =>
      'Usar el mismo flujo para suplementos.';

  @override
  String get settingsCaregiverAlertsSaved => 'Reglas de alerta guardadas';

  @override
  String get settingsCaregiverConnectedTitle => 'Entrega conectada';

  @override
  String get settingsCaregiverConnectedDescription =>
      'Esta capa mantiene un enlace estable para alertas en la nube.';

  @override
  String get settingsCaregiverConnectedReady =>
      'Código listo. No hay alertas en la bandeja de salida.';

  @override
  String settingsCaregiverConnectedPending(int count) {
    return '$count alerta(s) esperando en la bandeja.';
  }

  @override
  String get settingsCaregiverConnectedCodeTitle => 'Código de enlace';

  @override
  String get settingsCaregiverConnectedCodeSubtitle =>
      'Guarda este código para enlazar el dispositivo del cuidador.';

  @override
  String get settingsCaregiverConnectedOutboxTitle => 'Bandeja de salida';

  @override
  String settingsCaregiverConnectedLastQueued(String value) {
    return 'Última en cola: $value';
  }

  @override
  String get settingsCaregiverConnectedCopyCode => 'Copiar código';

  @override
  String get settingsCaregiverConnectedCodeCopied => 'Código copiado';

  @override
  String get settingsCaregiverConnectedClearOutbox => 'Vaciar bandeja';

  @override
  String get settingsCaregiverConnectedOutboxCleared => 'Bandeja vaciada';

  @override
  String get settingsCaregiverConnectedCloudTitle => 'Modo de enlace en nube';

  @override
  String get settingsCaregiverConnectedModePatient =>
      'Este dispositivo actúa como paciente.';

  @override
  String settingsCaregiverConnectedModeCaregiver(String patientName) {
    return 'Este dispositivo está enlazado como cuidador para $patientName.';
  }

  @override
  String get settingsCaregiverConnectedModeNone =>
      'No hay enlace en la nube activo.';

  @override
  String settingsCaregiverConnectedCloudCode(String code) {
    return 'Código enlazado: $code';
  }

  @override
  String get settingsCaregiverConnectedInboxTitle => 'Bandeja de entrada';

  @override
  String get settingsCaregiverConnectedInboxEmpty =>
      'No hay alertas en la nube ahora.';

  @override
  String get settingsCaregiverConnectedUsePatientDevice =>
      'Usar este dispositivo como paciente';

  @override
  String get settingsCaregiverConnectedPatientModeSaved =>
      'Dispositivo enlazado como paciente';

  @override
  String get settingsCaregiverConnectedUseCaregiverDevice =>
      'Conectar como cuidador';

  @override
  String get settingsCaregiverConnectedJoinTitle => 'Unirse como cuidador';

  @override
  String get settingsCaregiverConnectedJoinSubtitle =>
      'Introduce el código del paciente.';

  @override
  String get settingsCaregiverConnectedJoinAction => 'Conectar';

  @override
  String get settingsCaregiverConnectedCaregiverModeSaved =>
      'Dispositivo enlazado como cuidador';

  @override
  String get settingsCaregiverConnectedJoinFailed => 'Código no encontrado';

  @override
  String get settingsCaregiverConnectedDisconnect => 'Desconectar';

  @override
  String get settingsCaregiverConnectedDisconnected =>
      'Dispositivo desconectado.';

  @override
  String get caregiverCloudNotificationTitle => 'Alerta de cuidador';

  @override
  String get caregiverAlertCardTitle => 'Alerta lista';

  @override
  String caregiverAlertCardSubtitle(String caregiverName, int count) {
    return '$caregiverName puede ser notificado sobre $count artículo(s).';
  }

  @override
  String get caregiverAlertReviewAction => 'Revisar y copiar';

  @override
  String get caregiverAlertSheetTitle => 'Alerta de cuidador';

  @override
  String caregiverAlertSheetSubtitle(String caregiverName, int count) {
    return 'Pillora preparó un mensaje para $caregiverName sobre $count artículo(s).';
  }

  @override
  String caregiverAlertReasonOverdue(int minutes) {
    return 'Tarde por $minutes min';
  }

  @override
  String get caregiverAlertReasonSkipped => 'Omitido';

  @override
  String caregiverAlertItemSchedule(String time, String reason) {
    return 'Programado $time. $reason.';
  }

  @override
  String get caregiverAlertManualShareNote =>
      'Copia esta alerta y envíala a tu cuidador.';

  @override
  String get caregiverAlertCopyMessage => 'Copiar texto de alerta';

  @override
  String get caregiverAlertCopyPhone => 'Copiar teléfono';

  @override
  String get caregiverAlertNoPhone => 'Añade el teléfono en Ajustes';

  @override
  String get caregiverAlertMessageCopied => 'Alerta copiada';

  @override
  String get caregiverAlertPhoneCopied => 'Teléfono copiado';

  @override
  String caregiverAlertMessageGreeting(String caregiverName) {
    return 'Hola, $caregiverName.';
  }

  @override
  String caregiverAlertMessageIntro(String patientName) {
    return 'Pillora preparó esta actualización para $patientName:';
  }

  @override
  String caregiverAlertMessageLineOverdue(
    String courseName,
    String time,
    int minutes,
  ) {
    return '$courseName — programado $time, retraso de $minutes min';
  }

  @override
  String caregiverAlertMessageLineSkipped(String courseName, String time) {
    return '$courseName — programado $time, omitido';
  }

  @override
  String get caregiverAlertMessageFooter => 'Comprueba si se necesita ayuda.';

  @override
  String get settingsSupportEmailSubtitle => 'Correo de soporte';

  @override
  String get settingsPrivacySubtitle => 'Cómo se manejan tus datos';

  @override
  String get settingsExampleName => 'Por ejemplo, Alex';

  @override
  String get settingsSave => 'Guardar';

  @override
  String get onboardingStartUsing => 'Empezar a usar Pillora';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingBack => 'Atrás';

  @override
  String get onboardingWelcomeTitle => 'Pillora te ayuda a mantener el rumbo';

  @override
  String get onboardingWelcomeTagline => 'Calmado, claro y enfocado.';

  @override
  String get onboardingWelcomeBody =>
      'Al abrir la app, verás qué tomar ahora y qué sigue.';

  @override
  String get onboardingFeatureEasyInterface =>
      'Interfaz amplia y fácil de leer';

  @override
  String get onboardingFeatureNextDose => 'Enfoque en la próxima dosis';

  @override
  String get onboardingFeatureReminders => 'Recordatorios y control de stock';

  @override
  String get onboardingTailorTitle => 'Permítenos adaptar la app para ti';

  @override
  String get onboardingTailorSubtitle =>
      'Puedes cambiar esto después en el Perfil.';

  @override
  String get onboardingNamePrompt => '¿Cómo deberíamos llamarte?';

  @override
  String get onboardingLanguageTitle => 'Idioma';

  @override
  String get onboardingReadingComfort => 'Comodidad de lectura';

  @override
  String get onboardingComfortModeTitle => 'Modo confort';

  @override
  String get onboardingComfortModeSubtitle =>
      'Texto más grande y menos ruido visual.';

  @override
  String get onboardingReadyTitle => 'Todo listo';

  @override
  String get onboardingReadyBanner =>
      'La primera pantalla muestra qué tomar y cuándo.';

  @override
  String get onboardingReadyBody =>
      'La pantalla principal prioriza la atención. Las estadísticas están en otra pestaña.';

  @override
  String get onboardingReadySummaryHome => 'Una pantalla de inicio más simple';

  @override
  String get onboardingReadySummaryActions =>
      'Acciones claras: tomar, omitir, añadir';

  @override
  String get onboardingReadySummaryComfortOn => 'Modo confort activado';

  @override
  String get onboardingReadySummaryComfortLater =>
      'Modo confort ajustable en Perfil';

  @override
  String get medicineStandardCourse => 'Curso estándar';

  @override
  String get medicineComplexCourse => 'Curso complejo';

  @override
  String get schedulePreviewTitle => 'Vista previa';

  @override
  String get scheduleDoseAtTime => 'Dosis en esta hora';

  @override
  String get courseTypeLabel => 'Tipo de curso';

  @override
  String get addSupplementScreenTitle => 'Añadir suplemento';

  @override
  String get editSupplementTitle => 'Editar suplemento';

  @override
  String get settingsLanguageChangeLater =>
      'Puedes cambiarlo después en el Perfil';

  @override
  String get homeNothingDueTitle => 'Nada pendiente ahora';

  @override
  String get homeUseDayWheelSubtitle =>
      'Usa la rueda de días para revisar otras fechas.';

  @override
  String get homeNoAttentionRightNow =>
      'No hay medicamentos pendientes ahora mismo.';

  @override
  String get homeAddItemFab => 'Añadir medicación o medida';

  @override
  String get homeTimelineSubtitle => 'Ordenados por hora.';

  @override
  String get analyticsCoachGreat => 'Estás construyendo una buena rutina.';

  @override
  String get analyticsCoachMissed =>
      'La mayoría de omisiones es por inconsistencia.';

  @override
  String get analyticsCoachTiming =>
      'Tu rutina mejora. Busca mejor precisión de tiempo.';

  @override
  String get medicineFrequencyDaily => 'Diario';

  @override
  String get medicineFrequencySpecificDays => 'Días específicos';

  @override
  String get medicineFrequencyInterval => 'Intervalo';

  @override
  String get medicineFrequencyCycle => 'Ciclo';

  @override
  String get medicineFormTablet => 'Tableta';

  @override
  String get medicineFormCapsule => 'Cápsula';

  @override
  String get medicineFormLiquid => 'Líquido';

  @override
  String get medicineFormInjection => 'Inyección';

  @override
  String get medicineFormDrops => 'Gotas';

  @override
  String get medicineFormOintment => 'Pomada';

  @override
  String get medicineFormSpray => 'Spray';

  @override
  String get medicineFormInhaler => 'Inhalador';

  @override
  String get medicineFormPatch => 'Parche';

  @override
  String get medicineFormSuppository => 'Supositorio';

  @override
  String get medicineTimelineSupplementInfo =>
      'Aparece en la línea de tiempo compartida.';

  @override
  String get medicineTimelineMedicationInfo =>
      'Parte de tu plan de tratamiento principal.';

  @override
  String get medicineDoseScheduleTitle => 'Horario de dosis';

  @override
  String get medicineDoseScheduleSubtitle =>
      'El próximo día con su hora y dosis.';

  @override
  String get medicineHistoryLoadError => 'Error';

  @override
  String get scheduleDoseTabletsAtTime => 'Pastillas en esta hora';

  @override
  String get scheduleDoseAmountAtTime => 'Dosis en esta hora';

  @override
  String get schedulePreviewFutureRebuilt =>
      'Se usarán estos horarios en el futuro.';

  @override
  String get scheduleComplexTitle => 'Horario complejo';

  @override
  String get scheduleComplexEditSubtitle =>
      'Puedes editar la dosis y hora de cada etapa.';

  @override
  String get courseTimelineSupplementInfo =>
      'Se mantiene en la categoría de bienestar.';

  @override
  String get courseTimelineMedicationInfo =>
      'Se mantiene en la categoría médica.';

  @override
  String get supplementNameHint => 'Nombre del suplemento (ej. Magnesio)';

  @override
  String get addDoseAction => 'Añadir dosis';

  @override
  String get addConditionSuggestionsTitle => 'Sugerencias por condición';

  @override
  String get addConditionSuggestionsSubtitle =>
      'Plantillas comunes. Revisa tu receta médica.';

  @override
  String get addConditionSuggestionsEmpty =>
      'No hay más sugerencias para esta condición.';

  @override
  String get addFlowSupplementTitle => '¿Cómo quieres añadir este suplemento?';

  @override
  String get addFlowMedicationTitle => '¿Cómo quieres empezar?';

  @override
  String get addFlowSupplementSubtitle =>
      'Puedes usar plantillas rápidas si encajan.';

  @override
  String get addFlowMedicationSubtitle => 'Elige la vía más fácil.';

  @override
  String get addFlowByConditionTitle => 'Por condición';

  @override
  String get addFlowByConditionSubtitle =>
      'Plantillas comunes para condiciones';

  @override
  String get addFlowQuickTemplateTitle => 'Plantilla rápida';

  @override
  String get addFlowQuickTemplateSubtitle => 'Usa un curso ya hecho';

  @override
  String get addFlowManualTitle => 'Manual';

  @override
  String get addFlowManualSubtitle => 'Rellena el curso desde cero';

  @override
  String get addAppearanceTitle => 'Apariencia';

  @override
  String get addAppearanceSubtitle => 'Añade foto o personaliza la pastilla.';

  @override
  String get addPhotoLabel => 'Foto';

  @override
  String get addQuickStartTitle => 'Inicio rápido';

  @override
  String get addQuickStartSubtitle => 'Usa una plantilla común.';

  @override
  String get addSkipTemplate => 'Saltar';

  @override
  String get addUseTemplate => 'Usar plantilla';

  @override
  String get addRecommendedMetricsTitle => 'Métricas recomendadas';

  @override
  String get addRecommendedMetricsSubtitle =>
      'Registradas junto a esta condición.';

  @override
  String get addSupplementTimelineInfo => 'Aparecerá junto a los medicamentos.';

  @override
  String get addMedicationTimelineInfo => 'Aparecerá en el cronograma diario.';

  @override
  String get conditionDiabetesTitle => 'Diabetes';

  @override
  String get conditionDiabetesSubtitle => 'Patrones comunes a largo plazo';

  @override
  String get conditionHypertensionTitle => 'Hipertensión';

  @override
  String get conditionHypertensionSubtitle => 'Presión arterial';

  @override
  String get conditionCholesterolTitle => 'Colesterol alto';

  @override
  String get conditionCholesterolSubtitle => 'Terapia lipídica nocturna';

  @override
  String get conditionThyroidTitle => 'Hipotiroidismo';

  @override
  String get conditionThyroidSubtitle => 'Reemplazo tiroideo matutino';

  @override
  String get conditionGerdTitle => 'Reflujo ácido';

  @override
  String get conditionGerdSubtitle => 'Control de acidez';

  @override
  String get conditionAsthmaTitle => 'Asma';

  @override
  String get conditionAsthmaSubtitle => 'Inhaladores';

  @override
  String get conditionAllergyTitle => 'Alergia';

  @override
  String get conditionAllergySubtitle => 'Antihistamínicos';

  @override
  String get conditionHeartPreventionTitle => 'Prevención cardíaca';

  @override
  String get conditionHeartPreventionSubtitle => 'Cardiología a largo plazo';

  @override
  String get conditionHeartFailureTitle => 'Insuficiencia cardíaca';

  @override
  String get conditionHeartFailureSubtitle => 'Apoyo de fluidos y presión';

  @override
  String get conditionAtrialFibrillationTitle => 'Fibrilación auricular';

  @override
  String get conditionAtrialFibrillationSubtitle =>
      'Ritmo y prevención de derrames';

  @override
  String get conditionJointPainTitle => 'Dolor articular';

  @override
  String get conditionJointPainSubtitle => 'Control de dolor e inflamación';

  @override
  String get conditionBphTitle => 'Próstata / HBP';

  @override
  String get conditionBphSubtitle => 'Control urinario';

  @override
  String get conditionOsteoporosisTitle => 'Osteoporosis';

  @override
  String get conditionOsteoporosisSubtitle => 'Apoyo óseo';

  @override
  String get conditionAnemiaTitle => 'Anemia / Deficiencia de hierro';

  @override
  String get conditionAnemiaSubtitle => 'Patrones de hierro';

  @override
  String get suggestionMetforminName => 'Metformina';

  @override
  String get suggestionMetforminNote =>
      'Terapia oral típica. Confirma dosis con receta.';

  @override
  String get suggestionInsulinName => 'Insulina';

  @override
  String get suggestionInsulinNote =>
      'Plantilla de inyección. Ajusta el tipo y hora.';

  @override
  String get suggestionAmlodipineName => 'Amlodipino';

  @override
  String get suggestionAmlodipineNote => 'Control de presión arterial diario.';

  @override
  String get suggestionLosartanName => 'Losartán';

  @override
  String get suggestionLosartanNote =>
      'Usado para terapia diaria a largo plazo.';

  @override
  String get suggestionAtorvastatinName => 'Atorvastatina';

  @override
  String get suggestionAtorvastatinNote =>
      'Plantilla común de estatina diaria.';

  @override
  String get suggestionLevothyroxineName => 'Levotiroxina';

  @override
  String get suggestionLevothyroxineNote =>
      'Se toma por la mañana antes de comer.';

  @override
  String get suggestionOmeprazoleName => 'Omeprazol';

  @override
  String get suggestionOmeprazoleNote => 'Tomado por la mañana antes de comer.';

  @override
  String get suggestionFamotidineName => 'Famotidina';

  @override
  String get suggestionFamotidineNote =>
      'Usado para acidez, a menudo en la noche.';

  @override
  String get suggestionBudesonideFormoterolName => 'Budesonida/Formoterol';

  @override
  String get suggestionBudesonideFormoterolNote =>
      'Inhalador de mantenimiento.';

  @override
  String get suggestionAlbuterolName => 'Salbutamol';

  @override
  String get suggestionAlbuterolNote => 'Inhalador de rescate (SOS).';

  @override
  String get suggestionCetirizineName => 'Cetirizina';

  @override
  String get suggestionCetirizineNote => 'Tomado una vez al día para alergias.';

  @override
  String get suggestionLoratadineName => 'Loratadina';

  @override
  String get suggestionLoratadineNote => 'Antihistamínico diurno común.';

  @override
  String get suggestionAspirinName => 'Aspirina';

  @override
  String get suggestionAspirinNote => 'Prevención cardiovascular (dosis baja).';

  @override
  String get suggestionClopidogrelName => 'Clopidogrel';

  @override
  String get suggestionClopidogrelNote => 'Terapia antiplaquetaria diaria.';

  @override
  String get suggestionFurosemideName => 'Furosemida';

  @override
  String get suggestionFurosemideNote => 'Diurético tomado temprano en el día.';

  @override
  String get suggestionSpironolactoneName => 'Espironolactona';

  @override
  String get suggestionSpironolactoneNote => 'Terapia de apoyo diaria.';

  @override
  String get suggestionApixabanName => 'Apixaban';

  @override
  String get suggestionApixabanNote => 'Anticoagulante dos veces al día.';

  @override
  String get suggestionMetoprololName => 'Metoprolol';

  @override
  String get suggestionMetoprololNote => 'Control de ritmo cardíaco.';

  @override
  String get suggestionIbuprofenName => 'Ibuprofeno';

  @override
  String get suggestionIbuprofenNote => 'Alivio del dolor a corto plazo.';

  @override
  String get suggestionDiclofenacGelName => 'Diclofenaco gel';

  @override
  String get suggestionDiclofenacGelNote => 'Alivio antiinflamatorio tópico.';

  @override
  String get suggestionTamsulosinName => 'Tamsulosina';

  @override
  String get suggestionTamsulosinNote =>
      'Se toma en la noche después de comer.';

  @override
  String get suggestionFinasterideName => 'Finasterida';

  @override
  String get suggestionFinasterideNote => 'Apoyo a largo plazo diario.';

  @override
  String get suggestionAlendronateName => 'Alendronato';

  @override
  String get suggestionAlendronateNote => 'Tomado semanalmente por la mañana.';

  @override
  String get suggestionCalciumVitaminDName => 'Calcio + Vitamina D';

  @override
  String get suggestionCalciumVitaminDNote => 'Rutina común de apoyo óseo.';

  @override
  String get suggestionFerrousSulfateName => 'Sulfato ferroso';

  @override
  String get suggestionFerrousSulfateNote =>
      'Plantilla de reemplazo de hierro oral.';

  @override
  String get suggestionFolicAcidName => 'Ácido fólico';

  @override
  String get suggestionFolicAcidNote => 'Vitamina de apoyo común.';

  @override
  String get pdfDoctorReportTitle => 'Informe médico';

  @override
  String get pdfSupplementCourseSummary => 'Resumen del curso de suplemento';

  @override
  String get pdfMedicationCourseSummary => 'Resumen del curso de medicación';

  @override
  String get pdfCourseProfileTitle => 'Perfil del curso';

  @override
  String get pdfScheduleSnapshotTitle => 'Vista de horario';

  @override
  String get pdfScheduleSnapshotSubtitle =>
      'Día representativo con hora y dosis.';

  @override
  String get pdfAdministrationHistoryTitle => 'Historial de administración';

  @override
  String get pdfAdministrationHistorySubtitle =>
      'Muestra las tomas realizadas.';

  @override
  String get pdfAdherenceLabel => 'Adherencia';

  @override
  String get pdfSnoozedLabel => 'Pospuesto';

  @override
  String get pdfClinicalSummaryTitle => 'Resumen clínico';

  @override
  String get pdfPatientLabel => 'Paciente';

  @override
  String get pdfCaregiverLabel => 'Cuidador';

  @override
  String get pdfReportPeriodLabel => 'Período';

  @override
  String get pdfOnTimeRateLabel => 'Tasa a tiempo';

  @override
  String get pdfAverageDelayLabel => 'Retraso medio';

  @override
  String get pdfUpcomingDosesLabel => 'Próximas dosis';

  @override
  String get pdfStockLeftLabel => 'Stock restante';

  @override
  String get pdfNameLabel => 'Nombre';

  @override
  String get pdfCourseTypeLabel => 'Tipo de curso';

  @override
  String get pdfDosageLabel => 'Dosis';

  @override
  String get pdfFrequencyLabel => 'Frecuencia';

  @override
  String get pdfStartedLabel => 'Iniciado';

  @override
  String get pdfInstructionLabel => 'Instrucción';

  @override
  String get pdfNotesLabel => 'Notas';

  @override
  String get pdfTimelineEmpty => 'No hay historial aún.';

  @override
  String pdfTimelineTruncated(int visible, int total) {
    return 'Este PDF muestra $visible entradas de $total.';
  }

  @override
  String get pdfTableScheduled => 'Programado';

  @override
  String get pdfTableActual => 'Real';

  @override
  String get pdfTableDose => 'Dosis';

  @override
  String get pdfTableStatus => 'Estado';

  @override
  String get pdfTableDelay => 'Retraso';

  @override
  String get pdfOnTime => 'A tiempo';

  @override
  String get pdfMinuteShort => 'min';

  @override
  String get pdfNoFoodRestriction => 'Sin restricción de comida';

  @override
  String get homeEmptyAddMedicinePrompt =>
      'Añade una medicación o suplemento para verlo aquí.';

  @override
  String get tabScanner => 'Escáner';

  @override
  String get scannerComingSoonTitle => 'Escáner Inteligente';

  @override
  String get scannerComingSoonText =>
      'Apunta con la cámara para rellenar los datos. ¡Disponible en la próxima actualización!';

  @override
  String get premiumTitle => 'Pillora Pro';

  @override
  String get premiumSubtitle => 'Desbloquea todo el potencial de tu rutina';

  @override
  String get premiumFeatureCaregiver => 'Cuidadores ilimitados y alertas';

  @override
  String get premiumFeatureScanner => 'Escáner inteligente rápido';

  @override
  String get premiumFeatureSchedules => 'Horarios complejos (Ciclos)';

  @override
  String get premiumFeatureReports => 'Exportar informes PDF';

  @override
  String get premiumSubscribeYearly => 'Desbloquear Pro por 29.99\$ / año';

  @override
  String get premiumSubscribeMonthly => 'o 4.99\$ / mes';

  @override
  String get premiumRestorePurchases => 'Restaurar compras';
}
