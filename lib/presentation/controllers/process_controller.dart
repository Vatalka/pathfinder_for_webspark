import 'package:flutter/foundation.dart';
import 'package:pathfinder_for_webspark/core/errors/app_exception.dart';
import 'package:pathfinder_for_webspark/data/repositories/path_repository.dart';
import 'package:pathfinder_for_webspark/domain/models/solved_task.dart';

enum ProcessStatus { loading, calculating, ready, sending, failed }

// Стан екрана 1.2
class ProcessController extends ChangeNotifier {
  final PathRepository _repository;

  ProcessController({required PathRepository repository})
    : _repository = repository;

  final List<SolvedTask> _solved = [];
  ProcessStatus _status = ProcessStatus.loading;
  double _progress = 0;
  String? _errorText;
  bool _disposed = false;

  ProcessStatus get status => _status;

  double get progress => _progress;

  int get percent => (_progress * 100).round();

  String? get errorText => _errorText;

  List<SolvedTask> get solved => List.unmodifiable(_solved);

  Future<void> run() async {
    _solved.clear();
    _progress = 0;
    _errorText = null;
    _setStatus(ProcessStatus.loading);

    try {
      final tasks = await _repository.loadTask();
      if (_disposed) return;

      _setStatus(ProcessStatus.calculating);

      for (var i = 0; i < tasks.length; i++) {
        final task = tasks[i];
        _solved.add(SolvedTask(task: task, result: _repository.solve(task)));
        _progress = (i + 1) / tasks.length;
        _notify();

        await Future<void>.delayed(Duration.zero);
        if (_disposed) return;
      }

      _progress = 1;
      _setStatus(ProcessStatus.ready);
    } on AppException catch (e) {
      _fail(e.message);
    } catch (_) {
      _fail('Something went wrong while calculating');
    }
  }

  Future<bool> sendResults() async {
    if (_status != ProcessStatus.ready) return false;

    _errorText = null;
    _setStatus(ProcessStatus.sending);

    try {
      await _repository.sendResults(_solved.map((s) => s.result).toList());
      _setStatus(ProcessStatus.ready);
      return true;
    } on AppException catch (e) {
      _errorText = e.message;
    } catch (_) {
      _errorText = 'Failed to send the results';
    }
    _setStatus(ProcessStatus.ready);
    return false;
  }

  void _fail(String message) {
    _errorText = message;
    _setStatus(ProcessStatus.failed);
  }

  void _setStatus(ProcessStatus status) {
    _status = status;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
