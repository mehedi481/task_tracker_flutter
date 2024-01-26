import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/config/app_images.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';
import 'package:task_tracker_flutter/views/splash/components/splashBG.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({super.key});

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
  @override
  void initState() {
    super.initState();
    Box authBox = Hive.box(AppConstants.authBox);
    Future.delayed(const Duration(seconds: 3), () {
      if (authBox.get(AppConstants.authToken) != null) {
        context.nav.pushNamedAndRemoveUntil(
          Routes.core,
          (route) => false,
        );
      } else {
        context.nav.pushNamedAndRemoveUntil(
          Routes.logIn,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBG(
        child: Center(
          child: Image.asset(
            AppImage.logo,
            height: 200.h,
            width: 200.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
