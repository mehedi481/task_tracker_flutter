import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/components/custom_button.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';

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
        "date": "${date.day}/${date.month}/${date.year}".toString(),
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
                        maxLines: 6,
                      ),
                      Gap(10.h),
                    ],
                  ),
                ),
              ),
              CustomButton(
                  onPressed: () {
                    if (_fomKey.currentState!.saveAndValidate()) {
                      print(_fomKey.currentState!.value);
                    }
                  },
                  text: "Create Task"),
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
