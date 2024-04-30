import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/label_text_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();
    AuthController authController = Get.find();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Change Password',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    LabelTextFieldWidget(
                      prefixIcon: CupertinoIcons.lock_fill,
                      label: 'Current Password',
                      hint: 'Current Password',
                      obscureText: true,
                      controller: currentPasswordController,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    LabelTextFieldWidget(
                      prefixIcon: CupertinoIcons.lock_fill,
                      label: 'New Password',
                      hint: 'New Password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    LabelTextFieldWidget(
                      prefixIcon: CupertinoIcons.lock_fill,
                      label: 'Confirm New Password',
                      hint: 'Confirm New Password',
                      obscureText: true,
                      controller: rePasswordController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
                vertical: Dimensions.paddingSizeDefault,
              ),
              child: Obx(
                () => CustomButton(
                  text: 'Save',
                  loading: authController.verifyLoading.value,
                  onTap: () => authController.changePassword(
                    currentPasswordController.text,
                    passwordController.text,
                    rePasswordController.text,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
