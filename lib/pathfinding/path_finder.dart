import 'package:pathfinder_for_webspark/models/grid.dart';
import 'package:pathfinder_for_webspark/models/point.dart';

abstract class PathFinder {
  List<Point>? findPath(Grid grid, Point start, Point end);
}
