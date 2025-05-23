import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({
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
                  intl.DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Today',
                  style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        MainButton(width: 120, text: 'Add Task', onPress: () {})
      ],
    );
  }
}
