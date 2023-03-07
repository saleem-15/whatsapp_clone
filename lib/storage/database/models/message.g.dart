// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetMessageDBCollection on Isar {
  IsarCollection<MessageDB> get messages => this.collection();
}

const MessageDBSchema = CollectionSchema(
  name: r'MessageDB',
  id: -151199360625990355,
  properties: {
    r'chatId': PropertySchema(
      id: 0,
      name: r'chatId',
      type: IsarType.string,
    ),
    r'contentFilePath': PropertySchema(
      id: 1,
      name: r'contentFilePath',
      type: IsarType.string,
    ),
    r'fileURl': PropertySchema(
      id: 2,
      name: r'fileURl',
      type: IsarType.string,
    ),
    r'isSeen': PropertySchema(
      id: 3,
      name: r'isSeen',
      type: IsarType.bool,
    ),
    r'isSent': PropertySchema(
      id: 4,
      name: r'isSent',
      type: IsarType.bool,
    ),
    r'messageId': PropertySchema(
      id: 5,
      name: r'messageId',
      type: IsarType.string,
    ),
    r'specialMessageAttributes': PropertySchema(
      id: 6,
      name: r'specialMessageAttributes',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 7,
      name: r'text',
      type: IsarType.string,
    ),
    r'timeSent': PropertySchema(
      id: 8,
      name: r'timeSent',
      type: IsarType.dateTime,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _MessageDBtypeEnumValueMap,
    )
  },
  estimateSize: _messageDBEstimateSize,
  serialize: _messageDBSerialize,
  deserialize: _messageDBDeserialize,
  deserializeProp: _messageDBDeserializeProp,
  idName: r'id',
  indexes: {
    r'messageId': IndexSchema(
      id: -635287409172016016,
      name: r'messageId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'messageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'sender': LinkSchema(
      id: 8257306667636939656,
      name: r'sender',
      target: r'User',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _messageDBGetId,
  getLinks: _messageDBGetLinks,
  attach: _messageDBAttach,
  version: '3.0.5',
);

int _messageDBEstimateSize(
  MessageDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chatId.length * 3;
  {
    final value = object.contentFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileURl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.messageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.specialMessageAttributes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _messageDBSerialize(
  MessageDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chatId);
  writer.writeString(offsets[1], object.contentFilePath);
  writer.writeString(offsets[2], object.fileURl);
  writer.writeBool(offsets[3], object.isSeen);
  writer.writeBool(offsets[4], object.isSent);
  writer.writeString(offsets[5], object.messageId);
  writer.writeString(offsets[6], object.specialMessageAttributes);
  writer.writeString(offsets[7], object.text);
  writer.writeDateTime(offsets[8], object.timeSent);
  writer.writeByte(offsets[9], object.type.index);
}

MessageDB _messageDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageDB();
  object.chatId = reader.readString(offsets[0]);
  object.contentFilePath = reader.readStringOrNull(offsets[1]);
  object.fileURl = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isSeen = reader.readBool(offsets[3]);
  object.isSent = reader.readBool(offsets[4]);
  object.messageId = reader.readStringOrNull(offsets[5]);
  object.specialMessageAttributes = reader.readStringOrNull(offsets[6]);
  object.text = reader.readStringOrNull(offsets[7]);
  object.timeSent = reader.readDateTime(offsets[8]);
  object.type = _MessageDBtypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
      MessageType.text;
  return object;
}

P _messageDBDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (_MessageDBtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          MessageType.text) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageDBtypeEnumValueMap = {
  'text': 0,
  'image': 1,
  'video': 2,
  'audio': 3,
  'file': 4,
};
const _MessageDBtypeValueEnumMap = {
  0: MessageType.text,
  1: MessageType.image,
  2: MessageType.video,
  3: MessageType.audio,
  4: MessageType.file,
};

Id _messageDBGetId(MessageDB object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _messageDBGetLinks(MessageDB object) {
  return [object.sender];
}

void _messageDBAttach(IsarCollection<dynamic> col, Id id, MessageDB object) {
  object.id = id;
  object.sender.attach(col, col.isar.collection<User>(), r'sender', id);
}

extension MessageDBByIndex on IsarCollection<MessageDB> {
  Future<MessageDB?> getByMessageId(String? messageId) {
    return getByIndex(r'messageId', [messageId]);
  }

  MessageDB? getByMessageIdSync(String? messageId) {
    return getByIndexSync(r'messageId', [messageId]);
  }

  Future<bool> deleteByMessageId(String? messageId) {
    return deleteByIndex(r'messageId', [messageId]);
  }

  bool deleteByMessageIdSync(String? messageId) {
    return deleteByIndexSync(r'messageId', [messageId]);
  }

  Future<List<MessageDB?>> getAllByMessageId(List<String?> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'messageId', values);
  }

  List<MessageDB?> getAllByMessageIdSync(List<String?> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'messageId', values);
  }

  Future<int> deleteAllByMessageId(List<String?> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'messageId', values);
  }

  int deleteAllByMessageIdSync(List<String?> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'messageId', values);
  }

  Future<Id> putByMessageId(MessageDB object) {
    return putByIndex(r'messageId', object);
  }

  Id putByMessageIdSync(MessageDB object, {bool saveLinks = true}) {
    return putByIndexSync(r'messageId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMessageId(List<MessageDB> objects) {
    return putAllByIndex(r'messageId', objects);
  }

  List<Id> putAllByMessageIdSync(List<MessageDB> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'messageId', objects, saveLinks: saveLinks);
  }
}

extension MessageDBQueryWhereSort
    on QueryBuilder<MessageDB, MessageDB, QWhere> {
  QueryBuilder<MessageDB, MessageDB, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MessageDBQueryWhere
    on QueryBuilder<MessageDB, MessageDB, QWhereClause> {
  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> idBetween(
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

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> messageIdEqualTo(
      String? messageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [messageId],
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterWhereClause> messageIdNotEqualTo(
      String? messageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MessageDBQueryFilter
    on QueryBuilder<MessageDB, MessageDB, QFilterCondition> {
  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chatId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chatId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chatId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chatId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> chatIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chatId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentFilePath',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentFilePath',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      contentFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileURl',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileURl',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileURl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileURl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileURl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> fileURlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileURl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      fileURlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileURl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> isSeenEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> isSentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      messageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'specialMessageAttributes',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'specialMessageAttributes',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'specialMessageAttributes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'specialMessageAttributes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'specialMessageAttributes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'specialMessageAttributes',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition>
      specialMessageAttributesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'specialMessageAttributes',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> timeSentEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> timeSentGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> timeSentLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> timeSentBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeSent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> typeEqualTo(
      MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> typeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> typeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> typeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageDBQueryObject
    on QueryBuilder<MessageDB, MessageDB, QFilterCondition> {}

extension MessageDBQueryLinks
    on QueryBuilder<MessageDB, MessageDB, QFilterCondition> {
  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> sender(
      FilterQuery<User> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sender');
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterFilterCondition> senderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sender', 0, true, 0, true);
    });
  }
}

extension MessageDBQuerySortBy on QueryBuilder<MessageDB, MessageDB, QSortBy> {
  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByChatId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chatId', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByChatIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chatId', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByContentFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFilePath', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByContentFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFilePath', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByFileURl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileURl', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByFileURlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileURl', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSeen', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByIsSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSeen', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByIsSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy>
      sortBySpecialMessageAttributes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialMessageAttributes', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy>
      sortBySpecialMessageAttributesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialMessageAttributes', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByTimeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSent', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByTimeSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSent', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension MessageDBQuerySortThenBy
    on QueryBuilder<MessageDB, MessageDB, QSortThenBy> {
  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByChatId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chatId', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByChatIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chatId', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByContentFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFilePath', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByContentFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentFilePath', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByFileURl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileURl', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByFileURlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileURl', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSeen', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByIsSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSeen', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByIsSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy>
      thenBySpecialMessageAttributes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialMessageAttributes', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy>
      thenBySpecialMessageAttributesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialMessageAttributes', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByTimeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSent', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByTimeSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSent', Sort.desc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension MessageDBQueryWhereDistinct
    on QueryBuilder<MessageDB, MessageDB, QDistinct> {
  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByChatId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chatId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByContentFilePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentFilePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByFileURl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileURl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByIsSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSeen');
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSent');
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct>
      distinctBySpecialMessageAttributes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'specialMessageAttributes',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByTimeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeSent');
    });
  }

  QueryBuilder<MessageDB, MessageDB, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension MessageDBQueryProperty
    on QueryBuilder<MessageDB, MessageDB, QQueryProperty> {
  QueryBuilder<MessageDB, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageDB, String, QQueryOperations> chatIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chatId');
    });
  }

  QueryBuilder<MessageDB, String?, QQueryOperations> contentFilePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentFilePath');
    });
  }

  QueryBuilder<MessageDB, String?, QQueryOperations> fileURlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileURl');
    });
  }

  QueryBuilder<MessageDB, bool, QQueryOperations> isSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSeen');
    });
  }

  QueryBuilder<MessageDB, bool, QQueryOperations> isSentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSent');
    });
  }

  QueryBuilder<MessageDB, String?, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<MessageDB, String?, QQueryOperations>
      specialMessageAttributesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'specialMessageAttributes');
    });
  }

  QueryBuilder<MessageDB, String?, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<MessageDB, DateTime, QQueryOperations> timeSentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeSent');
    });
  }

  QueryBuilder<MessageDB, MessageType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
