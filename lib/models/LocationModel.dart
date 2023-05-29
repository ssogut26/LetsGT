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

/** This is an auto generated class representing the LocationModel type in your schema. */
@immutable
class LocationModel {
  factory LocationModel({
    String? fullLocation,
    String? longitude,
    String? latitude,
  }) {
    return LocationModel._internal(
      fullLocation: fullLocation,
      longitude: longitude,
      latitude: latitude,
    );
  }
  const LocationModel._internal({
    String? fullLocation,
    String? longitude,
    String? latitude,
  })  : _fullLocation = fullLocation,
        _longitude = longitude,
        _latitude = latitude;

  LocationModel.fromJson(Map<String, dynamic> json)
      : _fullLocation = json['fullLocation'] as String?,
        _longitude = json['longitude'] as String?,
        _latitude = json['latitude'] as String?;
  final String? _fullLocation;
  final String? _longitude;
  final String? _latitude;

  String? get fullLocation {
    return _fullLocation;
  }

  String? get longitude {
    return _longitude;
  }

  String? get latitude {
    return _latitude;
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationModel &&
        _fullLocation == other._fullLocation &&
        _longitude == other._longitude &&
        _latitude == other._latitude;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = new StringBuffer();

    buffer.write('LocationModel {');
    buffer.write('fullLocation=' + '$_fullLocation' + ', ');
    buffer.write('longitude=' + '$_longitude' + ', ');
    buffer.write('latitude=' + '$_latitude');
    buffer.write('}');

    return buffer.toString();
  }

  LocationModel copyWith({
    String? fullLocation,
    String? longitude,
    String? latitude,
  }) {
    return LocationModel._internal(
      fullLocation: fullLocation ?? this.fullLocation,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullLocation': _fullLocation,
        'longitude': _longitude,
        'latitude': _latitude
      };

  Map<String, Object?> toMap() => {
        'fullLocation': _fullLocation,
        'longitude': _longitude,
        'latitude': _latitude
      };

  static ModelSchema schema = Model.defineSchema(
    define: (ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = 'LocationModel';
      modelSchemaDefinition.pluralName = 'LocationModels';

      modelSchemaDefinition.addField(
        ModelFieldDefinition.customTypeField(
          fieldName: 'fullLocation',
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.customTypeField(
          fieldName: 'longitude',
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.customTypeField(
          fieldName: 'latitude',
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );
    },
  );
}
