import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/intro/splash_screen.dart';

void main() {
  runApp(Taskati());
}

class Taskati extends StatelessWidget {
  const Taskati({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
  }
}
