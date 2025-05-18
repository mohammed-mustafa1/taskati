import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/intro/setup_profile_screen.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.pushReplacement(const SetupProfileScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImages.logoAnimation),
          Text(
            'Taskati',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "It's Time to Get Organized",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
