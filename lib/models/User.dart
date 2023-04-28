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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _name;
  final String? _address;
  final String? _phone;
  final bool? _active;
  final String? _userName;
  final String? _subscribeStart;
  final String? _subscribeEnd;
  final String? _email;
  final String? _owner;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get address {
    return _address;
  }
  
  String? get phone {
    return _phone;
  }
  
  bool? get active {
    return _active;
  }
  
  String? get userName {
    return _userName;
  }
  
  String? get subscribeStart {
    return _subscribeStart;
  }
  
  String? get subscribeEnd {
    return _subscribeEnd;
  }
  
  String? get email {
    return _email;
  }
  
  String get owner {
    try {
      return _owner!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, name, address, phone, active, userName, subscribeStart, subscribeEnd, email, required owner, createdAt, updatedAt}): _name = name, _address = address, _phone = phone, _active = active, _userName = userName, _subscribeStart = subscribeStart, _subscribeEnd = subscribeEnd, _email = email, _owner = owner, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? name, String? address, String? phone, bool? active, String? userName, String? subscribeStart, String? subscribeEnd, String? email, required String owner}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      address: address,
      phone: phone,
      active: active,
      userName: userName,
      subscribeStart: subscribeStart,
      subscribeEnd: subscribeEnd,
      email: email,
      owner: owner);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _name == other._name &&
      _address == other._address &&
      _phone == other._phone &&
      _active == other._active &&
      _userName == other._userName &&
      _subscribeStart == other._subscribeStart &&
      _subscribeEnd == other._subscribeEnd &&
      _email == other._email &&
      _owner == other._owner;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("subscribeStart=" + "$_subscribeStart" + ", ");
    buffer.write("subscribeEnd=" + "$_subscribeEnd" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? name, String? address, String? phone, bool? active, String? userName, String? subscribeStart, String? subscribeEnd, String? email, String? owner}) {
    return User._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      active: active ?? this.active,
      userName: userName ?? this.userName,
      subscribeStart: subscribeStart ?? this.subscribeStart,
      subscribeEnd: subscribeEnd ?? this.subscribeEnd,
      email: email ?? this.email,
      owner: owner ?? this.owner);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _address = json['address'],
      _phone = json['phone'],
      _active = json['active'],
      _userName = json['userName'],
      _subscribeStart = json['subscribeStart'],
      _subscribeEnd = json['subscribeEnd'],
      _email = json['email'],
      _owner = json['owner'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'address': _address, 'phone': _phone, 'active': _active, 'userName': _userName, 'subscribeStart': _subscribeStart, 'subscribeEnd': _subscribeEnd, 'email': _email, 'owner': _owner, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'name': _name, 'address': _address, 'phone': _phone, 'active': _active, 'userName': _userName, 'subscribeStart': _subscribeStart, 'subscribeEnd': _subscribeEnd, 'email': _email, 'owner': _owner, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField ACTIVE = QueryField(fieldName: "active");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField SUBSCRIBESTART = QueryField(fieldName: "subscribeStart");
  static final QueryField SUBSCRIBEEND = QueryField(fieldName: "subscribeEnd");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.READ,
          ModelOperation.UPDATE
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["owner"], name: null)
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ACTIVE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SUBSCRIBESTART,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SUBSCRIBEEND,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.OWNER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}