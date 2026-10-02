import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/domain/models/solved_task.dart';
import 'package:pathfinder_for_webspark/presentation/widgets/grid_view_widget.dart';

// Екран 1.4
class PreviewScreen extends StatelessWidget {
  final SolvedTask solved;

  const PreviewScreen({super.key, required this.solved});

  @override
  Widget build(BuildContext context) {
    final task = solved.task;
    final result = solved.result;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: GridViewWidget(
                grid: task.grid,
                start: task.start,
                end: task.end,
                path: result.steps,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                result.hasPath ? result.path : 'No path found',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
