import 'package:pathfinder_for_webspark/domain/models/path_result.dart';
import 'package:pathfinder_for_webspark/domain/models/path_task.dart';

class SolvedTask {
  final PathTask task;
  final PathResult result;

  const SolvedTask({required this.task, required this.result});
}
