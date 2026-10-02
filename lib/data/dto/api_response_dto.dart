import 'package:json_annotation/json_annotation.dart';

part 'api_response_dto.g.dart';

@JsonSerializable()
class ApiResponseDto {
  @JsonKey(defaultValue: false)
  final bool error;

  @JsonKey(defaultValue: '')
  final String message;

  final dynamic data;

  const ApiResponseDto({required this.error, required this.message, this.data});

  factory ApiResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseDtoFromJson(json);
}
