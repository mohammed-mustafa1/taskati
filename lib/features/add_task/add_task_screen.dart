import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/function/dialogs.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/services/local_notification.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/generated/l10n.dart';
import 'package:timezone/timezone.dart' as tz;

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, @required this.task});
  final TaskModel? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int selectedColor = 0;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  DateTime tempDate = DateTime.now();
  DateTime tempStartTime = DateTime.now();
  DateTime tempEndTime = DateTime.now();
  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      selectedColor = widget.task!.color;
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;

      tempDate = widget.task!.date;
      tempStartTime = widget.task!.startTime;
      tempEndTime = widget.task!.endTime;

      dateController.text = intl.DateFormat.yMMMMd().format(tempDate);
      startTimeController.text = intl.DateFormat.jm().format(tempStartTime);
      endTimeController.text = intl.DateFormat.jm().format(tempEndTime);
    } else {
      dateController.text = intl.DateFormat.yMMMMd().format(tempDate);
      startTimeController.text = intl.DateFormat.jm().format(tempStartTime);
      endTimeController.text = intl.DateFormat.jm().format(tempEndTime);
    }
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryColor,
        title: Text(
          widget.task == null
              ? S.of(context).add_task
              : S.of(context).update_task,
          style: TextStyles.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(children: [
              title(),
              SizedBox(height: 16),
              description(),
              SizedBox(height: 16),
              date(),
              SizedBox(height: 16),
              Row(children: [startTime(), SizedBox(width: 16), endTime()]),
              SizedBox(height: 16),
              color(),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: MainButton(
            text: S.of(context).save_task_button,
            color: selectedColor == 0
                ? AppColors.primaryColor
                : selectedColor == 1
                    ? AppColors.red
                    : AppColors.orange,
            onPress: () async {
              String id =
                  titleController.text + DateTime.now().millisecond.toString();
              if (formKey.currentState!.validate()) {
                var scheduledStartDate = tz.TZDateTime(
                  tz.local,
                  tempDate.year,
                  tempDate.month,
                  tempDate.day,
                  tempStartTime.hour,
                  tempStartTime.minute,
                );
                var scheduledEndtDate = tz.TZDateTime(
                  tz.local,
                  tempDate.year,
                  tempDate.month,
                  tempDate.day,
                  tempEndTime.hour,
                  tempEndTime.minute,
                );
                if (scheduledStartDate.isBefore(DateTime.now())) {
                  showErrorDialog(context,
                      message: S.of(context).time_in_the_past);
                  return;
                } else if (scheduledEndtDate == scheduledStartDate ||
                    scheduledEndtDate.isBefore(scheduledStartDate)) {
                  showErrorDialog(context, message: S.of(context).time_error);
                  return;
                }
                if (widget.task != null) {
                  // update task with new data
                  LocalStorage.cachTask(
                      key: widget.task!.id,
                      value: TaskModel(
                          id: widget.task!.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: tempDate,
                          startTime: tempStartTime,
                          endTime: tempEndTime,
                          color: selectedColor,
                          isCompleted: false));
                } else {
                  // add new task
                  LocalStorage.cachTask(
                      key: id,
                      value: TaskModel(
                          id: id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: tempDate,
                          startTime: tempStartTime,
                          endTime: tempEndTime,
                          color: selectedColor,
                          isCompleted: false));
                }

                await LocalNotificationService.showScheduledNotification(
                    id: widget.task != null
                        ? widget.task!.id.hashCode
                        : id.hashCode,
                    title: titleController.text,
                    body: descriptionController.text,
                    scheduledDate: scheduledStartDate);

                await LocalNotificationService.showScheduledNotification(
                    id: widget.task != null
                        ? widget.task!.id.hashCode
                        : id.hashCode + 1,
                    title: titleController.text,
                    body: descriptionController.text,
                    scheduledDate: scheduledEndtDate);
                Navigator.pop(context);
              }
            }),
      ),
    );
  }

  Column color() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).color,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
            children: List.generate(
                3,
                (index) => GestureDetector(
                      onTap: () {
                        selectedColor = index;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: index == 0
                                ? AppColors.primaryColor
                                : index == 1
                                    ? AppColors.red
                                    : AppColors.orange,
                            child: selectedColor == index
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null),
                      ),
                    ))),
      ],
    );
  }

  Column description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).description,
          style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).description_error;
            }
            return null;
          },
          controller: descriptionController,
          decoration: InputDecoration(hintText: S.of(context).description_hint),
          maxLines: 4,
        ),
      ],
    );
  }

  Column title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).title,
          style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).title_error;
            }
            return null;
          },
          controller: titleController,
          decoration: InputDecoration(hintText: S.of(context).title_hint),
        ),
      ],
    );
  }

  Column date() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).date,
          style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          onTap: () {
            selectTaskDate();
          },
          readOnly: true,
          controller: dateController,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_month),
          ),
        ),
      ],
    );
  }

  void selectTaskDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2050))
        .then((date) {
      if (date != null) {
        dateController.text = intl.DateFormat.yMMMMd().format(date);
        tempDate = date;
      }
    });
  }

  Expanded startTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).start_time,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((time) {
                if (time != null) {
                  tempStartTime = DateTime(
                    tempDate.year,
                    tempDate.month,
                    tempDate.day,
                    time.hour,
                    time.minute,
                  );
                  startTimeController.text =
                      intl.DateFormat.jm().format(tempStartTime);
                }
              });
            },
            controller: startTimeController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.watch_later_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Expanded endTime() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).end_time,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            readOnly: true,
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((time) {
                if (time != null) {
                  tempEndTime = DateTime(
                    tempDate.year,
                    tempDate.month,
                    tempDate.day,
                    time.hour,
                    time.minute,
                  );
                  endTimeController.text =
                      intl.DateFormat.jm().format(tempEndTime);
                }
              });
            },
            controller: endTimeController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.watch_later_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
