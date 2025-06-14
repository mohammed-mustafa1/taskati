import 'package:flutter/material.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/generated/l10n.dart';

showUploadBottomSheet(
  BuildContext context, {
  required VoidCallback onPressCamera,
  required VoidCallback onPressGallery,
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainButton(
                  text: S.of(context).select_image_camera,
                  onPress: onPressCamera,
                ),
                SizedBox(height: 16),
                MainButton(
                  text: S.of(context).select_image_gallery,
                  onPress: onPressGallery,
                ),
              ],
            ));
      });
}
