import 'package:flutter/foundation.dart';
import 'package:pathfinder_for_webspark/models/grid.dart';
import 'package:pathfinder_for_webspark/models/point.dart';
import 'package:pathfinder_for_webspark/pathfinding/bfs_path_finder.dart';
import 'package:pathfinder_for_webspark/pathfinding/path_finder.dart';

void main() {
  final field = Grid.fromRows(['XXX.', 'X..X', 'X..X', '.XXX']);

  final PathFinder finder = BfsPathFinder();
  final path = finder.findPath(field, const Point(0, 3), const Point(3, 0));

  if (kDebugMode) {
    print(path?.join('->') ?? 'Шляху не існує');
  }
}
