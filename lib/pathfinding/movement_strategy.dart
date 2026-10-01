import 'package:pathfinder_for_webspark/models/grid.dart';
import 'package:pathfinder_for_webspark/models/point.dart';

abstract class MovementStrategy {
  Iterable<Point> neighbors(Grid grid, Point from);
}

class EightDirectionMovement implements MovementStrategy {
  static const List<Point> _offsets = [
    Point(0, -1), // вгору
    Point(1, 0), // праворуч
    Point(0, 1), // вниз
    Point(-1, 0), // ліворуч
    Point(1, -1), // вгору-праворуч
    Point(1, 1), // вниз-праворуч
    Point(-1, 1), // вниз-ліворуч
    Point(-1, -1), // вгору-ліворуч
  ];

  @override
  Iterable<Point> neighbors(Grid grid, Point from) sync* {
    for (final offset in _offsets) {
      final next = from + offset;
      if (grid.isWalkable(next)) {
        yield next;
      }
    }
  }
}
