import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/intro/setup_profile_screen.dart';
import 'package:taskati/generated/l10n.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${S.of(context).Hello}, ${LocalStorage.getUserData(key: LocalStorage.name)}',
                  style: TextStyles.title,
                ),
                Text(
                  S.of(context).Have_a_nice_day,
                  style: TextStyles.body,
                ),
              ]),
        ),
        GestureDetector(
          onTap: () {
            context.push(const SetupProfileScreen(
              isFirstTime: false,
            ));
          },
          child: CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(
                File(LocalStorage.getUserData(key: LocalStorage.image))),
          ),
        )
      ],
    );
  }
}
