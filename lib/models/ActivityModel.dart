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

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:letsgt/models/ModelProvider.dart';

/** This is an auto generated class representing the ActivityModel type in your schema. */
@immutable
class ActivityModel extends Model {
  factory ActivityModel({
    String? id,
    String? activityName,
    String? activityDescription,
    LocationModel? selectedLocation,
    TemporalDateTime? selectedDate,
    List<String>? participants,
    String? createdBy,
  }) {
    return ActivityModel._internal(
      id: id == null ? UUID.getUUID() : id,
      activityName: activityName,
      activityDescription: activityDescription,
      selectedLocation: selectedLocation,
      selectedDate: selectedDate,
      participants: participants != null
          ? List<String>.unmodifiable(participants)
          : participants,
      createdBy: createdBy,
    );
  }

  const ActivityModel._internal({
    required this.id,
    String? activityName,
    String? activityDescription,
    LocationModel? selectedLocation,
    TemporalDateTime? selectedDate,
    List<String>? participants,
    String? createdBy,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  })  : _activityName = activityName,
        _activityDescription = activityDescription,
        _selectedLocation = selectedLocation,
        _selectedDate = selectedDate,
        _participants = participants,
        _createdBy = createdBy,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        _activityName = json['activityName'] as String?,
        _activityDescription = json['activityDescription'] as String?,
        _selectedLocation = json['selectedLocation']?['serializedData'] != null
            ? LocationModel.fromJson(
                new Map<String, dynamic>.from(
                  json['selectedLocation']['serializedData'] as Map,
                ),
              )
            : null,
        _selectedDate = json['selectedDate'] != null
            ? TemporalDateTime.fromString(json['selectedDate'] as String)
            : null,
        _participants = json['participants'] != null
            ? List<String>.unmodifiable(
                (json['participants'] as List).map(
                  (e) => e as String,
                ),
              )
            : null,
        _createdBy = json['createdBy'] as String?,
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
  final LocationModel? _selectedLocation;
  final TemporalDateTime? _selectedDate;
  final List<String>? _participants;
  final String? _createdBy;
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

  String? get activityName {
    return _activityName;
  }

  String? get activityDescription {
    return _activityDescription;
  }

  LocationModel? get selectedLocation {
    return _selectedLocation;
  }

  TemporalDateTime? get selectedDate {
    return _selectedDate;
  }

  List<String>? get participants {
    return _participants;
  }

  String? get createdBy {
    return _createdBy;
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
        DeepCollectionEquality().equals(_participants, other._participants) &&
        _createdBy == other._createdBy;
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
    buffer.write(
      'selectedLocation=' +
          (_selectedLocation != null ? _selectedLocation!.toString() : 'null') +
          ', ',
    );
    buffer.write(
      'selectedDate=' +
          (_selectedDate != null ? _selectedDate!.format() : 'null') +
          ', ',
    );
    buffer.write(
      'participants=' +
          (_participants != null ? _participants!.toString() : 'null') +
          ', ',
    );
    buffer.write('createdBy=' + '$_createdBy' + ', ');
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
    LocationModel? selectedLocation,
    TemporalDateTime? selectedDate,
    List<String>? participants,
    String? createdBy,
  }) {
    return ActivityModel._internal(
      id: id,
      activityName: activityName ?? this.activityName,
      activityDescription: activityDescription ?? this.activityDescription,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedDate: selectedDate ?? this.selectedDate,
      participants: participants ?? this.participants,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'activityName': _activityName,
        'activityDescription': _activityDescription,
        'selectedLocation': _selectedLocation?.toJson(),
        'selectedDate': _selectedDate?.format(),
        'participants': _participants,
        'createdBy': _createdBy,
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
        'createdBy': _createdBy,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<ActivityModelModelIdentifier>
      MODEL_IDENTIFIER = QueryModelIdentifier<ActivityModelModelIdentifier>();
  static final QueryField<String> ID = QueryField(fieldName: 'id');
  static final QueryField<String> ACTIVITYNAME =
      QueryField(fieldName: 'activityName');
  static final QueryField<String> ACTIVITYDESCRIPTION =
      QueryField(fieldName: 'activityDescription');
  static final QueryField<LocationModel> SELECTEDLOCATION =
      QueryField(fieldName: 'selectedLocation');
  static final QueryField<String> SELECTEDDATE =
      QueryField(fieldName: 'selectedDate');
  static final QueryField<List<String>> PARTICIPANTS =
      QueryField(fieldName: 'participants');
  static final QueryField<String> CREATEDBY =
      QueryField(fieldName: 'createdBy');
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
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.ACTIVITYDESCRIPTION,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.embedded(
          fieldName: 'selectedLocation',
          isRequired: false,
          ofType: ModelFieldType(
            ModelFieldTypeEnum.embedded,
            ofCustomTypeName: 'LocationModel',
          ),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.SELECTEDDATE,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.dateTime),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.PARTICIPANTS,
          isRequired: false,
          isArray: true,
          ofType: ModelFieldType(
            ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string),
          ),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: ActivityModel.CREATEDBY,
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
  const ActivityModelModelIdentifier({
    required this.id,
  });
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
