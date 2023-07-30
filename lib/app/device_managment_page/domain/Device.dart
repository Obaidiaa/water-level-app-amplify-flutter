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

import '../../../models/ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';
import 'DeviceType.dart';

/** This is an auto generated class representing the Device type in your schema. */
@immutable
class Device extends Model {
  static const classType = const _DeviceModelType();
  final bool? _active;
  final String? _thingName;
  final int? _highLevelAlarm;
  final int? _lowLevelAlarm;
  final double? _lat;
  final double? _lng;
  final DeviceType? _type;
  final int? _height;
  final String? _location;
  final int? _ownerCounter;
  final String? _certificate;
  final bool? _notification;
  final String? _serialNumber;
  final String? _owner;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  bool? get active {
    return _active;
  }

  String? get thingName {
    return _thingName;
  }

  int? get highLevelAlarm {
    return _highLevelAlarm;
  }

  int? get lowLevelAlarm {
    return _lowLevelAlarm;
  }

  double? get lat {
    return _lat;
  }

  double? get lng {
    return _lng;
  }

  DeviceType? get type {
    return _type;
  }

  int? get height {
    return _height;
  }

  String? get location {
    return _location;
  }

  int? get ownerCounter {
    return _ownerCounter;
  }

  String? get certificate {
    return _certificate;
  }

  bool? get notification {
    return _notification;
  }

  String get serialNumber {
    try {
      return _serialNumber!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
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

  const Device._internal(
      {active,
      thingName,
      highLevelAlarm,
      lowLevelAlarm,
      lat,
      lng,
      type,
      height,
      location,
      ownerCounter,
      certificate,
      notification,
      required serialNumber,
      owner,
      createdAt,
      updatedAt})
      : _active = active,
        _thingName = thingName,
        _highLevelAlarm = highLevelAlarm,
        _lowLevelAlarm = lowLevelAlarm,
        _lat = lat,
        _lng = lng,
        _type = type,
        _height = height,
        _location = location,
        _ownerCounter = ownerCounter,
        _certificate = certificate,
        _notification = notification,
        _serialNumber = serialNumber,
        _owner = owner,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory Device(
      {bool? active,
      String? thingName,
      int? highLevelAlarm,
      int? lowLevelAlarm,
      double? lat,
      double? lng,
      DeviceType? type,
      int? height,
      String? location,
      int? ownerCounter,
      String? certificate,
      bool? notification,
      required String serialNumber,
      String? owner}) {
    return Device._internal(
        active: active,
        thingName: thingName,
        highLevelAlarm: highLevelAlarm,
        lowLevelAlarm: lowLevelAlarm,
        lat: lat,
        lng: lng,
        type: type,
        height: height,
        location: location,
        ownerCounter: ownerCounter,
        certificate: certificate,
        notification: notification,
        serialNumber: serialNumber,
        owner: owner);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Device &&
        _active == other._active &&
        _thingName == other._thingName &&
        _highLevelAlarm == other._highLevelAlarm &&
        _lowLevelAlarm == other._lowLevelAlarm &&
        _lat == other._lat &&
        _lng == other._lng &&
        _type == other._type &&
        _height == other._height &&
        _location == other._location &&
        _ownerCounter == other._ownerCounter &&
        _certificate == other._certificate &&
        _notification == other._notification &&
        _serialNumber == other._serialNumber &&
        _owner == other._owner;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Device {");
    buffer.write(
        "active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("thingName=" + "$_thingName" + ", ");
    buffer.write("highLevelAlarm=" +
        (_highLevelAlarm != null ? _highLevelAlarm!.toString() : "null") +
        ", ");
    buffer.write("lowLevelAlarm=" +
        (_lowLevelAlarm != null ? _lowLevelAlarm!.toString() : "null") +
        ", ");
    buffer.write("lat=" + (_lat != null ? _lat!.toString() : "null") + ", ");
    buffer.write("lng=" + (_lng != null ? _lng!.toString() : "null") + ", ");
    buffer.write(
        "type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write(
        "height=" + (_height != null ? _height!.toString() : "null") + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("ownerCounter=" +
        (_ownerCounter != null ? _ownerCounter!.toString() : "null") +
        ", ");
    buffer.write("certificate=" + "$_certificate" + ", ");
    buffer.write("notification=" +
        (_notification != null ? _notification!.toString() : "null") +
        ", ");
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

  Device copyWith(
      {bool? active,
      String? thingName,
      int? highLevelAlarm,
      int? lowLevelAlarm,
      double? lat,
      double? lng,
      DeviceType? type,
      int? height,
      String? location,
      int? ownerCounter,
      String? certificate,
      bool? notification,
      String? serialNumber,
      String? owner}) {
    return Device._internal(
        active: active ?? this.active,
        thingName: thingName ?? this.thingName,
        highLevelAlarm: highLevelAlarm ?? this.highLevelAlarm,
        lowLevelAlarm: lowLevelAlarm ?? this.lowLevelAlarm,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        type: type ?? this.type,
        height: height ?? this.height,
        location: location ?? this.location,
        ownerCounter: ownerCounter ?? this.ownerCounter,
        certificate: certificate ?? this.certificate,
        notification: notification ?? this.notification,
        serialNumber: serialNumber ?? this.serialNumber,
        owner: owner ?? this.owner);
  }

  Device.fromJson(Map<String, dynamic> json)
      : _active = json['active'],
        _thingName = json['thingName'],
        _highLevelAlarm = (json['highLevelAlarm'] as num?)?.toInt(),
        _lowLevelAlarm = (json['lowLevelAlarm'] as num?)?.toInt(),
        _lat = (json['lat'] as num?)?.toDouble(),
        _lng = (json['lng'] as num?)?.toDouble(),
        _type = enumFromString<DeviceType>(json['type'], DeviceType.values),
        _height = (json['height'] as num?)?.toInt(),
        _location = json['location'],
        _ownerCounter = (json['ownerCounter'] as num?)?.toInt(),
        _certificate = json['certificate'],
        _notification = json['notification'],
        _serialNumber = json['serialNumber'],
        _owner = json['owner'],
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'active': _active,
        'thingName': _thingName,
        'highLevelAlarm': _highLevelAlarm,
        'lowLevelAlarm': _lowLevelAlarm,
        'lat': _lat,
        'lng': _lng,
        'type': enumToString(_type),
        'height': _height,
        'location': _location,
        'ownerCounter': _ownerCounter,
        'certificate': _certificate,
        'notification': _notification,
        'serialNumber': _serialNumber,
        'owner': _owner,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'active': _active,
        'thingName': _thingName,
        'highLevelAlarm': _highLevelAlarm,
        'lowLevelAlarm': _lowLevelAlarm,
        'lat': _lat,
        'lng': _lng,
        'type': _type,
        'height': _height,
        'location': _location,
        'ownerCounter': _ownerCounter,
        'certificate': _certificate,
        'notification': _notification,
        'serialNumber': _serialNumber,
        'owner': _owner,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryField ACTIVE = QueryField(fieldName: "active");
  static final QueryField THINGNAME = QueryField(fieldName: "thingName");
  static final QueryField HIGHLEVELALARM =
      QueryField(fieldName: "highLevelAlarm");
  static final QueryField LOWLEVELALARM =
      QueryField(fieldName: "lowLevelAlarm");
  static final QueryField LAT = QueryField(fieldName: "lat");
  static final QueryField LNG = QueryField(fieldName: "lng");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField HEIGHT = QueryField(fieldName: "height");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField OWNERCOUNTER = QueryField(fieldName: "ownerCounter");
  static final QueryField CERTIFICATE = QueryField(fieldName: "certificate");
  static final QueryField NOTIFICATION = QueryField(fieldName: "notification");
  static final QueryField SERIALNUMBER = QueryField(fieldName: "serialNumber");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Device";
    modelSchemaDefinition.pluralName = "Devices";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [ModelOperation.READ, ModelOperation.UPDATE]),
      AuthRule(
          authStrategy: AuthStrategy.GROUPS,
          groupClaim: "cognito:groups",
          groups: ["Admins"],
          provider: AuthRuleProvider.USERPOOLS,
          operations: [
            ModelOperation.CREATE,
            ModelOperation.READ,
            ModelOperation.UPDATE,
            ModelOperation.DELETE
          ])
    ];

    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["serialNumber"], name: null)
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.ACTIVE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.THINGNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.HIGHLEVELALARM,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.LOWLEVELALARM,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.LAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.LNG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.TYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.HEIGHT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.LOCATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.OWNERCOUNTER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.CERTIFICATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.NOTIFICATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.SERIALNUMBER,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Device.OWNER,
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

class _DeviceModelType extends ModelType<Device> {
  const _DeviceModelType();

  @override
  Device fromJson(Map<String, dynamic> jsonData) {
    return Device.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Device';
  }
}
