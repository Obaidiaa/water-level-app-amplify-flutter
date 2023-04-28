/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the ThingOwnerManagerRes type in your schema. */
@immutable
class ThingOwnerManagerRes extends Model {
  static const classType = const _ThingOwnerManagerResModelType();
  final int? _status;
  final String? _message;
  final String? _action;
  final String? _serialNumber;
  final String? _owner;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  int? get status {
    return _status;
  }

  String? get message {
    return _message;
  }

  String? get action {
    return _action;
  }

  String? get serialNumber {
    return _serialNumber;
  }

  String? get owner {
    return _owner;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const ThingOwnerManagerRes._internal(
      {status, message, action, serialNumber, owner, createdAt, updatedAt})
      : _status = status,
        _message = message,
        _action = action,
        _serialNumber = serialNumber,
        _owner = owner,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory ThingOwnerManagerRes(
      {String? id,
      int? status,
      String? message,
      String? action,
      String? serialNumber,
      String? owner}) {
    return ThingOwnerManagerRes._internal(
        status: status,
        message: message,
        action: action,
        serialNumber: serialNumber,
        owner: owner);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThingOwnerManagerRes &&
        _status == other._status &&
        _message == other._message &&
        _action == other._action &&
        _serialNumber == other._serialNumber &&
        _owner == other._owner;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ThingOwnerManagerRes {");
    buffer.write(
        "status=" + (_status != null ? _status!.toString() : "null") + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("action=" + "$_action" + ", ");
    buffer.write("serialNumber=" + "$_serialNumber" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ThingOwnerManagerRes copyWith(
      {String? id,
      int? status,
      String? message,
      String? action,
      String? serialNumber,
      String? owner}) {
    return ThingOwnerManagerRes._internal(
        status: status ?? this.status,
        message: message ?? this.message,
        action: action ?? this.action,
        serialNumber: serialNumber ?? this.serialNumber,
        owner: owner ?? this.owner);
  }

  ThingOwnerManagerRes.fromJson(Map<String, dynamic> json)
      : _status = (json['status'] as num?)?.toInt(),
        _message = json['message'],
        _action = json['action'],
        _serialNumber = json['serialNumber'],
        _owner = json['owner'],
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'status': _status,
        'message': _message,
        'action': _action,
        'serialNumber': _serialNumber,
        'owner': _owner,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'status': _status,
        'message': _message,
        'action': _action,
        'serialNumber': _serialNumber,
        'owner': _owner,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField MESSAGE = QueryField(fieldName: "message");
  static final QueryField ACTION = QueryField(fieldName: "action");
  static final QueryField SERIALNUMBER = QueryField(fieldName: "serialNumber");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ThingOwnerManagerRes";
    modelSchemaDefinition.pluralName = "ThingOwnerManagerRes";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ThingOwnerManagerRes.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ThingOwnerManagerRes.MESSAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ThingOwnerManagerRes.ACTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ThingOwnerManagerRes.SERIALNUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ThingOwnerManagerRes.OWNER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _ThingOwnerManagerResModelType extends ModelType<ThingOwnerManagerRes> {
  const _ThingOwnerManagerResModelType();

  @override
  ThingOwnerManagerRes fromJson(Map<String, dynamic> jsonData) {
    return ThingOwnerManagerRes.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'ThingOwnerManagerRes';
  }
}
