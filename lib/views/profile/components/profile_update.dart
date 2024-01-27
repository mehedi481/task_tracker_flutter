import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_tracker_flutter/components/custom_button.dart';
import 'package:task_tracker_flutter/config/app_color.dart';
import 'package:task_tracker_flutter/config/app_images.dart';
import 'package:task_tracker_flutter/config/app_text.dart';
import 'package:task_tracker_flutter/controllers/profile_controller.dart/providers.dart';
import 'package:task_tracker_flutter/extensions/context_less_nav.dart';
import 'package:task_tracker_flutter/models/user_model.dart';

// ignore: must_be_immutable
class ProfileUpdate extends StatefulWidget {
  ProfileUpdate({super.key, this.userData});
  UserModel? userData;

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final _formKey = GlobalKey<FormBuilderState>();
  XFile? image;
  void pickImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        image = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  'Profile',
                  style: AppTextStyle.title,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: 1.sw,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    image: const DecorationImage(
                      image: AssetImage(AppImage.background),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {
                      'name': widget.userData!.name,
                      'email': widget.userData!.email,
                      'age': widget.userData!.age.toString(),
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 55.r,
                                  backgroundImage: image != null
                                      ? FileImage(File(image!.path))
                                      : null,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.1),
                                    child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20.h),
                        textFieldHeader(text: "Name"),
                        Gap(14.h),
                        FormBuilderTextField(
                          name: "name",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Type your name",
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
                        Gap(20.h),
                        textFieldHeader(text: "Age"),
                        Gap(14.h),
                        FormBuilderTextField(
                          name: "age",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Type your age",
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: AppTextStyle.normalBody.copyWith(
                              color: AppColor.primaryColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        Consumer(builder: (context, ref, _) {
                          final isLoading =
                              ref.watch(profileUpdateControllerProvider);
                          final isImageLoading =
                              ref.watch(profileImageUpdateControllerProvider);
                          return isLoading || isImageLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  onPressed: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      final data = _formKey.currentState!.value;
                                      ref
                                          .read(
                                            profileUpdateControllerProvider
                                                .notifier,
                                          )
                                          .updateProfileData(data: data)
                                          .then((value) {
                                        if (value) {
                                          ref.invalidate(
                                            profileDataControllerProvider,
                                          );
                                          context.nav.pop();
                                        }
                                      });
                                    }
                                  },
                                  text: "Update",
                                );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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
