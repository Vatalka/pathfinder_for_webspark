// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultDto _$ResultDtoFromJson(Map<String, dynamic> json) => ResultDto(
  id: json['id'] as String,
  result: ResultPayloadDto.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResultDtoToJson(ResultDto instance) => <String, dynamic>{
  'id': instance.id,
  'result': instance.result.toJson(),
};

ResultPayloadDto _$ResultPayloadDtoFromJson(Map<String, dynamic> json) =>
    ResultPayloadDto(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
    );

Map<String, dynamic> _$ResultPayloadDtoToJson(ResultPayloadDto instance) =>
    <String, dynamic>{
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'path': instance.path,
    };
