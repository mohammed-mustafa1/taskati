import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_list_builder.dart';
import 'package:taskati/features/home/widgets/today_header.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

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
            height: 100,
            deactivatedColor: Color(0xFF3A3A3A),
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              // setState(() {
              //   _selectedValue = date;
              // });
            },
          ),
          SizedBox(height: 16),
          TaskListBuilder()
        ],
      ),
    );
  }
}
