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

/** This is an auto generated class representing the UserModel type in your schema. */
@immutable
class UserModel extends Model {
  factory UserModel({
    String? id,
    String? userName,
    String? location,
    String? userStatus,
  }) {
    return UserModel._internal(
      id: id == null ? UUID.getUUID() : id,
      userName: userName,
      location: location,
      userStatus: userStatus,
    );
  }
  const UserModel._internal({
    required this.id,
    String? userName,
    String? location,
    String? userStatus,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  })  : _userName = userName,
        _location = location,
        _userStatus = userStatus,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        _userName = json['userName'] as String?,
        _location = json['location'] as String?,
        _userStatus = json['userStatus'] as String?,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'] as String)
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'] as String)
            : null;
  static const classType = const _UserModelModelType();
  final String id;
  final String? _userName;
  final String? _location;
  final String? _userStatus;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  _UserModelModelType getInstanceType() => classType;

  @Deprecated(
    '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.',
  )
  @override
  String getId() => id;

  UserModelModelIdentifier get modelIdentifier {
    return UserModelModelIdentifier(
      id: id,
    );
  }

  String? get userName {
    return _userName;
  }

  String? get location {
    return _location;
  }

  String? get userStatus {
    return _userStatus;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        id == other.id &&
        _userName == other._userName &&
        _location == other._location &&
        _userStatus == other._userStatus;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = new StringBuffer();

    buffer.write('UserModel {');
    buffer.write('id=' + '$id' + ', ');
    buffer.write('userName=' + '$_userName' + ', ');
    buffer.write('location=' + '$_location' + ', ');
    buffer.write('userStatus=' + '$_userStatus' + ', ');
    buffer.write(
      'createdAt=' +
          (_createdAt != null ? _createdAt!.format() : 'null') +
          ', ',
    );
    buffer.write(
      'updatedAt=' + (_updatedAt != null ? _updatedAt!.format() : 'null'),
    );
    buffer.write('}');

    return buffer.toString();
  }

  UserModel copyWith({String? userName, String? location, String? userStatus}) {
    return UserModel._internal(
      id: id,
      userName: userName ?? this.userName,
      location: location ?? this.location,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': _userName,
        'location': _location,
        'userStatus': _userStatus,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'userName': _userName,
        'location': _location,
        'userStatus': _userStatus,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<UserModelModelIdentifier> MODEL_IDENTIFIER =
      QueryModelIdentifier<UserModelModelIdentifier>();
  static final QueryField<String> ID = QueryField(fieldName: 'id');
  static final QueryField<String> USERNAME = QueryField(fieldName: 'userName');
  static final QueryField<String> LOCATION = QueryField(fieldName: 'location');
  static final QueryField<String> USERSTATUS =
      QueryField(fieldName: 'userStatus');
  static ModelSchema schema = Model.defineSchema(
    define: (ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = 'UserModel';
      modelSchemaDefinition.pluralName = 'UserModels';

      modelSchemaDefinition.authRules = [
        AuthRule(
          authStrategy: AuthStrategy.PRIVATE,
          operations: const [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ],
        )
      ];

      modelSchemaDefinition.addField(ModelFieldDefinition.id());

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: UserModel.USERNAME,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: UserModel.LOCATION,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: UserModel.USERSTATUS,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.nonQueryField(
          fieldName: 'createdAt',
          isRequired: false,
          isReadOnly: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.dateTime),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.nonQueryField(
          fieldName: 'updatedAt',
          isRequired: false,
          isReadOnly: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.dateTime),
        ),
      );
    },
  );
}

class _UserModelModelType extends ModelType<UserModel> {
  const _UserModelModelType();

  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'UserModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserModel] in your schema.
 */
@immutable
class UserModelModelIdentifier implements ModelIdentifier<UserModel> {
  /** Create an instance of UserModelModelIdentifier using [id] the primary key. */
  const UserModelModelIdentifier({required this.id});
  final String id;

  @override
  Map<String, dynamic> serializeAsMap() => <String, dynamic>{'id': id};

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => <String, dynamic>{entry.key: entry.value})
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'UserModelModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is UserModelModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
