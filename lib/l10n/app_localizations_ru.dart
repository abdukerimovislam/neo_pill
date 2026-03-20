// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'AI Менеджер Лекарств';

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
  String get pillsRemaining => 'Остаток таблеток';

  @override
  String get deleteCourse => 'Удалить курс';

  @override
  String get deleteConfirmation =>
      'Вы уверены, что хотите удалить это лекарство и все его напоминания?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get timeOfDay => 'Время приема';

  @override
  String get courseDuration => 'Длительность курса (дней)';

  @override
  String get pillsInPackage => 'Таблеток в упаковке';

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
  String get doctorReport => 'Отчет для врача';

  @override
  String get generatingReport => 'Создание отчета...';

  @override
  String errorGeneratingReport(String error) {
    return 'Ошибка создания PDF: $error';
  }

  @override
  String get editCourse => 'Редактировать курс';

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
  String get takeNowAction => 'Принять';

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
}
