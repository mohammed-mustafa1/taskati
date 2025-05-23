import 'package:flutter/material.dart';
import 'package:taskati/features/home/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: HomeBody()),
    );
  }
}
