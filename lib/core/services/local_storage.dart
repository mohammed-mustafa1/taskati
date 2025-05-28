import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';

class LocalStorage {
  static const String name = 'userName';
  static const String image = 'UserImage';
  static const String theme = 'theme';
  static const String language = 'language';
  static late Box userBox;
  static late Box<TaskModel> taskBox;
  static init() {
    userBox = Hive.box('user');
    taskBox = Hive.box<TaskModel>('task');
  }

  static cachUserData({
    required String key,
    required String value,
  }) {
    userBox.put(key, value);
  }

  static getUserData({required String key}) => userBox.get(key);

  static cachTask({required String key, required TaskModel value}) {
    taskBox.put(key, value);
  }

  static getTask({required String key}) => taskBox.get(key);
}
