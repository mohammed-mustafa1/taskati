import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter Task - 1',
                        style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '02:25AM-02:40AM',
                            style:
                                TextStyles.small.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'I will do this task',
                        style: TextStyles.body.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: VerticalDivider(color: AppColors.grey),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Todo',
                    style: TextStyles.small.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
