import 'package:json_annotation/json_annotation.dart';
import 'package:pathfinder_for_webspark/data/dto/step_dto.dart';

part 'result_dto.g.dart';

// POST: {id, result: {steps, path}}
@JsonSerializable(explicitToJson: true)
class ResultDto {
  final String id;
  final ResultPayloadDto result;

  const ResultDto({required this.id, required this.result});

  factory ResultDto.fromJson(Map<String, dynamic> json) =>
      _$ResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResultPayloadDto {
  final List<StepDto> steps;
  final String path;

  const ResultPayloadDto({required this.steps, required this.path});

  factory ResultPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$ResultPayloadDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResultPayloadDtoToJson(this);
}