import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/components/task_card.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tasks for the Day",
            style: AppTextStyle.normalBody
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          Gap(10.h),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return TaskCard();
              },
              separatorBuilder: (context, index) {
                return Gap(10.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}
