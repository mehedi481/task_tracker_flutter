import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/utils.dart';

// ignore: must_be_immutable
class UpdateTask extends StatefulWidget {
  UpdateTask({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  }) : super(key: key);
  final String id;
  final String title;
  final String description;
  bool isComplete;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditingTitle = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 100.h,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _isEditingTitle
                        ? TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Enter title',
                              isDense: true,
                            ),
                            onSubmitted: (value) {
                              setState(() {
                                _isEditingTitle = false;
                              });
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isEditingTitle = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _titleController.text.toString(),
                                        style: AppTextStyle.title,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          _isEditingTitle = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    size: 16,
                                  ),
                                  Gap(3.w),
                                  Text(
                                    "20 Jan 2021",
                                    style: AppTextStyle.smallBody,
                                  ),
                                  Gap(5.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.isComplete
                                          ? const Color(0xffEFFFEF)
                                          : const Color(0xffFFFAEC),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                    ),
                                    child: widget.isComplete
                                        ? Text(
                                            "Complete",
                                            style:
                                                AppTextStyle.smallBody.copyWith(
                                              fontSize: 8.sp,
                                              color: AppColor.completeColor,
                                            ),
                                          )
                                        : Text(
                                            "Incomplete",
                                            style:
                                                AppTextStyle.smallBody.copyWith(
                                              fontSize: 8.sp,
                                              color: AppColor.inCompleteColor,
                                            ),
                                          ),
                                  )
                                ],
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
            Consumer(builder: (context, ref, _) {
              final isLoading = ref.watch(updateTaskControllerProvider(
                widget.id,
              ));
              return InkWell(
                onTap: () {
                  ref
                      .read(updateTaskControllerProvider(widget.id).notifier)
                      .updateTask(isComplete: !widget.isComplete)
                      .then((value) {
                    if (value) {
                      ref.invalidate(allTaskControllerProvider);
                      setState(() {
                        widget.isComplete = !widget.isComplete;
                      });
                    }
                  });
                },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Container(
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
              );
            })
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 1.sw,
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _descriptionController,
                style: AppTextStyle.normalBody,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  contentPadding: EdgeInsets.all(10.r),
                ),
                maxLines: 10,
                onSubmitted: (value) {
                  print(value);
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Consumer(builder: (context, ref, _) {
                final isLoading =
                    ref.watch(deleteTaskControllerProvider(widget.id));
                return isLoading
                    ? Container(
                        width: 30.w,
                        height: 30.h,
                        margin: const EdgeInsets.all(10),
                        child: const CircularProgressIndicator())
                    : Container(
                        width: 122.w,
                        height: 32.h,
                        margin: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF808080)),
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(deleteTaskControllerProvider(widget.id)
                                    .notifier)
                                .deleteTask()
                                .then((value) {
                              if (value) {
                                Utils.showCustomSnackbar(
                                    message: "Task successfully delete",
                                    isSuccess: true);
                                ref.invalidate(allTaskControllerProvider);
                                context.nav.pop();
                              }
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Delete Task',
                                style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 14.sp,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.delete_outline,
                                color: Color(0xFF808080),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
