import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/generated/l10n.dart';

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
  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      selectedColor = widget.task!.color;
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      dateController.text = widget.task!.date;
      startTimeController.text = widget.task!.startTime;
      endTimeController.text = widget.task!.endTime;
    } else {
      dateController.text = intl.DateFormat.yMMMMd().format(DateTime.now());
      startTimeController.text =
          intl.DateFormat('hh:mm a').format(DateTime.now());
      endTimeController.text =
          intl.DateFormat('hh:mm a').format(DateTime.now());
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
              color()
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
            onPress: () {
              String id =
                  titleController.text + DateTime.now().millisecond.toString();
              if (formKey.currentState!.validate()) {
                if (widget.task != null) {
                  // update task with new data
                  LocalStorage.cachTask(
                      key: widget.task!.id,
                      value: TaskModel(
                          id: widget.task!.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: dateController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
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
                          date: dateController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          color: selectedColor,
                          isCompleted: false));
                }
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
                  startTimeController.text = time.format(context);
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
                  endTimeController.text = time.format(context);
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
