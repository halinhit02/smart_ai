import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();
    AuthController authController = Get.find();

    return Scaffold(
      appBar: const CustomAppBar(),
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
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      'Create new password 🔒',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      'Create your new password. If you forget it, then you have to do forgot password.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
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
                  text: 'Save New Password',
                  loading: authController.verifyLoading.value,
                  onTap: () => authController.createNewPassword(
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
