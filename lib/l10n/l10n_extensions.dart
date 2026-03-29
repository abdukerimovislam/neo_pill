import 'package:flutter/material.dart';

import '../data/local/entities/medicine_entity.dart';
import 'app_localizations.dart';

extension AppLocalizationsX on AppLocalizations {
  String courseKindLabel(CourseKindEnum kind) {
    return switch (kind) {
      CourseKindEnum.medication => courseKindMedication,
      CourseKindEnum.supplement => courseKindSupplement,
    };
  }

  String courseFilterLabel(bool supplementsOnly, bool medicationsOnly) {
    if (supplementsOnly) {
      return homeRoutineSupplementsOnly;
    }
    if (medicationsOnly) {
      return homeRoutineMedicationsOnly;
    }
    return homeRoutineMixed;
  }

  String medicineFormLabel(MedicineFormEnum form) {
    return switch (form) {
      MedicineFormEnum.pill => medicineFormTablet,
      MedicineFormEnum.capsule => medicineFormCapsule,
      MedicineFormEnum.liquid => medicineFormLiquid,
      MedicineFormEnum.injection => medicineFormInjection,
      MedicineFormEnum.drops => medicineFormDrops,
      MedicineFormEnum.ointment => medicineFormOintment,
      MedicineFormEnum.spray => medicineFormSpray,
      MedicineFormEnum.inhaler => medicineFormInhaler,
      MedicineFormEnum.patch => medicineFormPatch,
      MedicineFormEnum.suppository => medicineFormSuppository,
    };
  }

  String frequencyLabel(FrequencyTypeEnum frequency) {
    return switch (frequency) {
      FrequencyTypeEnum.daily => medicineFrequencyDaily,
      FrequencyTypeEnum.asNeeded => asNeededFrequency,
      FrequencyTypeEnum.specificDays => medicineFrequencySpecificDays,
      FrequencyTypeEnum.interval => medicineFrequencyInterval,
      FrequencyTypeEnum.cycle => medicineFrequencyCycle,
      FrequencyTypeEnum.tapering => taperingFrequency,
    };
  }

  String foodInstructionLabel(FoodInstructionEnum food) {
    return switch (food) {
      FoodInstructionEnum.noMatter => foodNoMatter,
      FoodInstructionEnum.beforeFood => foodBefore,
      FoodInstructionEnum.withFood => foodWith,
      FoodInstructionEnum.afterFood => foodAfter,
    };
  }

  String dosageUnitLabel(String unit) {
    return switch (unit.toLowerCase()) {
      'mg' => dosageUnitMg,
      'ml' => dosageUnitMl,
      'drops' => dosageUnitDrops,
      'pcs' => dosageUnitPcs,
      'g' => dosageUnitG,
      'mcg' => dosageUnitMcg,
      'iu' => dosageUnitIu,
      _ => unit,
    };
  }
}

extension AppLocalizationsLookupX on Locale {
  AppLocalizations get l10n => lookupAppLocalizations(this);
}
