import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/auth_controller/providers.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(logoutControllerProvider);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  ref
                      .read(logoutControllerProvider.notifier)
                      .logout()
                      .then((value) {
                    if (value) {
                      ref
                          .read(databaseHelperProvider)
                          .deleteUserToken()
                          .then((value) {
                        if (value != -1) {
                          ref.invalidate(selectedIndexProvider);
                          context.nav.pushNamedAndRemoveUntil(
                            Routes.logIn,
                            (route) => false,
                          );
                        }
                      });
                    }
                  });
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 1.sw,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                      ),
                      Gap(8.w),
                      Text('Log Out', style: AppTextStyle.normalBody)
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
