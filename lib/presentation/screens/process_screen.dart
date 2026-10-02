import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/core/constants/app_routes.dart';
import 'package:pathfinder_for_webspark/presentation/controllers/process_controller.dart';
import 'package:provider/provider.dart';

// Екран 1.2
class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  Future<void> _onSendPressed(BuildContext context) async {
    final controller = context.read<ProcessController>();
    final success = await controller.sendResults();

    if (!context.mounted || !success) return;
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.results, arguments: controller.solved);
  }

  String _statusText(ProcessStatus status) {
    switch (status) {
      case ProcessStatus.loading:
        return 'Loading tasks from the server...';
      case ProcessStatus.calculating:
        return 'Calculating, please wait...';
      case ProcessStatus.ready:
      case ProcessStatus.sending:
        return 'All calculations has finished, you can send your results to server';
      case ProcessStatus.failed:
        return 'Could not complete the calculation';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProcessController>();
    final status = controller.status;

    return Scaffold(
      appBar: AppBar(title: const Text('Process screen')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _statusText(status),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (status != ProcessStatus.loading &&
                            status != ProcessStatus.failed) ...[
                          const SizedBox(height: 16),
                          Text(
                            '${controller.percent}%',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                        const SizedBox(height: 24),
                        if (status != ProcessStatus.failed)
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: status == ProcessStatus.loading
                                  ? null
                                  : controller.progress,
                              strokeWidth: 4,
                            ),
                          ),
                        if (controller.errorText != null) ...[
                          const SizedBox(height: 24),
                          Text(
                            controller.errorText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              _buildButton(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, ProcessController controller) {
    final status = controller.status;

    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlueAccent,
      foregroundColor: Colors.black,
    );

    if (status == ProcessStatus.failed) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: controller.run,
          style: style,
          child: const Text('Try again'),
        ),
      );
    }

    if (status == ProcessStatus.ready || status == ProcessStatus.sending) {
      final isSending = status == ProcessStatus.sending;
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: isSending ? null : () => _onSendPressed(context),
          style: style,
          child: isSending
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 3),
                )
              : const Text('Send results to server'),
        ),
      );
    }
    return const SizedBox(height: 48);
  }
}
