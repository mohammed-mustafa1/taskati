import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_list_builder.dart';
import 'package:taskati/features/home/widgets/today_header.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String selectedDate = '';

  @override
  void initState() {
    super.initState();

    selectedDate = intl.DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          HomeHeader(),
          SizedBox(height: 16),
          TodayHeader(),
          SizedBox(height: 16),
          DatePicker(
            monthTextStyle: TextStyles.body,
            dateTextStyle: TextStyles.body,
            dayTextStyle: TextStyles.body,
            height: 100,
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              setState(() {
                selectedDate = intl.DateFormat.yMMMMd().format(date);
              });
            },
          ),
          SizedBox(height: 16),
          TaskListBuilder(
            date: selectedDate,
          )
        ],
      ),
    );
  }
}
