import 'package:json_annotation/json_annotation.dart';

part 'send_response_dto.g.dart';

// POST: {id, correct}
@JsonSerializable()
class SendResponseDto {
  final String id;
  final bool correct;

  const SendResponseDto({required this.id, required this.correct});

  factory SendResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SendResponseDtoFromJson(json);
}
