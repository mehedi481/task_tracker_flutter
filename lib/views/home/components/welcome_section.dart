import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_flutter/config/app_text.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello!',
          style: AppTextStyle.largeTitle.copyWith(
            fontSize: 24.sp,
          ),
        ),
        Text(
          "What's your plan for today ?",
          style: AppTextStyle.normalBody,
        ),
      ],
    );
  }
}
