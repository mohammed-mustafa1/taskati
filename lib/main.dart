import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/intro/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  await Hive.openBox('user');
  LocalStorage.init();
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: value.get(LocalStorage.theme) == 'dark'
                  ? Brightness.dark
                  : Brightness.light,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              fontFamily: 'Poppins',
            ),
            home: SplashScreen(),
          );
        });
  }
}
