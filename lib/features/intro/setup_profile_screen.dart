import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/function/dialogs.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/upload_image_bottom_sheet.dart';
import 'package:taskati/features/home/page/home_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key, required this.isFirstTime});
  final bool isFirstTime;
  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  String? imagePath;
  bool editingName = false;
  bool isDarkMode = false;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    imagePath = LocalStorage.getUserData(key: LocalStorage.image);
    nameController.text =
        LocalStorage.getUserData(key: LocalStorage.name) ?? '';
    isDarkMode = LocalStorage.getUserData(key: LocalStorage.theme) ==
        Brightness.dark.name;
    editingName = widget.isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                  LocalStorage.cachUserData(
                    key: LocalStorage.theme,
                    value: isDarkMode == true
                        ? Brightness.dark.name
                        : Brightness.light.name,
                  );
                });
              },
              icon: Icon(
                isDarkMode == true
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 32,
              )),
          TextButton(
            onPressed: () {
              if (imagePath != null && nameController.text.isNotEmpty) {
                LocalStorage.cachUserData(
                    key: LocalStorage.image, value: imagePath!);
                LocalStorage.cachUserData(
                    key: LocalStorage.name, value: nameController.text);
                context.pushReplacement(const HomeScreen());
              }
              if (imagePath == null) {
                showErrorDialog(context, message: 'Please select an image');
              }
              if (nameController.text.isEmpty) {
                showErrorDialog(context, message: 'Please enter your name');
              }
            },
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
                showUploadBottomSheet(
                  context,
                  onPressCamera: () {
                    uploadImage(isCamera: true);
                  },
                  onPressGallery: () {
                    uploadImage(isCamera: false);
                  },
                );
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
            Visibility(
              visible: !editingName,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalStorage.getUserData(key: LocalStorage.name) ?? '',
                    style: TextStyles.title,
                  ),
                  GestureDetector(
                    onTap: () {
                      editingName = true;
                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 24,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22,
                        child: Icon(
                          Icons.edit,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: editingName,
              child: CustomTextField(
                  controller: nameController, hintText: 'Enter Your Name'),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage({required bool isCamera}) async {
    ImagePicker imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
      context.pop();
    }
  }
}
