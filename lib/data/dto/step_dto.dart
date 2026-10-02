import 'package:json_annotation/json_annotation.dart';

part 'step_dto.g.dart';

// POST: {step}
@JsonSerializable()
class StepDto {
  final String x;
  final String y;

  StepDto({required this.x, required this.y});

  factory StepDto.fromJson(Map<String, dynamic> json) =>
      _$StepDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StepDtoToJson(this);
}
