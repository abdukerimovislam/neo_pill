// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMedicineEntityCollection on Isar {
  IsarCollection<MedicineEntity> get medicineEntitys => this.collection();
}

const MedicineEntitySchema = CollectionSchema(
  name: r'MedicineEntity',
  id: 8310283481198513094,
  properties: {
    r'cycleOffDays': PropertySchema(
      id: 0,
      name: r'cycleOffDays',
      type: IsarType.long,
    ),
    r'cycleOnDays': PropertySchema(
      id: 1,
      name: r'cycleOnDays',
      type: IsarType.long,
    ),
    r'dosage': PropertySchema(
      id: 2,
      name: r'dosage',
      type: IsarType.double,
    ),
    r'dosageUnit': PropertySchema(
      id: 3,
      name: r'dosageUnit',
      type: IsarType.string,
    ),
    r'endDate': PropertySchema(
      id: 4,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'foodInstruction': PropertySchema(
      id: 5,
      name: r'foodInstruction',
      type: IsarType.byte,
      enumMap: _MedicineEntityfoodInstructionEnumValueMap,
    ),
    r'form': PropertySchema(
      id: 6,
      name: r'form',
      type: IsarType.byte,
      enumMap: _MedicineEntityformEnumValueMap,
    ),
    r'frequency': PropertySchema(
      id: 7,
      name: r'frequency',
      type: IsarType.byte,
      enumMap: _MedicineEntityfrequencyEnumValueMap,
    ),
    r'instructions': PropertySchema(
      id: 8,
      name: r'instructions',
      type: IsarType.string,
    ),
    r'intervalDays': PropertySchema(
      id: 9,
      name: r'intervalDays',
      type: IsarType.long,
    ),
    r'isPaused': PropertySchema(
      id: 10,
      name: r'isPaused',
      type: IsarType.bool,
    ),
    r'kind': PropertySchema(
      id: 11,
      name: r'kind',
      type: IsarType.byte,
      enumMap: _MedicineEntitykindEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 13,
      name: r'notes',
      type: IsarType.string,
    ),
    r'notificationBody': PropertySchema(
      id: 14,
      name: r'notificationBody',
      type: IsarType.string,
    ),
    r'notificationTitle': PropertySchema(
      id: 15,
      name: r'notificationTitle',
      type: IsarType.string,
    ),
    r'pillColor': PropertySchema(
      id: 16,
      name: r'pillColor',
      type: IsarType.long,
    ),
    r'pillImagePath': PropertySchema(
      id: 17,
      name: r'pillImagePath',
      type: IsarType.string,
    ),
    r'pillShape': PropertySchema(
      id: 18,
      name: r'pillShape',
      type: IsarType.byte,
      enumMap: _MedicineEntitypillShapeEnumValueMap,
    ),
    r'pillsInPackage': PropertySchema(
      id: 19,
      name: r'pillsInPackage',
      type: IsarType.long,
    ),
    r'pillsRemaining': PropertySchema(
      id: 20,
      name: r'pillsRemaining',
      type: IsarType.long,
    ),
    r'prnMaxDailyDoses': PropertySchema(
      id: 21,
      name: r'prnMaxDailyDoses',
      type: IsarType.long,
    ),
    r'refillAlertThreshold': PropertySchema(
      id: 22,
      name: r'refillAlertThreshold',
      type: IsarType.long,
    ),
    r'regularTimeStrings': PropertySchema(
      id: 23,
      name: r'regularTimeStrings',
      type: IsarType.stringList,
    ),
    r'selectedWeekDays': PropertySchema(
      id: 24,
      name: r'selectedWeekDays',
      type: IsarType.longList,
    ),
    r'startDate': PropertySchema(
      id: 25,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'syncId': PropertySchema(
      id: 26,
      name: r'syncId',
      type: IsarType.string,
    ),
    r'taperingSteps': PropertySchema(
      id: 27,
      name: r'taperingSteps',
      type: IsarType.objectList,
      target: r'TaperingStep',
    ),
    r'timesPerDay': PropertySchema(
      id: 28,
      name: r'timesPerDay',
      type: IsarType.long,
    )
  },
  estimateSize: _medicineEntityEstimateSize,
  serialize: _medicineEntitySerialize,
  deserialize: _medicineEntityDeserialize,
  deserializeProp: _medicineEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'syncId': IndexSchema(
      id: 7538593479801827566,
      name: r'syncId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'syncId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'TaperingStep': TaperingStepSchema},
  getId: _medicineEntityGetId,
  getLinks: _medicineEntityGetLinks,
  attach: _medicineEntityAttach,
  version: '3.1.0+1',
);

int _medicineEntityEstimateSize(
  MedicineEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dosageUnit.length * 3;
  {
    final value = object.instructions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notificationBody;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notificationTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pillImagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.regularTimeStrings;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.selectedWeekDays;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  bytesCount += 3 + object.syncId.length * 3;
  {
    final list = object.taperingSteps;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TaperingStep]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TaperingStepSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _medicineEntitySerialize(
  MedicineEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cycleOffDays);
  writer.writeLong(offsets[1], object.cycleOnDays);
  writer.writeDouble(offsets[2], object.dosage);
  writer.writeString(offsets[3], object.dosageUnit);
  writer.writeDateTime(offsets[4], object.endDate);
  writer.writeByte(offsets[5], object.foodInstruction.index);
  writer.writeByte(offsets[6], object.form.index);
  writer.writeByte(offsets[7], object.frequency.index);
  writer.writeString(offsets[8], object.instructions);
  writer.writeLong(offsets[9], object.intervalDays);
  writer.writeBool(offsets[10], object.isPaused);
  writer.writeByte(offsets[11], object.kind.index);
  writer.writeString(offsets[12], object.name);
  writer.writeString(offsets[13], object.notes);
  writer.writeString(offsets[14], object.notificationBody);
  writer.writeString(offsets[15], object.notificationTitle);
  writer.writeLong(offsets[16], object.pillColor);
  writer.writeString(offsets[17], object.pillImagePath);
  writer.writeByte(offsets[18], object.pillShape.index);
  writer.writeLong(offsets[19], object.pillsInPackage);
  writer.writeLong(offsets[20], object.pillsRemaining);
  writer.writeLong(offsets[21], object.prnMaxDailyDoses);
  writer.writeLong(offsets[22], object.refillAlertThreshold);
  writer.writeStringList(offsets[23], object.regularTimeStrings);
  writer.writeLongList(offsets[24], object.selectedWeekDays);
  writer.writeDateTime(offsets[25], object.startDate);
  writer.writeString(offsets[26], object.syncId);
  writer.writeObjectList<TaperingStep>(
    offsets[27],
    allOffsets,
    TaperingStepSchema.serialize,
    object.taperingSteps,
  );
  writer.writeLong(offsets[28], object.timesPerDay);
}

MedicineEntity _medicineEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicineEntity();
  object.cycleOffDays = reader.readLongOrNull(offsets[0]);
  object.cycleOnDays = reader.readLongOrNull(offsets[1]);
  object.dosage = reader.readDouble(offsets[2]);
  object.dosageUnit = reader.readString(offsets[3]);
  object.endDate = reader.readDateTimeOrNull(offsets[4]);
  object.foodInstruction = _MedicineEntityfoodInstructionValueEnumMap[
          reader.readByteOrNull(offsets[5])] ??
      FoodInstructionEnum.noMatter;
  object.form =
      _MedicineEntityformValueEnumMap[reader.readByteOrNull(offsets[6])] ??
          MedicineFormEnum.pill;
  object.frequency =
      _MedicineEntityfrequencyValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          FrequencyTypeEnum.daily;
  object.id = id;
  object.instructions = reader.readStringOrNull(offsets[8]);
  object.intervalDays = reader.readLongOrNull(offsets[9]);
  object.isPaused = reader.readBool(offsets[10]);
  object.kind =
      _MedicineEntitykindValueEnumMap[reader.readByteOrNull(offsets[11])] ??
          CourseKindEnum.medication;
  object.name = reader.readString(offsets[12]);
  object.notes = reader.readStringOrNull(offsets[13]);
  object.notificationBody = reader.readStringOrNull(offsets[14]);
  object.notificationTitle = reader.readStringOrNull(offsets[15]);
  object.pillColor = reader.readLong(offsets[16]);
  object.pillImagePath = reader.readStringOrNull(offsets[17]);
  object.pillShape = _MedicineEntitypillShapeValueEnumMap[
          reader.readByteOrNull(offsets[18])] ??
      PillShapeEnum.circle;
  object.pillsInPackage = reader.readLong(offsets[19]);
  object.pillsRemaining = reader.readLong(offsets[20]);
  object.prnMaxDailyDoses = reader.readLongOrNull(offsets[21]);
  object.refillAlertThreshold = reader.readLong(offsets[22]);
  object.regularTimeStrings = reader.readStringList(offsets[23]);
  object.selectedWeekDays = reader.readLongList(offsets[24]);
  object.startDate = reader.readDateTime(offsets[25]);
  object.syncId = reader.readString(offsets[26]);
  object.taperingSteps = reader.readObjectList<TaperingStep>(
    offsets[27],
    TaperingStepSchema.deserialize,
    allOffsets,
    TaperingStep(),
  );
  object.timesPerDay = reader.readLong(offsets[28]);
  return object;
}

P _medicineEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (_MedicineEntityfoodInstructionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          FoodInstructionEnum.noMatter) as P;
    case 6:
      return (_MedicineEntityformValueEnumMap[reader.readByteOrNull(offset)] ??
          MedicineFormEnum.pill) as P;
    case 7:
      return (_MedicineEntityfrequencyValueEnumMap[
              reader.readByteOrNull(offset)] ??
          FrequencyTypeEnum.daily) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (_MedicineEntitykindValueEnumMap[reader.readByteOrNull(offset)] ??
          CourseKindEnum.medication) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (_MedicineEntitypillShapeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PillShapeEnum.circle) as P;
    case 19:
      return (reader.readLong(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLong(offset)) as P;
    case 23:
      return (reader.readStringList(offset)) as P;
    case 24:
      return (reader.readLongList(offset)) as P;
    case 25:
      return (reader.readDateTime(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readObjectList<TaperingStep>(
        offset,
        TaperingStepSchema.deserialize,
        allOffsets,
        TaperingStep(),
      )) as P;
    case 28:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MedicineEntityfoodInstructionEnumValueMap = {
  'noMatter': 0,
  'beforeFood': 1,
  'withFood': 2,
  'afterFood': 3,
};
const _MedicineEntityfoodInstructionValueEnumMap = {
  0: FoodInstructionEnum.noMatter,
  1: FoodInstructionEnum.beforeFood,
  2: FoodInstructionEnum.withFood,
  3: FoodInstructionEnum.afterFood,
};
const _MedicineEntityformEnumValueMap = {
  'pill': 0,
  'capsule': 1,
  'liquid': 2,
  'injection': 3,
  'drops': 4,
  'ointment': 5,
  'spray': 6,
  'inhaler': 7,
  'patch': 8,
  'suppository': 9,
};
const _MedicineEntityformValueEnumMap = {
  0: MedicineFormEnum.pill,
  1: MedicineFormEnum.capsule,
  2: MedicineFormEnum.liquid,
  3: MedicineFormEnum.injection,
  4: MedicineFormEnum.drops,
  5: MedicineFormEnum.ointment,
  6: MedicineFormEnum.spray,
  7: MedicineFormEnum.inhaler,
  8: MedicineFormEnum.patch,
  9: MedicineFormEnum.suppository,
};
const _MedicineEntityfrequencyEnumValueMap = {
  'daily': 0,
  'asNeeded': 1,
  'specificDays': 2,
  'interval': 3,
  'cycle': 4,
  'tapering': 5,
};
const _MedicineEntityfrequencyValueEnumMap = {
  0: FrequencyTypeEnum.daily,
  1: FrequencyTypeEnum.asNeeded,
  2: FrequencyTypeEnum.specificDays,
  3: FrequencyTypeEnum.interval,
  4: FrequencyTypeEnum.cycle,
  5: FrequencyTypeEnum.tapering,
};
const _MedicineEntitykindEnumValueMap = {
  'medication': 0,
  'supplement': 1,
};
const _MedicineEntitykindValueEnumMap = {
  0: CourseKindEnum.medication,
  1: CourseKindEnum.supplement,
};
const _MedicineEntitypillShapeEnumValueMap = {
  'circle': 0,
  'capsule': 1,
  'oval': 2,
  'diamond': 3,
  'square': 4,
};
const _MedicineEntitypillShapeValueEnumMap = {
  0: PillShapeEnum.circle,
  1: PillShapeEnum.capsule,
  2: PillShapeEnum.oval,
  3: PillShapeEnum.diamond,
  4: PillShapeEnum.square,
};

Id _medicineEntityGetId(MedicineEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _medicineEntityGetLinks(MedicineEntity object) {
  return [];
}

void _medicineEntityAttach(
    IsarCollection<dynamic> col, Id id, MedicineEntity object) {
  object.id = id;
}

extension MedicineEntityByIndex on IsarCollection<MedicineEntity> {
  Future<MedicineEntity?> getBySyncId(String syncId) {
    return getByIndex(r'syncId', [syncId]);
  }

  MedicineEntity? getBySyncIdSync(String syncId) {
    return getByIndexSync(r'syncId', [syncId]);
  }

  Future<bool> deleteBySyncId(String syncId) {
    return deleteByIndex(r'syncId', [syncId]);
  }

  bool deleteBySyncIdSync(String syncId) {
    return deleteByIndexSync(r'syncId', [syncId]);
  }

  Future<List<MedicineEntity?>> getAllBySyncId(List<String> syncIdValues) {
    final values = syncIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'syncId', values);
  }

  List<MedicineEntity?> getAllBySyncIdSync(List<String> syncIdValues) {
    final values = syncIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'syncId', values);
  }

  Future<int> deleteAllBySyncId(List<String> syncIdValues) {
    final values = syncIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'syncId', values);
  }

  int deleteAllBySyncIdSync(List<String> syncIdValues) {
    final values = syncIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'syncId', values);
  }

  Future<Id> putBySyncId(MedicineEntity object) {
    return putByIndex(r'syncId', object);
  }

  Id putBySyncIdSync(MedicineEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'syncId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySyncId(List<MedicineEntity> objects) {
    return putAllByIndex(r'syncId', objects);
  }

  List<Id> putAllBySyncIdSync(List<MedicineEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'syncId', objects, saveLinks: saveLinks);
  }
}

extension MedicineEntityQueryWhereSort
    on QueryBuilder<MedicineEntity, MedicineEntity, QWhere> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MedicineEntityQueryWhere
    on QueryBuilder<MedicineEntity, MedicineEntity, QWhereClause> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause> syncIdEqualTo(
      String syncId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'syncId',
        value: [syncId],
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterWhereClause>
      syncIdNotEqualTo(String syncId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncId',
              lower: [],
              upper: [syncId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncId',
              lower: [syncId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncId',
              lower: [syncId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncId',
              lower: [],
              upper: [syncId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MedicineEntityQueryFilter
    on QueryBuilder<MedicineEntity, MedicineEntity, QFilterCondition> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cycleOffDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cycleOffDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cycleOffDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cycleOffDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cycleOffDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOffDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cycleOffDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cycleOnDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cycleOnDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cycleOnDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cycleOnDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cycleOnDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      cycleOnDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cycleOnDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosageUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dosageUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dosageUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosageUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      dosageUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dosageUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      foodInstructionEqualTo(FoodInstructionEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodInstruction',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      foodInstructionGreaterThan(
    FoodInstructionEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodInstruction',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      foodInstructionLessThan(
    FoodInstructionEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodInstruction',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      foodInstructionBetween(
    FoodInstructionEnum lower,
    FoodInstructionEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodInstruction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      formEqualTo(MedicineFormEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'form',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      formGreaterThan(
    MedicineFormEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'form',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      formLessThan(
    MedicineFormEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'form',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      formBetween(
    MedicineFormEnum lower,
    MedicineFormEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'form',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      frequencyEqualTo(FrequencyTypeEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      frequencyGreaterThan(
    FrequencyTypeEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      frequencyLessThan(
    FrequencyTypeEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      frequencyBetween(
    FrequencyTypeEnum lower,
    FrequencyTypeEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'instructions',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'instructions',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instructions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instructions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instructions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructions',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instructions',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      intervalDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      isPausedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPaused',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      kindEqualTo(CourseKindEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kind',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      kindGreaterThan(
    CourseKindEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kind',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      kindLessThan(
    CourseKindEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kind',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      kindBetween(
    CourseKindEnum lower,
    CourseKindEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kind',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationBody',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationBody',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationBody',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationBody',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationBody',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationTitle',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationTitle',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      notificationTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillColorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillColor',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pillColor',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pillColor',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pillColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pillImagePath',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pillImagePath',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pillImagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pillImagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pillImagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pillImagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillShapeEqualTo(PillShapeEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillShape',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillShapeGreaterThan(
    PillShapeEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pillShape',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillShapeLessThan(
    PillShapeEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pillShape',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillShapeBetween(
    PillShapeEnum lower,
    PillShapeEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pillShape',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsInPackageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillsInPackage',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsInPackageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pillsInPackage',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsInPackageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pillsInPackage',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsInPackageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pillsInPackage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsRemainingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pillsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsRemainingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pillsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsRemainingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pillsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      pillsRemainingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pillsRemaining',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'prnMaxDailyDoses',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'prnMaxDailyDoses',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prnMaxDailyDoses',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prnMaxDailyDoses',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prnMaxDailyDoses',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      prnMaxDailyDosesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prnMaxDailyDoses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      refillAlertThresholdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refillAlertThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      refillAlertThresholdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refillAlertThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      refillAlertThresholdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refillAlertThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      refillAlertThresholdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refillAlertThreshold',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'regularTimeStrings',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'regularTimeStrings',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'regularTimeStrings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'regularTimeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'regularTimeStrings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regularTimeStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'regularTimeStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      regularTimeStringsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'regularTimeStrings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedWeekDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedWeekDays',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedWeekDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedWeekDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedWeekDays',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedWeekDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      selectedWeekDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedWeekDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncId',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      syncIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncId',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taperingSteps',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taperingSteps',
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'taperingSteps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      timesPerDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timesPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      timesPerDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timesPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      timesPerDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timesPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      timesPerDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timesPerDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MedicineEntityQueryObject
    on QueryBuilder<MedicineEntity, MedicineEntity, QFilterCondition> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterFilterCondition>
      taperingStepsElement(FilterQuery<TaperingStep> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'taperingSteps');
    });
  }
}

extension MedicineEntityQueryLinks
    on QueryBuilder<MedicineEntity, MedicineEntity, QFilterCondition> {}

extension MedicineEntityQuerySortBy
    on QueryBuilder<MedicineEntity, MedicineEntity, QSortBy> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByCycleOffDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByCycleOnDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByDosageUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosageUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByDosageUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosageUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByFoodInstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodInstruction', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByFoodInstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodInstruction', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByIntervalDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByIsPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kind', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kind', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByNotificationBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByNotificationBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByNotificationTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByNotificationTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByPillColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillColor', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillColor', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillImagePath', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillImagePath', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByPillShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillShape', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillShape', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillsInPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsInPackage', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillsInPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsInPackage', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsRemaining', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPillsRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsRemaining', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPrnMaxDailyDoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prnMaxDailyDoses', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByPrnMaxDailyDosesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prnMaxDailyDoses', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByRefillAlertThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillAlertThreshold', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByRefillAlertThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillAlertThreshold', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> sortBySyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortBySyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByTimesPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesPerDay', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      sortByTimesPerDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesPerDay', Sort.desc);
    });
  }
}

extension MedicineEntityQuerySortThenBy
    on QueryBuilder<MedicineEntity, MedicineEntity, QSortThenBy> {
  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByCycleOffDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOffDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByCycleOnDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleOnDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByDosageUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosageUnit', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByDosageUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosageUnit', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByFoodInstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodInstruction', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByFoodInstructionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodInstruction', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'form', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByInstructionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructions', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalDays', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByIntervalDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalDays', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByIsPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaused', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kind', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kind', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByNotificationBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByNotificationBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByNotificationTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByNotificationTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByPillColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillColor', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillColor', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillImagePath', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillImagePath', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByPillShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillShape', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillShape', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillsInPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsInPackage', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillsInPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsInPackage', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsRemaining', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPillsRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pillsRemaining', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPrnMaxDailyDoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prnMaxDailyDoses', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByPrnMaxDailyDosesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prnMaxDailyDoses', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByRefillAlertThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillAlertThreshold', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByRefillAlertThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refillAlertThreshold', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy> thenBySyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenBySyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.desc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByTimesPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesPerDay', Sort.asc);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QAfterSortBy>
      thenByTimesPerDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesPerDay', Sort.desc);
    });
  }
}

extension MedicineEntityQueryWhereDistinct
    on QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> {
  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByCycleOffDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cycleOffDays');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByCycleOnDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cycleOnDays');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosage');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByDosageUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosageUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByFoodInstruction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodInstruction');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'form');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByInstructions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalDays');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByIsPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPaused');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kind');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByNotificationBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationBody',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByNotificationTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationTitle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPillColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pillColor');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPillImagePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pillImagePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPillShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pillShape');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPillsInPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pillsInPackage');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPillsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pillsRemaining');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByPrnMaxDailyDoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prnMaxDailyDoses');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByRefillAlertThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refillAlertThreshold');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByRegularTimeStrings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'regularTimeStrings');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctBySelectedWeekDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedWeekDays');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct> distinctBySyncId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MedicineEntity, MedicineEntity, QDistinct>
      distinctByTimesPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timesPerDay');
    });
  }
}

extension MedicineEntityQueryProperty
    on QueryBuilder<MedicineEntity, MedicineEntity, QQueryProperty> {
  QueryBuilder<MedicineEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MedicineEntity, int?, QQueryOperations> cycleOffDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cycleOffDays');
    });
  }

  QueryBuilder<MedicineEntity, int?, QQueryOperations> cycleOnDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cycleOnDays');
    });
  }

  QueryBuilder<MedicineEntity, double, QQueryOperations> dosageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosage');
    });
  }

  QueryBuilder<MedicineEntity, String, QQueryOperations> dosageUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosageUnit');
    });
  }

  QueryBuilder<MedicineEntity, DateTime?, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<MedicineEntity, FoodInstructionEnum, QQueryOperations>
      foodInstructionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodInstruction');
    });
  }

  QueryBuilder<MedicineEntity, MedicineFormEnum, QQueryOperations>
      formProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'form');
    });
  }

  QueryBuilder<MedicineEntity, FrequencyTypeEnum, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<MedicineEntity, String?, QQueryOperations>
      instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<MedicineEntity, int?, QQueryOperations> intervalDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalDays');
    });
  }

  QueryBuilder<MedicineEntity, bool, QQueryOperations> isPausedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPaused');
    });
  }

  QueryBuilder<MedicineEntity, CourseKindEnum, QQueryOperations>
      kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kind');
    });
  }

  QueryBuilder<MedicineEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MedicineEntity, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MedicineEntity, String?, QQueryOperations>
      notificationBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationBody');
    });
  }

  QueryBuilder<MedicineEntity, String?, QQueryOperations>
      notificationTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationTitle');
    });
  }

  QueryBuilder<MedicineEntity, int, QQueryOperations> pillColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pillColor');
    });
  }

  QueryBuilder<MedicineEntity, String?, QQueryOperations>
      pillImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pillImagePath');
    });
  }

  QueryBuilder<MedicineEntity, PillShapeEnum, QQueryOperations>
      pillShapeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pillShape');
    });
  }

  QueryBuilder<MedicineEntity, int, QQueryOperations> pillsInPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pillsInPackage');
    });
  }

  QueryBuilder<MedicineEntity, int, QQueryOperations> pillsRemainingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pillsRemaining');
    });
  }

  QueryBuilder<MedicineEntity, int?, QQueryOperations>
      prnMaxDailyDosesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prnMaxDailyDoses');
    });
  }

  QueryBuilder<MedicineEntity, int, QQueryOperations>
      refillAlertThresholdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refillAlertThreshold');
    });
  }

  QueryBuilder<MedicineEntity, List<String>?, QQueryOperations>
      regularTimeStringsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'regularTimeStrings');
    });
  }

  QueryBuilder<MedicineEntity, List<int>?, QQueryOperations>
      selectedWeekDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedWeekDays');
    });
  }

  QueryBuilder<MedicineEntity, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<MedicineEntity, String, QQueryOperations> syncIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncId');
    });
  }

  QueryBuilder<MedicineEntity, List<TaperingStep>?, QQueryOperations>
      taperingStepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taperingSteps');
    });
  }

  QueryBuilder<MedicineEntity, int, QQueryOperations> timesPerDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timesPerDay');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TaperingStepSchema = Schema(
  name: r'TaperingStep',
  id: 6930165291098847973,
  properties: {
    r'dosage': PropertySchema(
      id: 0,
      name: r'dosage',
      type: IsarType.double,
    ),
    r'durationDays': PropertySchema(
      id: 1,
      name: r'durationDays',
      type: IsarType.long,
    ),
    r'timeStrings': PropertySchema(
      id: 2,
      name: r'timeStrings',
      type: IsarType.stringList,
    )
  },
  estimateSize: _taperingStepEstimateSize,
  serialize: _taperingStepSerialize,
  deserialize: _taperingStepDeserialize,
  deserializeProp: _taperingStepDeserializeProp,
);

int _taperingStepEstimateSize(
  TaperingStep object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.timeStrings.length * 3;
  {
    for (var i = 0; i < object.timeStrings.length; i++) {
      final value = object.timeStrings[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _taperingStepSerialize(
  TaperingStep object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.dosage);
  writer.writeLong(offsets[1], object.durationDays);
  writer.writeStringList(offsets[2], object.timeStrings);
}

TaperingStep _taperingStepDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaperingStep();
  object.dosage = reader.readDouble(offsets[0]);
  object.durationDays = reader.readLong(offsets[1]);
  object.timeStrings = reader.readStringList(offsets[2]) ?? [];
  return object;
}

P _taperingStepDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TaperingStepQueryFilter
    on QueryBuilder<TaperingStep, TaperingStep, QFilterCondition> {
  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition> dosageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      dosageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      dosageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition> dosageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      durationDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationDays',
        value: value,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      durationDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationDays',
        value: value,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      durationDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationDays',
        value: value,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      durationDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStrings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeStrings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaperingStep, TaperingStep, QAfterFilterCondition>
      timeStringsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeStrings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TaperingStepQueryObject
    on QueryBuilder<TaperingStep, TaperingStep, QFilterCondition> {}
