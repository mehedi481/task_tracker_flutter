import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_images.dart';

// ignore: must_be_immutable
class AuthBG extends StatelessWidget {
  AuthBG({super.key, required this.child, this.isBackButton = false});

  Widget child;
  bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 360.w,
                height: 180.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28.r),
                      bottomRight: Radius.circular(28.r),
                    ),
                  ),
                ),
                child: Image.asset(AppImage.headerBG, fit: BoxFit.fill),
              ),
              Positioned(
                top: 40.h,
                left: 10.w,
                child: isBackButton
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 44.r,
                          height: 44.r,
                          padding: const EdgeInsets.all(11),
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Image.asset(AppImage.backIcon),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Center(
                child: Image.asset(
                  AppImage.logo,
                  height: 80.h,
                  width: 80.w,
                ),
              )
            ],
          ),
          Gap(28.h),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: child,
          )),
        ],
      ),
    );
  }
}
