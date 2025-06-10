import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/function/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_notification.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({
    super.key,
    required this.date,
  });
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalStorage.taskBox.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks = box.values.toList();
          tasks = tasks
              .where((task) =>
                  task.date.month == date.month && task.date.day == date.day)
              .toList();

          return tasks.isEmpty
              ? Center(child: Lottie.asset('assets/images/empty.json'))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        background: completeTaskUi(),
                        secondaryBackground: deleteTaskUi(),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            box.delete(tasks[index].id);
                            LocalNotificationService.cancelNotifications(
                                id: tasks[index].id.hashCode);
                            LocalNotificationService.cancelNotifications(
                                id: tasks[index].id.hashCode + 1);
                          } else {
                            box.put(tasks[index].id,
                                tasks[index].copyWith(isCompleted: true));

                            LocalNotificationService.cancelNotifications(
                                id: tasks[index].id.hashCode);
                            LocalNotificationService.cancelNotifications(
                                id: tasks[index].id.hashCode + 1);
                          }
                        },
                        key: UniqueKey(),
                        child: InkWell(
                            onTap: () {
                              context.push(AddTaskScreen(task: tasks[index]));
                            },
                            child: TaskCard(task: tasks[index])));
                  },
                );
        },
      ),
    );
  }

  Container deleteTaskUi() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: AlignmentDirectional.centerEnd,
      child: const Icon(Icons.delete, color: Colors.white, size: 32),
    );
  }

  Container completeTaskUi() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: AlignmentDirectional.centerStart,
      child: const Icon(Icons.done, color: Colors.white, size: 32),
    );
  }
}
