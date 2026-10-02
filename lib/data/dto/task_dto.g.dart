// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
  id: json['id'] as String,
  field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
  start: PointDto.fromJson(json['start'] as Map<String, dynamic>),
  end: PointDto.fromJson(json['end'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
  'id': instance.id,
  'field': instance.field,
  'start': instance.start,
  'end': instance.end,
};
