import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/text_styles.dart';

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
                  'Hello, ${LocalStorage.getData(key: LocalStorage.name)}',
                  style: TextStyles.title,
                ),
                Text(
                  'Have a nice day',
                  style: TextStyles.body,
                ),
              ]),
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage:
              FileImage(File(LocalStorage.getData(key: LocalStorage.image))),
        )
      ],
    );
  }
}
