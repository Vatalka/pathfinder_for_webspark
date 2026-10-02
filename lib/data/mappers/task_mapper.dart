import 'package:pathfinder_for_webspark/core/errors/app_exception.dart';
import 'package:pathfinder_for_webspark/data/dto/point_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/result_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/step_dto.dart';
import 'package:pathfinder_for_webspark/data/dto/task_dto.dart';
import 'package:pathfinder_for_webspark/domain/models/grid.dart';
import 'package:pathfinder_for_webspark/domain/models/path_result.dart';
import 'package:pathfinder_for_webspark/domain/models/path_task.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';

// DTO -> model
class TaskMapper {
  const TaskMapper();

  List<PathTask> toDomainList(List<TaskDto> dtos) =>
      dtos.map(toDomain).toList();

  PathTask toDomain(TaskDto dto) {
    try {
      final grid = Grid.fromRows(dto.field);
      final start = _toPoint(dto.start);
      final end = _toPoint(dto.end);

      if (!grid.isInside(start) || !grid.isInside(end)) {
        throw InvalidDataException(
          'Task ${dto.id}: Start or End point is outside the grid',
        );
      }
      return PathTask(id: dto.id, grid: grid, start: start, end: end);
    } on ArgumentError catch (e) {
      throw InvalidDataException('Task ${dto.id}: ${e.message}');
    }
  }

  List<ResultDto> toResultDtoList(List<PathResult> results) =>
      results.map(toResultDto).toList();

  ResultDto toResultDto(PathResult result) {
    return ResultDto(
      id: result.id,
      result: ResultPayloadDto(
        steps: result.steps.map(_toStepDto).toList(),
        path: result.path,
      ),
    );
  }

  Point _toPoint(PointDto dto) => Point(dto.x, dto.y);

  StepDto _toStepDto(Point p) => StepDto(x: p.x.toString(), y: p.y.toString());
}
