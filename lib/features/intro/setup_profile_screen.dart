import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/upload_image_bottom_sheet.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        actions: [
          TextButton(
            onPressed: () {},
            style:
                TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
            child: Text('Done'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showUploadBottomSheet(context,
                    onPressCamera: () {}, onPressGallery: () {});
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.grey,
                    child: imagePath == null
                        ? SvgPicture.asset(
                            AppImages.person,
                            height: 200,
                            width: 200,
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                Image.file(File(imagePath!)).image),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Divider(
                thickness: 1, color: AppColors.grey, endIndent: 20, indent: 20),
            SizedBox(height: 24),
            CustomTextField(hintText: 'Enter Your Name'),
          ],
        ),
      ),
    );
  }
}
