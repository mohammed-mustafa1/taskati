import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';
import 'package:taskati/generated/l10n.dart';

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
                  S.of(context).today,
                  style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        MainButton(
            width: MediaQuery.sizeOf(context).width * 0.32,
            text: S.of(context).add_task,
            onPress: () {
              context.push(const AddTaskScreen(task: null));
            }),
      ],
    );
  }
}
