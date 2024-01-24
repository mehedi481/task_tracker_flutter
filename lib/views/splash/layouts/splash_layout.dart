import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_flutter/config/app_images.dart';
import 'package:task_tracker_flutter/routes.dart';
import 'package:task_tracker_flutter/views/splash/layouts/components/splashBG.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({super.key});

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.logIn);
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
