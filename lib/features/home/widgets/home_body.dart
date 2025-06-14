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
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
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
            locale: intl.Intl.getCurrentLocale(),
            directionality: intl.Intl.getCurrentLocale() == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            monthTextStyle: TextStyles.body,
            dateTextStyle: TextStyles.body,
            dayTextStyle: TextStyles.body,
            width: MediaQuery.sizeOf(context).width * .2,
            height: MediaQuery.sizeOf(context).height * 0.14,
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          SizedBox(height: 16),
          TaskListBuilder(
            date: selectedDate!,
          )
        ],
      ),
    );
  }
}
