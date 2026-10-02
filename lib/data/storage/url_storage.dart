import 'package:hive/hive.dart';

abstract class UrlStorage {
  String? read();

  Future<void> save(String url);
}

class HiveUrlStorage implements UrlStorage {
  static const String boxName = 'settings';
  static const String _urlKey = 'api_url';

  final Box<String> _box;

  HiveUrlStorage(this._box);

  static Future<HiveUrlStorage> open() async {
    final box = await Hive.openBox<String>(boxName);
    return HiveUrlStorage(box);
  }

  @override
  String? read() => _box.get(_urlKey);

  @override
  Future<void> save(String url) => _box.put(_urlKey, url);
}
