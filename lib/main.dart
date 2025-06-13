import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/cubit/profile_cubit.dart';
import 'package:taskati/core/cubit/profile_state.dart';
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

class Taskati extends StatelessWidget {
  const Taskati({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String savedlanguage =
              LocalStorage.getUserData(key: LocalStorage.language) ?? 'en';

          var cubit = BlocProvider.of<ProfileCubit>(context);
          String systemTeheme = MediaQuery.of(context).platformBrightness.name;
          return MaterialApp(
            theme: cubit.theme == 'system'
                ? systemTeheme == Brightness.light.name
                    ? AppTheme.litheTheme
                    : AppTheme.darkTheme
                : cubit.theme == 'light'
                    ? AppTheme.litheTheme
                    : AppTheme.darkTheme,
            home: SplashScreen(),
            locale: Locale(cubit.language ?? savedlanguage),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
