import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/core/constants/app_routes.dart';
import 'package:pathfinder_for_webspark/data/repositories/path_repository.dart';
import 'package:pathfinder_for_webspark/presentation/controllers/home_controller.dart';
import 'package:pathfinder_for_webspark/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final PathRepository repository;

  const App({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Provider<PathRepository>.value(
      value: repository,
      child: MaterialApp(
        title: 'Path Finder',
        theme: ThemeData(useMaterial3: false, primarySwatch: Colors.blue),
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => ChangeNotifierProvider(
            create: (_) => HomeController(repository: repository),
            child: const HomeScreen(),
          ),
          AppRoutes.process: (_) =>
              const Scaffold(body: Center(child: Text('Process screen'))),
        },
      ),
    );
  }
}
