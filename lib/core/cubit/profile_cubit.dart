import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskati/core/cubit/profile_state.dart';
import 'package:taskati/core/services/local_notification.dart';
import 'package:taskati/core/services/local_storage.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  var cachUserData = LocalStorage.cachUserData;

  String theme = LocalStorage.getUserData(key: LocalStorage.theme) ?? 'system';
  String language =
      LocalStorage.getUserData(key: LocalStorage.language) ?? 'en';

  bool isNotificationEnabled =
      LocalStorage.getUserData(key: LocalStorage.isNotificationsEnabled) ??
          true;

  String imagePath = LocalStorage.getUserData(key: LocalStorage.image) ?? '';
  String name = LocalStorage.getUserData(key: LocalStorage.name) ?? '';

  changeTheme(String theme) {
    this.theme = theme;
    cachUserData(key: LocalStorage.theme, value: theme);
    emit(ThemeUpdate(theme));
  }

  changeLanguage(String language) {
    this.language = language;
    cachUserData(key: LocalStorage.language, value: language);
    emit(LanguageUpdate(language));
  }

  changeNameAndImage(String name, String imagePath) {
    this.name = name;
    this.imagePath = imagePath;
    cachUserData(key: LocalStorage.name, value: name);
    cachUserData(key: LocalStorage.image, value: imagePath);
    emit(NameAndImageUpdate(name: name, imagePath: imagePath));
  }

  changeNotification(bool isNotificationEnabled) async {
    var pendingNotifications =
        await LocalNotificationService.getPendingNotifications();

    if (isNotificationEnabled && pendingNotifications.isEmpty) {
      await LocalNotificationService.rescheduleNotifications();
    } else if (isNotificationEnabled == false) {
      await LocalNotificationService.cancelAllNotifications();
    }
    this.isNotificationEnabled = isNotificationEnabled;
    cachUserData(
        key: LocalStorage.isNotificationsEnabled, value: isNotificationEnabled);
    emit(NotificationsUpdate(isNotificationEnabled));
  }
}
