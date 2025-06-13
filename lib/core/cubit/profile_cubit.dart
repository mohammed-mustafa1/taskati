import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskati/core/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  String theme = 'system';
  String? language;
  changeTheme(String theme) {
    this.theme = theme;
    emit(ThemeUpdate(theme));
  }

  changeLanguage(String language) {
    this.language = language;
    emit(LanguageUpdate(language));
  }
}
