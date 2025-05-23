import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

enum DialogType { success, error, warning }

showErrorDialog(context,
    {required String message, DialogType type = DialogType.error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == DialogType.error
          ? AppColors.red
          : type == DialogType.success
              ? AppColors.orange
              : AppColors.primaryColor,
    ),
  );
}
