import 'package:flutter/material.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/widgets/main_button.dart';

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
                  text: 'Upload Image From Camera',
                  onPress: onPressCamera,
                ),
                SizedBox(height: 16),
                MainButton(
                  text: 'Upload Image From Gallery',
                  onPress: onPressGallery,
                ),
              ],
            ));
      }).then(
    (value) {
      context.pop();
    },
  );
}
