import 'dart:collection';

import 'package:pathfinder_for_webspark/models/grid.dart';
import 'package:pathfinder_for_webspark/models/point.dart';
import 'package:pathfinder_for_webspark/pathfinding/movement_strategy.dart';
import 'package:pathfinder_for_webspark/pathfinding/path_finder.dart';

class BfsPathFinder implements PathFinder {
  final MovementStrategy movement;

  BfsPathFinder({MovementStrategy? movement})
    : movement = movement ?? EightDirectionMovement();

  @override
  List<Point>? findPath(Grid grid, Point start, Point end) {
    if (!grid.isWalkable(start) || !grid.isWalkable(end)) {
      return null;
    }
    if (start == end) {
      return [start];
    }

    final cameFrom = <Point, Point?>{start: null};
    final queue = Queue<Point>()..add(start);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current == end) {
        return _buildPath(cameFrom, end);
      }

      for (final next in movement.neighbors(grid, current)) {
        if (!cameFrom.containsKey(next)) {
          cameFrom[next] = current;
          queue.add(next);
        }
      }
    }
    return null; // шляху не існує
  }

  List<Point> _buildPath(Map<Point, Point?> cameFrom, Point end) {
    final path = <Point>[];
    Point? node = end;
    while (node != null) {
      path.add(node);
      node = cameFrom[node];
    }
    return path.reversed.toList();
  }
}
