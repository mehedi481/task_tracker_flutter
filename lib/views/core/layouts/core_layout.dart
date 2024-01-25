import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_images.dart';
import 'package:task_tracker_flutter/controller/misc/misc_provider.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';
import 'package:task_tracker_flutter/views/core/components/navigation_item.dart';
import 'package:task_tracker_flutter/views/home/home_view.dart';
import 'package:task_tracker_flutter/views/profile/profile_view.dart';
import 'package:task_tracker_flutter/views/task/task_view.dart';

// ignore: must_be_immutable
class CoreLayout extends ConsumerWidget {
  CoreLayout({super.key});

  List<NavigationItemModel> navigationItems = [
    NavigationItemModel(img: AppImage.home, title: 'Home'),
    NavigationItemModel(img: AppImage.box, title: 'Task'),
    NavigationItemModel(img: AppImage.user, title: 'Profile'),
  ];

  List<Widget> pages = [
    const HomeView(),
    const TaskView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(bottomTabControllerProvider);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          ref.watch(selectedIndexProvider.notifier).state = index;
        },
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 54.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            navigationItems.length,
            (index) {
              return Items(
                index: index,
                isActive: ref.watch(selectedIndexProvider) == index,
                onTap: () {
                  pageController.jumpToPage(index);
                },
                navigationItems: navigationItems,
              );
            },
          ),
        ),
      ),
      floatingActionButton: ref.watch(selectedIndexProvider) != 2
          ? FloatingActionButton.extended(
              onPressed: () {
                context.nav.pushNamed(Routes.addTask);
              },
              label: Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: AppColor.primaryColor,
            )
          : const SizedBox.shrink(),
    );
  }
}

// ignore: unused_element
class NavigationItemModel {
  String img;
  String title;
  NavigationItemModel({required this.img, required this.title});
}
