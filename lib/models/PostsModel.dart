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

/** This is an auto generated class representing the PostsModel type in your schema. */
@immutable
class PostsModel extends Model {
  factory PostsModel({
    String? id,
    String? description,
    String? createdBy,
    String? shortLocation,
    String? imageURL,
  }) {
    return PostsModel._internal(
      id: id == null ? UUID.getUUID() : id,
      description: description,
      createdBy: createdBy,
      shortLocation: shortLocation,
      imageURL: imageURL,
    );
  }
  const PostsModel._internal({
    required this.id,
    String? description,
    String? createdBy,
    String? shortLocation,
    String? imageURL,
    TemporalDateTime? createdAt,
    TemporalDateTime? updatedAt,
  })  : _description = description,
        _createdBy = createdBy,
        _shortLocation = shortLocation,
        _imageURL = imageURL,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  PostsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        _description = json['description'] as String?,
        _createdBy = json['createdBy'] as String?,
        _shortLocation = json['shortLocation'] as String?,
        _imageURL = json['imageURL'] as String?,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'] as String)
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'] as String)
            : null;
  static const classType = const _PostsModelModelType();
  final String id;
  final String? _description;
  final String? _createdBy;
  final String? _shortLocation;
  final String? _imageURL;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  _PostsModelModelType getInstanceType() => classType;

  @Deprecated(
    '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.',
  )
  @override
  String getId() => id;

  PostsModelModelIdentifier get modelIdentifier {
    return PostsModelModelIdentifier(
      id: id,
    );
  }

  String? get description {
    return _description;
  }

  String? get createdBy {
    return _createdBy;
  }

  String? get shortLocation {
    return _shortLocation;
  }

  String? get imageURL {
    return _imageURL;
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
    return other is PostsModel &&
        id == other.id &&
        _description == other._description &&
        _createdBy == other._createdBy &&
        _shortLocation == other._shortLocation &&
        _imageURL == other._imageURL;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = new StringBuffer();

    buffer.write('PostsModel {');
    buffer.write('id=' + '$id' + ', ');
    buffer.write('description=' + '$_description' + ', ');
    buffer.write('createdBy=' + '$_createdBy' + ', ');
    buffer.write('shortLocation=' + '$_shortLocation' + ', ');
    buffer.write('imageURL=' + '$_imageURL' + ', ');
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

  PostsModel copyWith({
    String? description,
    String? createdBy,
    String? shortLocation,
    String? imageURL,
  }) {
    return PostsModel._internal(
      id: id,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      shortLocation: shortLocation ?? this.shortLocation,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': _description,
        'createdBy': _createdBy,
        'shortLocation': _shortLocation,
        'imageURL': _imageURL,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'description': _description,
        'createdBy': _createdBy,
        'shortLocation': _shortLocation,
        'imageURL': _imageURL,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<PostsModelModelIdentifier>
      MODEL_IDENTIFIER = QueryModelIdentifier<PostsModelModelIdentifier>();
  static final QueryField<String> ID = QueryField(fieldName: 'id');
  static final QueryField<String> DESCRIPTION =
      QueryField(fieldName: 'description');
  static final QueryField<String> CREATEDBY =
      QueryField(fieldName: 'createdBy');
  static final QueryField<String> SHORTLOCATION =
      QueryField(fieldName: 'shortLocation');
  static final QueryField<String> IMAGEURL = QueryField(fieldName: 'imageURL');
  static ModelSchema schema = Model.defineSchema(
    define: (ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = 'PostsModel';
      modelSchemaDefinition.pluralName = 'PostsModels';

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
          key: PostsModel.DESCRIPTION,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: PostsModel.CREATEDBY,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: PostsModel.SHORTLOCATION,
          isRequired: false,
          ofType: ModelFieldType(ModelFieldTypeEnum.string),
        ),
      );

      modelSchemaDefinition.addField(
        ModelFieldDefinition.field(
          key: PostsModel.IMAGEURL,
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

class _PostsModelModelType extends ModelType<PostsModel> {
  const _PostsModelModelType();

  @override
  PostsModel fromJson(Map<String, dynamic> jsonData) {
    return PostsModel.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'PostsModel';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [PostsModel] in your schema.
 */
@immutable
class PostsModelModelIdentifier implements ModelIdentifier<PostsModel> {
  /** Create an instance of PostsModelModelIdentifier using [id] the primary key. */
  const PostsModelModelIdentifier({required this.id});
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
  String toString() => 'PostsModelModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PostsModelModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
