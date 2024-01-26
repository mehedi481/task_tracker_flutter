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
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/utils/routes.dart';
import 'package:task_tracker_flutter/utils/utils.dart';
import 'package:task_tracker_flutter/views/auth/components/authBG.dart';

class LogInLayout extends StatefulWidget {
  const LogInLayout({super.key});

  @override
  State<LogInLayout> createState() => _LogInLayoutState();
}

class _LogInLayoutState extends State<LogInLayout> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return AuthBG(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: AppTextStyle.largeTitle.copyWith(
                  color: AppColor.primaryColor,
                ),
              ),
              Gap(42.h),
              textFieldHeader(text: "Email"),
              Gap(14.h),
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Type your email",
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
              Gap(28.h),
              textFieldHeader(text: "Password"),
              Gap(14.h),
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
              Gap(28.h),
              Consumer(builder: (context, ref, _) {
                final isLoading = ref.watch(loginControllerProvider);
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final data = _formKey.currentState!.value;
                            ref
                                .read(loginControllerProvider.notifier)
                                .login(
                                  email: data['email'],
                                  password: data['password'],
                                )
                                .then((value) {
                              if (value) {
                                context.nav.pushNamedAndRemoveUntil(
                                  Routes.core,
                                  (route) => false,
                                );
                              }
                            });
                          }
                        },
                        text: "Sign in",
                      );
              }),
              Gap(28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: AppTextStyle.normalBody),
                  Gap(4.w),
                  InkWell(
                    onTap: () {
                      context.nav.pushNamed(Routes.signUp);
                    },
                    child: Text(
                      "Sign up",
                      style: AppTextStyle.normalBody.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
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
