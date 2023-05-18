// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ActivityModel _$$_ActivityModelFromJson(Map<String, dynamic> json) =>
    _$_ActivityModel(
      id: json['id'] as String?,
      activityName: json['activityName'] as String?,
      activityDescription: json['activityDescription'] as String?,
      activityLocation: json['activityLocation'] as String?,
      activityDate: json['activityDate'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ActivityModelToJson(_$_ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityName': instance.activityName,
      'activityDescription': instance.activityDescription,
      'activityLocation': instance.activityLocation,
      'activityDate': instance.activityDate,
      'participants': instance.participants,
    };
