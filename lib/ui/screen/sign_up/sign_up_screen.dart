import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/screen/sign_up/widgets/ready_account_widget.dart';
import 'package:smart_ai/ui/widgets/custom_check_box.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';

import '../../../utils/constants/dimensions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            'Create an account 👩‍💻',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            'We will send a verification link to the phone number you entered.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraLarge,
                          ),
                          LabelTextFieldWidget(
                            prefixIcon: CupertinoIcons.phone_fill,
                            label: 'Phone number',
                            hint: 'Phone number',
                            controller: phoneController,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                          LabelTextFieldWidget(
                            prefixIcon: CupertinoIcons.lock_fill,
                            label: 'Password',
                            hint: 'Password',
                            obscureText: true,
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                          LabelTextFieldWidget(
                            prefixIcon: CupertinoIcons.lock_fill,
                            label: 'Confirm password',
                            hint: 'Confirm password',
                            obscureText: true,
                            controller: rePasswordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => CustomCheckBox(
                              value: authController.agreePolicy.value,
                              onChanged: (value) {
                                authController.agreePolicy.value =
                                    value ?? true;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall,
                          ),
                          Expanded(
                            child: RichText(
                                text: TextSpan(
                              text: 'I agree to SmartAI',
                              children: [
                                TextSpan(
                                  text: ' Terms of Use',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                    text: 'Privacy Policy.',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall,
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    const ReadyAccountWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeLarge,
              ),
              child: Obx(
                () => CustomButton(
                  text: 'Sign up',
                  loading: authController.verifyLoading.value,
                  onTap: () => authController.signUp(
                    phoneController.text.trim(),
                    passwordController.text.trim(),
                    rePasswordController.text.trim(),
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
