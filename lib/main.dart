import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pathfinder_for_webspark/data/mappers/task_mapper.dart';
import 'package:pathfinder_for_webspark/data/repositories/path_repository.dart';
import 'package:pathfinder_for_webspark/data/services/path_api_service.dart';
import 'package:pathfinder_for_webspark/data/storage/url_storage.dart';
import 'package:pathfinder_for_webspark/domain/pathfinding/bfs_path_finder.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final storage = await HiveUrlStorage.open();
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  final repository = PathRepository(
    api: PathApiService(dio),
    mapper: const TaskMapper(),
    storage: storage,
    finder: BfsPathFinder(),
  );

  runApp(App(repository: repository));
}
