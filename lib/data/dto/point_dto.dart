import 'package:json_annotation/json_annotation.dart';

part 'point_dto.g.dart';

// GET: {start/end}
@JsonSerializable()
class PointDto {
  final int x;
  final int y;

  PointDto({required this.x, required this.y});

  factory PointDto.fromJson(Map<String, dynamic> json) {
    return _$PointDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PointDtoToJson(this);
}
