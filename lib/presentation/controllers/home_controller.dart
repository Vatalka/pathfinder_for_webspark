import 'package:flutter/foundation.dart';
import 'package:pathfinder_for_webspark/core/utils/url_validator.dart';
import 'package:pathfinder_for_webspark/data/repositories/path_repository.dart';

// Стан екрана 1.1
class HomeController extends ChangeNotifier {
  final PathRepository _repository;
  final UrlValidator _validator;

  HomeController({
    required PathRepository repository,
    UrlValidator validator = const UrlValidator(),
  }) : _repository = repository,
       _validator = validator;

  String? _errorText;
  bool _isSaving = false;

  String get initialUrl => _repository.savedUrl ?? '';

  String? get errorText => _errorText;

  bool get isSaving => _isSaving;

  Future<bool> start(String input) async {
    final error = _validator.validate(input);

    if (error != null) {
      _errorText = error;
      notifyListeners();
      return false;
    }

    _errorText = null;
    _isSaving = true;
    notifyListeners();

    try {
      await _repository.saveUrl(input);
      return true;
    } catch (_) {
      _errorText = 'Failed to save the URL';
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void clearError() {
    if (_errorText != null) {
      _errorText = null;
      notifyListeners();
    }
  }
}
