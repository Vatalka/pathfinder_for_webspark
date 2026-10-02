import 'package:pathfinder_for_webspark/core/errors/app_exception.dart';
import 'package:pathfinder_for_webspark/data/mappers/task_mapper.dart';
import 'package:pathfinder_for_webspark/data/services/path_api_service.dart';
import 'package:pathfinder_for_webspark/data/storage/url_storage.dart';
import 'package:pathfinder_for_webspark/domain/models/path_result.dart';
import 'package:pathfinder_for_webspark/domain/models/path_task.dart';
import 'package:pathfinder_for_webspark/domain/pathfinding/path_finder.dart';

class PathRepository {
  final PathApiService _api;
  final TaskMapper _mapper;
  final UrlStorage _storage;
  final PathFinder _finder;

  PathRepository({
    required PathApiService api,
    required TaskMapper mapper,
    required UrlStorage storage,
    required PathFinder finder,
  }) : _api = api,
       _mapper = mapper,
       _storage = storage,
       _finder = finder;

  String? get savedUrl => _storage.read();

  Future<void> saveUrl(String url) => _storage.save(url.trim());

  Future<List<PathTask>> loadTask() async {
    final dtos = await _api.fetchTasks(_requireUrl());
    return _mapper.toDomainList(dtos);
  }

  PathResult solve(PathTask task) {
    final steps = _finder.findPath(task.grid, task.start, task.end);
    return PathResult(id: task.id, steps: steps ?? const []);
  }

  Future<void> sendResults(List<PathResult> results) async {
    final response = await _api.sendResults(
      _requireUrl(),
      _mapper.toResultDtoList(results),
    );

    final rejected = response.where((r) => !r.correct).length;
    if (rejected > 0) {
      throw ServerException('Server rejected $rejected result(s) as incorrect');
    }
  }

  String _requireUrl() {
    final url = _storage.read();
    if (url == null || url.isEmpty) {
      throw const InvalidDataException('API URL is not set');
    }
    return url;
  }
}
