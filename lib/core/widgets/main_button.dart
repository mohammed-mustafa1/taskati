import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPress,
    this.height,
    this.width,
  });
  final String text;
  final Function()? onPress;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
