import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_flutter/components/task_card.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';
import 'package:task_tracker_flutter/views/task/components/week_and_month_section.dart';

class TaskLayout extends ConsumerStatefulWidget {
  const TaskLayout({super.key});

  @override
  ConsumerState<TaskLayout> createState() => _TaskLayoutState();
}

class _TaskLayoutState extends ConsumerState<TaskLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(filterTaskControllerProvider(ref.watch(selectedDateProvider))
              .notifier)
          .getAllTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(35.h),
            Text('Tasks', style: AppTextStyle.title),
            // calendar section
            const WeekAndMonthViewSection(),
            // task render section
            Expanded(
              child: Consumer(builder: (context, ref, _) {
                final isLoading =
                    ref.watch(filterTaskControllerProvider(selectedDate));
                final taskList = ref
                    .watch(filterTaskControllerProvider(selectedDate).notifier)
                    .filteredTaskList;
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : taskList.isEmpty
                        ? const Center(
                            child: Text("No Task found for this day."),
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
      ),
    );
  }
}
