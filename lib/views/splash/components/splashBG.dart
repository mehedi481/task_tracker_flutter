import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_flutter/config/app_images.dart';

// ignore: must_be_immutable
class SplashBG extends StatelessWidget {
  SplashBG({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Image.asset(
            AppImage.background,
            fit: BoxFit.fill,
          ),
        ),
        child
      ]),
    );
  }
}
