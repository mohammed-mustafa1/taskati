import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_notification.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/themes.dart';
import 'package:taskati/features/intro/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  await Hive.openBox('user');
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.openBox<TaskModel>('task');
  LocalStorage.init();
  tz.initializeTimeZones();
  LocalNotificationService.init();
  runApp(Taskati());
}

class Taskati extends StatefulWidget {
  const Taskati({super.key});

  @override
  State<Taskati> createState() => _TaskatiState();
}

class _TaskatiState extends State<Taskati> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: LocalStorage.userBox.listenable(),
        builder: (context, value, child) {
          var language = value.get(LocalStorage.language);
          return MaterialApp(
            locale: Locale(language ?? 'en'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: value.get(LocalStorage.theme) == 'dark'
                ? AppTheme.darkTheme
                : AppTheme.litheTheme,
            home: SplashScreen(),
          );
        });
  }
}
