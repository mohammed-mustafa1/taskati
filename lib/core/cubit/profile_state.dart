abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ThemeUpdate extends ProfileState {
  ThemeUpdate(String theme);
}

class LanguageUpdate extends ProfileState {
  LanguageUpdate(String language);
}

class NotificationsUpdate extends ProfileState {
  NotificationsUpdate(bool isNotificationEnabled);
}

class NameAndImageUpdate extends ProfileState {
  NameAndImageUpdate({required String name, required String imagePath});
}
