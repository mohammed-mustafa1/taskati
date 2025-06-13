import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.primaries[task.color],
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
                  task.title,
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
                      '${intl.DateFormat.jm().format(task.startTime)} - ${intl.DateFormat.jm().format(task.endTime)}',
                      style: TextStyles.small.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyles.body.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: VerticalDivider(color: Colors.white),
          ),
          task.isCompleted == true
              ? Icon(
                  task.isCompleted ? Icons.done : Icons.close,
                  color: Colors.white,
                )
              : RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'TODO',
                    style: TextStyles.small.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }
}
