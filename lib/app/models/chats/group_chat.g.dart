// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_chat.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetGroupChatCollection on Isar {
  IsarCollection<GroupChat> get groupChats => this.collection();
}

const GroupChatSchema = CollectionSchema(
  name: r'GroupChat',
  id: 3160916123829667037,
  properties: {
    r'bio': PropertySchema(
      id: 0,
      name: r'bio',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'formattedCreationDate': PropertySchema(
      id: 2,
      name: r'formattedCreationDate',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 4,
      name: r'image',
      type: IsarType.string,
    ),
    r'isGroupChat': PropertySchema(
      id: 5,
      name: r'isGroupChat',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'usersIds': PropertySchema(
      id: 7,
      name: r'usersIds',
      type: IsarType.stringList,
    )
  },
  estimateSize: _groupChatEstimateSize,
  serialize: _groupChatSerialize,
  deserialize: _groupChatDeserialize,
  deserializeProp: _groupChatDeserializeProp,
  idName: r'databaseId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _groupChatGetId,
  getLinks: _groupChatGetLinks,
  attach: _groupChatAttach,
  version: '3.0.5',
);

int _groupChatEstimateSize(
  GroupChat object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bio.length * 3;
  bytesCount += 3 + object.formattedCreationDate.length * 3;
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.usersIds.length * 3;
  {
    for (var i = 0; i < object.usersIds.length; i++) {
      final value = object.usersIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _groupChatSerialize(
  GroupChat object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bio);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.formattedCreationDate);
  writer.writeString(offsets[3], object.id);
  writer.writeString(offsets[4], object.image);
  writer.writeBool(offsets[5], object.isGroupChat);
  writer.writeString(offsets[6], object.name);
  writer.writeStringList(offsets[7], object.usersIds);
}

GroupChat _groupChatDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupChat(
    bio: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    id: reader.readString(offsets[3]),
    image: reader.readStringOrNull(offsets[4]),
    name: reader.readString(offsets[6]),
    usersIds: reader.readStringList(offsets[7]) ?? [],
  );
  object.databaseId = id;
  return object;
}

P _groupChatDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupChatGetId(GroupChat object) {
  return object.databaseId;
}

List<IsarLinkBase<dynamic>> _groupChatGetLinks(GroupChat object) {
  return [];
}

void _groupChatAttach(IsarCollection<dynamic> col, Id id, GroupChat object) {
  object.databaseId = id;
}

extension GroupChatQueryWhereSort
    on QueryBuilder<GroupChat, GroupChat, QWhere> {
  QueryBuilder<GroupChat, GroupChat, QAfterWhere> anyDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupChatQueryWhere
    on QueryBuilder<GroupChat, GroupChat, QWhereClause> {
  QueryBuilder<GroupChat, GroupChat, QAfterWhereClause> databaseIdEqualTo(
      Id databaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: databaseId,
        upper: databaseId,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterWhereClause> databaseIdNotEqualTo(
      Id databaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: databaseId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: databaseId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: databaseId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: databaseId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterWhereClause> databaseIdGreaterThan(
      Id databaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: databaseId, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterWhereClause> databaseIdLessThan(
      Id databaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: databaseId, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterWhereClause> databaseIdBetween(
    Id lowerDatabaseId,
    Id upperDatabaseId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerDatabaseId,
        includeLower: includeLower,
        upper: upperDatabaseId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GroupChatQueryFilter
    on QueryBuilder<GroupChat, GroupChat, QFilterCondition> {
  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> bioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> databaseIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'databaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      databaseIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'databaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> databaseIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'databaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> databaseIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'databaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedCreationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedCreationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedCreationDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedCreationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      formattedCreationDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedCreationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> isGroupChatEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroupChat',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'usersIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'usersIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'usersIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usersIds',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'usersIds',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition> usersIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterFilterCondition>
      usersIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'usersIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension GroupChatQueryObject
    on QueryBuilder<GroupChat, GroupChat, QFilterCondition> {}

extension GroupChatQueryLinks
    on QueryBuilder<GroupChat, GroupChat, QFilterCondition> {}

extension GroupChatQuerySortBy on QueryBuilder<GroupChat, GroupChat, QSortBy> {
  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy>
      sortByFormattedCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedCreationDate', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy>
      sortByFormattedCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedCreationDate', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByIsGroupChat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroupChat', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByIsGroupChatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroupChat', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GroupChatQuerySortThenBy
    on QueryBuilder<GroupChat, GroupChat, QSortThenBy> {
  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'databaseId', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'databaseId', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy>
      thenByFormattedCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedCreationDate', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy>
      thenByFormattedCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedCreationDate', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByIsGroupChat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroupChat', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByIsGroupChatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroupChat', Sort.desc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GroupChatQueryWhereDistinct
    on QueryBuilder<GroupChat, GroupChat, QDistinct> {
  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByBio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByFormattedCreationDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedCreationDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByIsGroupChat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroupChat');
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupChat, GroupChat, QDistinct> distinctByUsersIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usersIds');
    });
  }
}

extension GroupChatQueryProperty
    on QueryBuilder<GroupChat, GroupChat, QQueryProperty> {
  QueryBuilder<GroupChat, int, QQueryOperations> databaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'databaseId');
    });
  }

  QueryBuilder<GroupChat, String, QQueryOperations> bioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bio');
    });
  }

  QueryBuilder<GroupChat, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GroupChat, String, QQueryOperations>
      formattedCreationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedCreationDate');
    });
  }

  QueryBuilder<GroupChat, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupChat, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<GroupChat, bool, QQueryOperations> isGroupChatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroupChat');
    });
  }

  QueryBuilder<GroupChat, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<GroupChat, List<String>, QQueryOperations> usersIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usersIds');
    });
  }
}
