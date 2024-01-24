import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  AppTextStyle._();

  static final largeTitle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );
  static final title = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static final normalBody = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final smallBody = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
