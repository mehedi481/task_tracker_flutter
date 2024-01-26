import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isComplete,
  });
  String id;
  bool isComplete;
  String title;
  String date;
  String description;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.nav.pushNamed(Routes.updateTask, arguments: {
          "title": "Update",
          "description": "Lorem ipsum dolor sit amet",
          "isComplete": widget.isComplete,
        });
      },
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
              color: widget.isComplete ? Colors.green : Colors.transparent),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: AppTextStyle.title),
                  Gap(5.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                      ),
                      Gap(3.w),
                      Text(
                        widget.date,
                        style: AppTextStyle.smallBody,
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: widget.isComplete
                              ? const Color(0xffEFFFEF)
                              : const Color(0xffFFFAEC),
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                        child: widget.isComplete
                            ? Text(
                                "Complete",
                                style: AppTextStyle.smallBody.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColor.completeColor,
                                ),
                              )
                            : Text(
                                "Incomplete",
                                style: AppTextStyle.smallBody.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColor.inCompleteColor,
                                ),
                              ),
                      )
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   widget.isComplete = !widget.isComplete;
                  // });
                  print('id: ${widget.id}');
                },
                child: Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.isComplete
                            ? Colors.transparent
                            : Colors.black),
                    color: widget.isComplete
                        ? Colors.green
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.isComplete
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        )
                      : null,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.normalBody,
          ),
        ]),
      ),
    );
  }
}
