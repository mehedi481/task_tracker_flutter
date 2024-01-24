import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker_flutter/components/custom_button.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/views/auth/components/authBG.dart';

class SignUpLayout extends StatefulWidget {
  const SignUpLayout({super.key});

  @override
  State<SignUpLayout> createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<SignUpLayout> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return AuthBG(
      isBackButton: true,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: AppTextStyle.largeTitle.copyWith(
                  color: AppColor.primaryColor,
                ),
              ),
              Gap(25.h),
              textFieldHeader(text: "Name"),
              Gap(12.h),
              FormBuilderTextField(
                name: "name",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Type your Name",
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
              textFieldHeader(text: "Email"),
              Gap(12.h),
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Type your Email",
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: AppTextStyle.normalBody.copyWith(
                    color: AppColor.primaryColor.withOpacity(0.5),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              Gap(20.h),
              textFieldHeader(text: "Password"),
              Gap(12.h),
              FormBuilderTextField(
                name: "password",
                decoration: InputDecoration(
                  hintText: "Type your Password",
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
              textFieldHeader(text: "ReType Password"),
              Gap(12.h),
              FormBuilderTextField(
                name: "retypePassword",
                decoration: InputDecoration(
                  hintText: "ReType your Pssword",
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
              Gap(28.h),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    print(_formKey.currentState!.value);
                  }
                },
                text: "Sign Up",
              ),
              Gap(28.h),
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
