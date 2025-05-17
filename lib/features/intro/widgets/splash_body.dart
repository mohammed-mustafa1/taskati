import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/utils/colors.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

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
