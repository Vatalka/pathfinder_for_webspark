import 'package:json_annotation/json_annotation.dart';
import 'package:pathfinder_for_webspark/data/dto/point_dto.dart';

part 'task_dto.g.dart';

// GET: {id, field, start, end}
@JsonSerializable()
class TaskDto {
  final String id;
  final List<String> field;
  final PointDto start;
  final PointDto end;

  TaskDto({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return _$TaskDtoFromJson(json);
  }
}
