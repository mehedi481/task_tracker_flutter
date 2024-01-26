import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/views/profile/components/logout_button.dart';
import 'package:task_tracker_flutter/views/profile/components/profile_tab.dart';

class ProfileLayout extends ConsumerWidget {
  const ProfileLayout({super.key});

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
              Text(
                'Profile',
                style: AppTextStyle.largeTitle.copyWith(fontSize: 24.sp),
              ),
              Gap(20.h),
              const ProfileTab(),
              Gap(10.h),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
