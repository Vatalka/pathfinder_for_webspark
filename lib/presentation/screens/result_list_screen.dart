import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/core/constants/app_routes.dart';
import 'package:pathfinder_for_webspark/domain/models/solved_task.dart';

// Екран 1.3
class ResultListScreen extends StatelessWidget {
  final List<SolvedTask> solved;

  const ResultListScreen({super.key, required this.solved});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: solved.isEmpty
          ? const Center(child: Text('No results'))
          : ListView.separated(
              itemCount: solved.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = solved[index];
                final text = item.result.hasPath
                    ? item.result.path
                    : 'No path found';

                return ListTile(
                  title: Center(child: Text(text)),
                  onTap: () => Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.preview, arguments: item),
                );
              },
            ),
    );
  }
}
