import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            context.nav.pushNamed(Routes.profileDetails);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://via.placeholder.com/60x60",
                            ),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF8C88CD),
                            ),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ),
                      Gap(8.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: AppTextStyle.largeTitle.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            'john.doe@gmail.com',
                            style: AppTextStyle.normalBody,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
