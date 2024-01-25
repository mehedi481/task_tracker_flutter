import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';

class TaskSummery extends StatelessWidget {
  const TaskSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Summery",
          style: AppTextStyle.normalBody.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(10.h),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColor.completeColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: AppTextStyle.largeTitle.copyWith(
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColor.inCompleteColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: AppTextStyle.largeTitle.copyWith(
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      'In Progress',
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
