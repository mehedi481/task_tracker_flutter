import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';

class WeekAndMonthViewSection extends ConsumerStatefulWidget {
  const WeekAndMonthViewSection({super.key});

  @override
  ConsumerState<WeekAndMonthViewSection> createState() =>
      _WeekAndMonthViewSectionState();
}

class _WeekAndMonthViewSectionState
    extends ConsumerState<WeekAndMonthViewSection> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = ref.read(selectedDateProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 10.h),
        _buildWeekView(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          DateFormat('MMMM yyyy').format(selectedDate),
          style: AppTextStyle.title,
        ),
        SizedBox(width: 10.w),
        IconButton(
          icon: const Icon(Icons.calendar_month_sharp),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }

  Widget _buildWeekView() {
    return SizedBox(
      height: 60.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 3.w);
        },
        itemBuilder: (BuildContext context, int index) {
          return _buildDayItem(index);
        },
      ),
    );
  }

  Widget _buildDayItem(int index) {
    DateTime currentDate = selectedDate.subtract(Duration(days: 3 - index));

    String dayName = DateFormat.E().format(currentDate);
    String dayNumber = DateFormat.d().format(currentDate);

    bool isSelected = currentDate.day == selectedDate.day;

    return GestureDetector(
      onTap: () {
        _handleDateSelection(currentDate);
      },
      child: Container(
        width: 45.w,
        decoration: BoxDecoration(
          // color:
          //     isSelected ? Colors.blue : AppColor.scaffoldBackgroundColor,
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColor.primaryColor : Colors.black,
              ),
            ),
            Gap(2.h),
            Text(
              dayNumber,
              style: TextStyle(
                fontSize: 16.sp,
                color: isSelected ? AppColor.primaryColor : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      ref.read(selectedDateProvider.notifier).state = pickedDate;

      /// refresh the task list by selected date
      ref.invalidate(filterTaskControllerProvider(pickedDate));
    }
  }

  void _handleDateSelection(DateTime currentDate) {
    setState(() {
      selectedDate = currentDate;
    });
    ref.read(selectedDateProvider.notifier).state = currentDate;

    /// refresh the task list by selected date
    ref.invalidate(filterTaskControllerProvider(currentDate));
  }
}
