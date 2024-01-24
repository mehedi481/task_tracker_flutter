import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/views/core/layouts/core_layout.dart';

// ignore: must_be_immutable
class Items extends StatelessWidget {
  Items({
    super.key,
    required this.navigationItems,
    required this.index,
    required this.onTap,
    required this.isActive,
  });
  final int index;
  Function onTap;
  final bool isActive;
  final List<NavigationItemModel> navigationItems;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: 60.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  navigationItems[index].img,
                  width: 26.w,
                  height: 26.h,
                  color: isActive ? AppColor.primaryColor : Colors.grey,
                ),
                Gap(2.h),
                Text(
                  navigationItems[index].title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? AppColor.primaryColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: isActive
                ? Container(
                    width: 40.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      // border radius bottom right and left
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
