// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get Hello {
    return Intl.message(
      'Hello',
      name: 'Hello',
      desc: '',
      args: [],
    );
  }

  /// `🌞 Have a nice day 🌞`
  String get Have_a_nice_day {
    return Intl.message(
      '🌞 Have a nice day 🌞',
      name: 'Have_a_nice_day',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get add_task {
    return Intl.message(
      'Add Task',
      name: 'add_task',
      desc: '',
      args: [],
    );
  }

  /// `Update Task`
  String get update_task {
    return Intl.message(
      'Update Task',
      name: 'update_task',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter title here`
  String get title_hint {
    return Intl.message(
      'Please enter title here',
      name: 'title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get title_error {
    return Intl.message(
      'Please enter some text',
      name: 'title_error',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter description here`
  String get description_hint {
    return Intl.message(
      'Please enter description here',
      name: 'description_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get description_error {
    return Intl.message(
      'Please enter some text',
      name: 'description_error',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get start_time {
    return Intl.message(
      'Start Time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get end_time {
    return Intl.message(
      'End Time',
      name: 'end_time',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_task_button {
    return Intl.message(
      'Save',
      name: 'save_task_button',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done_button {
    return Intl.message(
      'Done',
      name: 'done_button',
      desc: '',
      args: [],
    );
  }

  /// `Please select an image`
  String get image_error {
    return Intl.message(
      'Please select an image',
      name: 'image_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get name_error {
    return Intl.message(
      'Please enter your name',
      name: 'name_error',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get name_hint {
    return Intl.message(
      'Enter Your Name',
      name: 'name_hint',
      desc: '',
      args: [],
    );
  }

  /// `start time must be before end time`
  String get time_error {
    return Intl.message(
      'start time must be before end time',
      name: 'time_error',
      desc: '',
      args: [],
    );
  }

  /// `Start time must be in the future`
  String get time_in_the_past {
    return Intl.message(
      'Start time must be in the future',
      name: 'time_in_the_past',
      desc: '',
      args: [],
    );
  }

  /// `Task is waiting for you`
  String get start_time_notification_title {
    return Intl.message(
      'Task is waiting for you',
      name: 'start_time_notification_title',
      desc: '',
      args: [],
    );
  }

  /// `Great job! The task is done `
  String get end_time_notification_title {
    return Intl.message(
      'Great job! The task is done ',
      name: 'end_time_notification_title',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get user_profile_title {
    return Intl.message(
      'User Profile',
      name: 'user_profile_title',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get theme {
    return Intl.message(
      'Dark Mode',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light_mode {
    return Intl.message(
      'Light',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark_mode {
    return Intl.message(
      'Dark',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `system`
  String get system_mode {
    return Intl.message(
      'system',
      name: 'system_mode',
      desc: '',
      args: [],
    );
  }

  /// `Open Camera`
  String get select_image_camera {
    return Intl.message(
      'Open Camera',
      name: 'select_image_camera',
      desc: '',
      args: [],
    );
  }

  /// `Select from Gallery`
  String get select_image_gallery {
    return Intl.message(
      'Select from Gallery',
      name: 'select_image_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Settings updated successfully`
  String get setting_success_message {
    return Intl.message(
      'Settings updated successfully',
      name: 'setting_success_message',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
