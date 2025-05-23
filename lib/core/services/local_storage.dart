import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String name = 'name';
  static const String image = 'image';
  static late Box _box;
  static init() {
    _box = Hive.box('user');
  }

  static cashData({
    required String key,
    required String value,
  }) {
    _box.put(key, value);
  }

  static getData({required String key}) => _box.get(key);
}
