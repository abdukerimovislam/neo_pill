// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dose_log_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoseLogEntityCollection on Isar {
  IsarCollection<DoseLogEntity> get doseLogEntitys => this.collection();
}

const DoseLogEntitySchema = CollectionSchema(
  name: r'DoseLogEntity',
  id: 7508137675368345756,
  properties: {
    r'actualTime': PropertySchema(
      id: 0,
      name: r'actualTime',
      type: IsarType.dateTime,
    ),
    r'dosage': PropertySchema(id: 1, name: r'dosage', type: IsarType.double),
    r'medicineSyncId': PropertySchema(
      id: 2,
      name: r'medicineSyncId',
      type: IsarType.string,
    ),
    r'scheduledTime': PropertySchema(
      id: 3,
      name: r'scheduledTime',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 4,
      name: r'status',
      type: IsarType.byte,
      enumMap: _DoseLogEntitystatusEnumValueMap,
    ),
    r'syncId': PropertySchema(id: 5, name: r'syncId', type: IsarType.string),
  },
  estimateSize: _doseLogEntityEstimateSize,
  serialize: _doseLogEntitySerialize,
  deserialize: _doseLogEntityDeserialize,
  deserializeProp: _doseLogEntityDeserializeProp,
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
        ),
      ],
    ),
    r'medicineSyncId': IndexSchema(
      id: -529446451122061269,
      name: r'medicineSyncId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'medicineSyncId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'scheduledTime': IndexSchema(
      id: 4528483578431344364,
      name: r'scheduledTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'scheduledTime',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _doseLogEntityGetId,
  getLinks: _doseLogEntityGetLinks,
  attach: _doseLogEntityAttach,
  version: '3.1.0+1',
);

int _doseLogEntityEstimateSize(
  DoseLogEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.medicineSyncId.length * 3;
  bytesCount += 3 + object.syncId.length * 3;
  return bytesCount;
}

void _doseLogEntitySerialize(
  DoseLogEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.actualTime);
  writer.writeDouble(offsets[1], object.dosage);
  writer.writeString(offsets[2], object.medicineSyncId);
  writer.writeDateTime(offsets[3], object.scheduledTime);
  writer.writeByte(offsets[4], object.status.index);
  writer.writeString(offsets[5], object.syncId);
}

DoseLogEntity _doseLogEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoseLogEntity();
  object.actualTime = reader.readDateTimeOrNull(offsets[0]);
  object.dosage = reader.readDouble(offsets[1]);
  object.id = id;
  object.medicineSyncId = reader.readString(offsets[2]);
  object.scheduledTime = reader.readDateTime(offsets[3]);
  object.status =
      _DoseLogEntitystatusValueEnumMap[reader.readByteOrNull(offsets[4])] ??
      DoseStatusEnum.taken;
  object.syncId = reader.readString(offsets[5]);
  return object;
}

P _doseLogEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (_DoseLogEntitystatusValueEnumMap[reader.readByteOrNull(offset)] ??
              DoseStatusEnum.taken)
          as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DoseLogEntitystatusEnumValueMap = {
  'taken': 0,
  'skipped': 1,
  'snoozed': 2,
  'pending': 3,
};
const _DoseLogEntitystatusValueEnumMap = {
  0: DoseStatusEnum.taken,
  1: DoseStatusEnum.skipped,
  2: DoseStatusEnum.snoozed,
  3: DoseStatusEnum.pending,
};

Id _doseLogEntityGetId(DoseLogEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doseLogEntityGetLinks(DoseLogEntity object) {
  return [];
}

void _doseLogEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  DoseLogEntity object,
) {
  object.id = id;
}

extension DoseLogEntityByIndex on IsarCollection<DoseLogEntity> {
  Future<DoseLogEntity?> getBySyncId(String syncId) {
    return getByIndex(r'syncId', [syncId]);
  }

  DoseLogEntity? getBySyncIdSync(String syncId) {
    return getByIndexSync(r'syncId', [syncId]);
  }

  Future<bool> deleteBySyncId(String syncId) {
    return deleteByIndex(r'syncId', [syncId]);
  }

  bool deleteBySyncIdSync(String syncId) {
    return deleteByIndexSync(r'syncId', [syncId]);
  }

  Future<List<DoseLogEntity?>> getAllBySyncId(List<String> syncIdValues) {
    final values = syncIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'syncId', values);
  }

  List<DoseLogEntity?> getAllBySyncIdSync(List<String> syncIdValues) {
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

  Future<Id> putBySyncId(DoseLogEntity object) {
    return putByIndex(r'syncId', object);
  }

  Id putBySyncIdSync(DoseLogEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'syncId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySyncId(List<DoseLogEntity> objects) {
    return putAllByIndex(r'syncId', objects);
  }

  List<Id> putAllBySyncIdSync(
    List<DoseLogEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'syncId', objects, saveLinks: saveLinks);
  }
}

extension DoseLogEntityQueryWhereSort
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QWhere> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhere> anyScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'scheduledTime'),
      );
    });
  }
}

extension DoseLogEntityQueryWhere
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QWhereClause> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause> syncIdEqualTo(
    String syncId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'syncId', value: [syncId]),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  syncIdNotEqualTo(String syncId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncId',
                lower: [],
                upper: [syncId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncId',
                lower: [syncId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncId',
                lower: [syncId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'syncId',
                lower: [],
                upper: [syncId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  medicineSyncIdEqualTo(String medicineSyncId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'medicineSyncId',
          value: [medicineSyncId],
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  medicineSyncIdNotEqualTo(String medicineSyncId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicineSyncId',
                lower: [],
                upper: [medicineSyncId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicineSyncId',
                lower: [medicineSyncId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicineSyncId',
                lower: [medicineSyncId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'medicineSyncId',
                lower: [],
                upper: [medicineSyncId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  scheduledTimeEqualTo(DateTime scheduledTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'scheduledTime',
          value: [scheduledTime],
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  scheduledTimeNotEqualTo(DateTime scheduledTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduledTime',
                lower: [],
                upper: [scheduledTime],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduledTime',
                lower: [scheduledTime],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduledTime',
                lower: [scheduledTime],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduledTime',
                lower: [],
                upper: [scheduledTime],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  scheduledTimeGreaterThan(DateTime scheduledTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduledTime',
          lower: [scheduledTime],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  scheduledTimeLessThan(DateTime scheduledTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduledTime',
          lower: [],
          upper: [scheduledTime],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterWhereClause>
  scheduledTimeBetween(
    DateTime lowerScheduledTime,
    DateTime upperScheduledTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduledTime',
          lower: [lowerScheduledTime],
          includeLower: includeLower,
          upper: [upperScheduledTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DoseLogEntityQueryFilter
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QFilterCondition> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'actualTime'),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'actualTime'),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'actualTime', value: value),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'actualTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'actualTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  actualTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'actualTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  dosageEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dosage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  dosageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dosage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  dosageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dosage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  dosageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dosage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicineSyncId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicineSyncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicineSyncId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicineSyncId', value: ''),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  medicineSyncIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicineSyncId', value: ''),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  scheduledTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduledTime', value: value),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  scheduledTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduledTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  scheduledTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduledTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  scheduledTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduledTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  statusEqualTo(DoseStatusEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  statusGreaterThan(DoseStatusEnum value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  statusLessThan(DoseStatusEnum value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  statusBetween(
    DoseStatusEnum lower,
    DoseStatusEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'syncId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'syncId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncId', value: ''),
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterFilterCondition>
  syncIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'syncId', value: ''),
      );
    });
  }
}

extension DoseLogEntityQueryObject
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QFilterCondition> {}

extension DoseLogEntityQueryLinks
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QFilterCondition> {}

extension DoseLogEntityQuerySortBy
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QSortBy> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortByActualTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualTime', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  sortByActualTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualTime', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  sortByMedicineSyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineSyncId', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  sortByMedicineSyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineSyncId', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  sortByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  sortByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortBySyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> sortBySyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.desc);
    });
  }
}

extension DoseLogEntityQuerySortThenBy
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QSortThenBy> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByActualTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualTime', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  thenByActualTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualTime', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByDosageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosage', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  thenByMedicineSyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineSyncId', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  thenByMedicineSyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineSyncId', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  thenByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy>
  thenByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenBySyncId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.asc);
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QAfterSortBy> thenBySyncIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncId', Sort.desc);
    });
  }
}

extension DoseLogEntityQueryWhereDistinct
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct> {
  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct> distinctByActualTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualTime');
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct> distinctByDosage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosage');
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct>
  distinctByMedicineSyncId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'medicineSyncId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct>
  distinctByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledTime');
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<DoseLogEntity, DoseLogEntity, QDistinct> distinctBySyncId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncId', caseSensitive: caseSensitive);
    });
  }
}

extension DoseLogEntityQueryProperty
    on QueryBuilder<DoseLogEntity, DoseLogEntity, QQueryProperty> {
  QueryBuilder<DoseLogEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoseLogEntity, DateTime?, QQueryOperations>
  actualTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualTime');
    });
  }

  QueryBuilder<DoseLogEntity, double, QQueryOperations> dosageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosage');
    });
  }

  QueryBuilder<DoseLogEntity, String, QQueryOperations>
  medicineSyncIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicineSyncId');
    });
  }

  QueryBuilder<DoseLogEntity, DateTime, QQueryOperations>
  scheduledTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledTime');
    });
  }

  QueryBuilder<DoseLogEntity, DoseStatusEnum, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<DoseLogEntity, String, QQueryOperations> syncIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncId');
    });
  }
}
