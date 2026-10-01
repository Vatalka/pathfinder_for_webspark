import 'package:pathfinder_for_webspark/domain/models/grid.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';

abstract class PathFinder {
  List<Point>? findPath(Grid grid, Point start, Point end);
}
