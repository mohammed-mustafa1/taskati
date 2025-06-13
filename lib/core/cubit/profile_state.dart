abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ThemeUpdate extends ProfileState {
  ThemeUpdate(String theme);
}

class LanguageUpdate extends ProfileState {
  LanguageUpdate(String language);
}
