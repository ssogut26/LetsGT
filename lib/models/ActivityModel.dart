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

/** This is an auto generated class representing the ActivityModel type in your schema. */
@immutable
class ActivityModel extends Model {
  factory ActivityModel({
    required String activityName,
    required String activityDescription,
    required String selectedLocation,
    required String selectedDate,
    String? id,
    String? participants,
  }) {
    return ActivityModel._internal(
      id: id == null ? UUID.getUUID() : id,
      activityName: activityName,
      activityDescription: activityDescription,
      selectedLocation: selectedLocation,
      selectedDate: selectedDate,
      participants: participants,
    );
  }
  const ActivityModel._internal({
    required this.id,
    required String? activityName,
    required String? activityDescription,
    required String? selectedLocation,
    required String? selectedDate,
    String? participants,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  })  : _activityName = activityName,
        _activityDescription = activityDescription,
        _selectedLocation = selectedLocation,
        _selectedDate = selectedDate,
        _participants = participants,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        _activityName = json['activityName'] as String?,
        _activityDescription = json['activityDescription'] as String?,
        _selectedLocation = json['selectedLocation'] as String?,
        _selectedDate = json['selectedDate'] as String?,
        _participants = json['participants'] as String?,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'] as String)
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'] as String)
            : null;
  static const classType = const _ActivityModelModelType();
  final String id;
  final String? _activityName;
  final String? _activityDescription;
  final String? _selectedLocation;
  final String? _selectedDate;
  final String? _participants;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  _ActivityModelModelType getInstanceType() => classType;

  @Deprecated(
    '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.',
  )
  @override
  String getId() => id;

  ActivityModelModelIdentifier get modelIdentifier {
    return ActivityModelModelIdentifier(
      id: id,
    );
  }

  String get activityName {
    try {
      return _activityName!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
        AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String get activityDescription {
    try {
      return _activityDescription!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
        AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String get selectedLocation {
    try {
      return _selectedLocation!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
        AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String get selectedDate {
    try {
      return _selectedDate!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
        AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String? get participants {
    return _participants;
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
    return other is ActivityModel &&
        id == other.id &&
        _activityName == other._activityName &&
        _activityDescription == other._activityDescription &&
        _selectedLocation == other._selectedLocation &&
        _selectedDate == other._selectedDate &&
        _participants == other._participants;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = new StringBuffer();

    buffer.write('ActivityModel {');
    buffer.write('id=' + '$id' + ', ');
    buffer.write('activityName=' + '$_activityName' + ', ');
    buffer.write('activityDescription=' + '$_activityDescription' + ', ');
    buffer.write('selectedLocation=' + '$_selectedLocation' + ', ');
    buffer.write('selectedDate=' + '$_selectedDate' + ', ');
    buffer.write('participants=' + '$_participants' + ', ');
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

  ActivityModel copyWith({
    String? activityName,
    String? activityDescription,
    String? selectedLocation,
    String? selectedDate,
    String? participants,
  }) {
    return ActivityModel._internal(
      id: id,
      activityName: activityName ?? this.activityName,
      activityDescription: activityDescription ?? this.activityDescription,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedDate: selectedDate ?? this.selectedDate,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'activityName': _activityName,
        'activityDescription': _activityDescription,
        'selectedLocation': _selectedLocation,
        'selectedDate': _selectedDate,
        'participants': _participants,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'activityName': _activityName,
        'activityDescription': _activityDescription,
        'selectedLocation': _selectedLocation,
        'selectedDate': _selectedDate,
        'participants': _participants,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<ActivityModelModelIdentifier>
      MODEL_IDENTIFIER = QueryModelIdentifier<ActivityModelModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: 'id');
  static final QueryField ACTIVITYNAME = QueryField(fieldName: 'activityName');
  static final QueryField ACTIVITYDESCRIPTION =
      QueryField(fieldName: 'activityDescription');
  static final QueryField SELECTEDLOCATION =
      QueryField(fieldName: 'selectedLocation');
  static final QueryField SELECTEDDATE = QueryField(fieldName: 'selectedDate');
  static final QueryField PARTICIPANTS = QueryField(fieldName: 'participants');
  static ModelSchema schema = Model.defineSchema(
    define: (ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = 'ActivityModel';
      modelSchemaDefinition.pluralName = 'ActivityModels';

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
          key: ActivityModel.ACTIVITYNAME,
          isRequired: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.ACTIVITYDESCRIPTION,
          isRequired: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.SELECTEDLOCATION,
          isRequired: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.SELECTEDDATE,
          isRequired: true,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.PARTICIPANTS,
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

class _ActivityModelModelType extends ModelType<ActivityModel> {
  const _ActivityModelModelType();

  @override
  ActivityModel fromJson(Map<String, dynamic> jsonData) {
    return ActivityModel.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'ActivityModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ActivityModel] in your schema.
 */
@immutable
class ActivityModelModelIdentifier implements ModelIdentifier<ActivityModel> {
  /** Create an instance of ActivityModelModelIdentifier using [id] the primary key. */
  const ActivityModelModelIdentifier({required this.id});
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
  String toString() => 'ActivityModelModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ActivityModelModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
