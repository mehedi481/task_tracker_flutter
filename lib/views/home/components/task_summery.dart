import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_images.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColor.completeColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImage.summery1),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Incomplete',
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Consumer(builder: (context, ref, _) {
                      final isLoading =
                          ref.watch(getTaskByStatusControllerProvider);
                      return isLoading
                          ? SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: const CircularProgressIndicator(),
                            )
                          : Text(
                              ref
                                  .watch(getTaskByStatusControllerProvider
                                      .notifier)
                                  .inCompleteTaskCount
                                  .toString(),
                              style: AppTextStyle.largeTitle.copyWith(
                                fontSize: 24.sp,
                              ),
                            );
                    }),
                  ],
                ),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: Container(
                height: 100.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImage.summery2),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete',
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Consumer(builder: (context, ref, _) {
                      final isLoading =
                          ref.watch(getTaskByStatusControllerProvider);
                      return isLoading
                          ? SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: const CircularProgressIndicator(),
                            )
                          : Text(
                              ref
                                  .watch(getTaskByStatusControllerProvider
                                      .notifier)
                                  .completeTaskCount
                                  .toString(),
                              style: AppTextStyle.largeTitle.copyWith(
                                fontSize: 24.sp,
                              ),
                            );
                    }),
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
