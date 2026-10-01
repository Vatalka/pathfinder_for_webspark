import 'package:pathfinder_for_webspark/domain/models/point.dart';

class PathResult {
  final String id;
  final List<Point> steps;

  PathResult({required this.id, required this.steps});

  bool get hasPath => steps.isNotEmpty;

  String get path => steps.join('->');
}
