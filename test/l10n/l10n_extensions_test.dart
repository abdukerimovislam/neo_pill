import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';
import 'package:neo_pill/l10n/app_localizations.dart';
import 'package:neo_pill/l10n/l10n_extensions.dart';

void main() {
  group('AppLocalizationsX', () {
    test('returns Russian localized labels for common enums and units', () {
      final l10n = lookupAppLocalizations(const Locale('ru'));

      expect(l10n.courseKindLabel(CourseKindEnum.supplement), 'БАД');
      expect(l10n.medicineFormLabel(MedicineFormEnum.inhaler), 'Ингалятор');
      expect(
        l10n.foodInstructionLabel(FoodInstructionEnum.afterFood),
        'После еды',
      );
      expect(l10n.dosageUnitLabel('mg'), 'мг');
      expect(l10n.dosageUnitLabel('IU'), 'МЕ');
      expect(l10n.frequencyLabel(FrequencyTypeEnum.asNeeded), 'ПО ПОТРЕБНОСТИ');
    });

    test('falls back to raw unit for unknown dosage unit', () {
      final l10n = lookupAppLocalizations(const Locale('en'));

      expect(l10n.dosageUnitLabel('tablet-pack'), 'tablet-pack');
    });
  });
}
