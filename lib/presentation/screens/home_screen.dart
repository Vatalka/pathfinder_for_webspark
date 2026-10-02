import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/core/constants/app_routes.dart';
import 'package:pathfinder_for_webspark/presentation/controllers/home_controller.dart';
import 'package:provider/provider.dart';

// Екран 1.1
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    final initialUrl = context.read<HomeController>().initialUrl;
    _urlController = TextEditingController(text: initialUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _onStartPressed() async {
    FocusScope.of(context).unfocus();

    final controller = context.read<HomeController>();
    final success = await controller.start(_urlController.text);

    if (!mounted || !success) return;
    Navigator.of(context).pushNamed(AppRoutes.process);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home screen')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Set valid API base URL in order to continue'),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _urlController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        onChanged: (_) => controller.clearError(),
                        onSubmitted: (_) => _onStartPressed(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.compare_arrows),
                          hintText: 'https://example.com/flutter/api',
                          errorText: controller.errorText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.isSaving ? null : _onStartPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Start counting process'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
