import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/cubit/profile_cubit.dart';
import 'package:taskati/core/function/dialogs.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/upload_image_bottom_sheet.dart';
import 'package:taskati/features/home/page/home_screen.dart';
import 'package:taskati/generated/l10n.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key, required this.isFirstTime});
  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
  final bool isFirstTime;
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  String? imagePath;
  String theme = 'system';
  TextEditingController nameController = TextEditingController();
  late String language;
  bool isNotificationEnabled = false;
  @override
  void initState() {
    super.initState();

    imagePath = LocalStorage.getUserData(key: LocalStorage.image);
    nameController.text =
        LocalStorage.getUserData(key: LocalStorage.name) ?? '';
    theme = LocalStorage.getUserData(key: LocalStorage.theme) ?? 'system';

    language = LocalStorage.getUserData(key: LocalStorage.language) ?? 'en';
    isNotificationEnabled =
        LocalStorage.getUserData(key: LocalStorage.isNotificationsEnabled) ??
            true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<ProfileCubit>(),
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).user_profile_title,
                  style: TextStyles.title),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
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
                            radius: 64,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
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
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Divider(thickness: 1, color: AppColors.grey),
                    SizedBox(height: 24),
                    CustomTextField(
                      controller: nameController,
                      hintText: S.of(context).name_hint,
                    ),
                    Divider(height: 32, thickness: 1, color: AppColors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).language,
                          style: TextStyles.body
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        ToggleButtons(
                            onPressed: (index) {
                              index == 0 ? language = 'en' : language = 'ar';
                              cubit.changeLanguage(language);
                            },
                            constraints: const BoxConstraints(
                                minHeight: 35, minWidth: 60),
                            borderRadius: BorderRadius.circular(16),
                            borderColor: AppColors.primaryColor,
                            selectedBorderColor: AppColors.primaryColor,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.primaryColor
                                    : Colors.white,
                            selectedColor: Colors.white,
                            fillColor: AppColors.primaryColor,
                            textStyle: TextStyles.body.copyWith(fontSize: 14),
                            isSelected: [
                              language == 'en',
                              language == 'ar',
                            ],
                            children: [
                              Text('EN'),
                              Text('AR'),
                            ]),
                      ],
                    ),
                    Divider(height: 32, thickness: 1, color: AppColors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).theme,
                          style: TextStyles.body
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        ToggleButtons(
                            onPressed: (index) {
                              index == 0
                                  ? theme = 'system'
                                  : index == 1
                                      ? theme = 'light'
                                      : theme = 'dark';
                              cubit.changeTheme(theme);
                            },
                            constraints: const BoxConstraints(
                                minHeight: 35, minWidth: 60),
                            borderRadius: BorderRadius.circular(16),
                            borderColor: AppColors.primaryColor,
                            selectedBorderColor: AppColors.primaryColor,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.primaryColor
                                    : Colors.white,
                            selectedColor: Colors.white,
                            fillColor: AppColors.primaryColor,
                            textStyle: TextStyles.body.copyWith(fontSize: 14),
                            isSelected: [
                              theme == 'system',
                              theme == 'light',
                              theme == 'dark',
                            ],
                            children: [
                              Text(S.of(context).system_mode),
                              Text(S.of(context).light_mode),
                              Text(S.of(context).dark_mode),
                            ]),
                      ],
                    ),
                    Divider(height: 32, thickness: 1, color: AppColors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).notifications,
                          style: TextStyles.body
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Switch(
                            activeTrackColor: AppColors.primaryColor,
                            value: isNotificationEnabled,
                            onChanged: (value) async {
                              setState(() {
                                isNotificationEnabled = value;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: MainButton(
                  text: S.of(context).save_task_button,
                  onPress: () async {
                    if (imagePath == null) {
                      showErrorDialog(context,
                          message: S.of(context).image_error);
                      return;
                    }
                    if (nameController.text.isEmpty) {
                      showErrorDialog(context,
                          message: S.of(context).name_error);
                      return;
                    }
                    cubit.changeNameAndImage(nameController.text, imagePath!);
                    showErrorDialog(context,
                        message: S.of(context).setting_success_message,
                        type: DialogType.success);
                    Future.delayed(Duration(seconds: 3), () {
                      context.pushReplacement(const HomeScreen());
                    });
                  }),
            ));
      },
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
