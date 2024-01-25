import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/views/home/components/task_section.dart';
import 'package:task_tracker_flutter/views/home/components/task_summery.dart';
import 'package:task_tracker_flutter/views/home/components/welcome_section.dart';

class HomeLayout extends ConsumerWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              const WelcomeSection(),
              Gap(22.h),
              const TaskSummery(),
              Gap(25.h),
              const TaskSection(),
            ],
          ),
        ),
      ),
    );
  }
}
