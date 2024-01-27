import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/components/custom_button.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/auth_controller/providers.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/utils.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final _fomKey = GlobalKey<FormBuilderState>();
  var currentDate = DateTime.now();

  void pickedDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      _fomKey.currentState!.patchValue({
        // "date": "${date.day}-${date.month}-${date.year}".toString(),
        "date": "${date.year}-${date.month}-${date.day}".toString(),
      });
      setState(() {
        currentDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "New Task",
          style: AppTextStyle.title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: FormBuilder(
          key: _fomKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20.h),
                      textFieldHeader(text: "Title"),
                      Gap(14.h),
                      FormBuilderTextField(
                        name: "title",
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: AppTextStyle.normalBody.copyWith(
                            color: AppColor.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(20.h),
                      textFieldHeader(text: "Date"),
                      Gap(14.h),
                      FormBuilderTextField(
                        name: "date",
                        onTap: () {
                          pickedDate();
                        },
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "DD/MM/YYYY",
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: AppTextStyle.normalBody.copyWith(
                            color: AppColor.primaryColor.withOpacity(0.5),
                          ),
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(20.h),
                      textFieldHeader(text: "Description"),
                      Gap(14.h),
                      FormBuilderTextField(
                        name: "description",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: AppTextStyle.normalBody.copyWith(
                            color: AppColor.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        maxLines: 6,
                      ),
                      Gap(10.h),
                    ],
                  ),
                ),
              ),
              Consumer(builder: (context, ref, _) {
                final isLoading = ref.watch(addTaskControllerProvider);
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: () async {
                          if (_fomKey.currentState!.saveAndValidate()) {
                            final data = _fomKey.currentState!.value;
                            await ref
                                .read(addTaskControllerProvider.notifier)
                                .addTask(
                                  title: data['title'],
                                  description: data['description'],
                                  dueDate: data['date'],
                                )
                                .then((value) {
                              if (value) {
                                ref.invalidate(allTaskControllerProvider);
                                // for refreshing filter task list
                                ref.invalidate(filterTaskControllerProvider(
                                    ref.read(selectedDateProvider)));
                                // ignore: use_build_context_synchronously
                                context.nav.pop();
                              } else {
                                Utils.showCustomSnackbar(
                                  message: "Failed to add task",
                                  isSuccess: false,
                                );
                              }
                            });
                          }
                        },
                        text: "Create Task");
              }),
              Gap(15.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldHeader({required String text}) {
    return Text(
      text,
      style: AppTextStyle.normalBody,
    );
  }
}
