import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/components/task_card.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tasks for the Day",
            style: AppTextStyle.normalBody
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          Gap(10.h),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              final isLoading = ref.watch(allTaskControllerProvider);
              final taskList =
                  ref.watch(allTaskControllerProvider.notifier).taskList;
              return isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : taskList.isEmpty
                      ? const Center(
                          child: Text("No Task Found. Please add Task"),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            // format date dd MM YYYY
                            final date = DateFormat.yMMMMd()
                                .format(taskList[index].dueDate!);
                            return TaskCard(
                              id: taskList[index].id,
                              title: taskList[index].title ?? '',
                              date: date,
                              isComplete: taskList[index].completed ?? false,
                              description: taskList[index].description ?? "",
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(10.h);
                          },
                        );
            }),
          ),
        ],
      ),
    );
  }
}
