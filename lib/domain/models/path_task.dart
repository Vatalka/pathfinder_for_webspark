import 'package:pathfinder_for_webspark/domain/models/grid.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';

class PathTask {
  final String id;
  final Grid grid;
  final Point start;
  final Point end;

  PathTask({
    required this.id,
    required this.grid,
    required this.start,
    required this.end,
  });
}
