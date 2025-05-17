import 'package:flutter/material.dart';
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
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}
