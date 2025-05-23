import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String name = 'name';
  static const String image = 'image';
  static const String theme = 'theme';
  static late Box userBox;
  static init() {
    userBox = Hive.box('user');
  }

  static cashData({
    required String key,
    required String value,
  }) {
    userBox.put(key, value);
  }

  static getData({required String key}) => userBox.get(key);
}
