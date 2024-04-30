import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/auth/widgets/not_account_widget.dart';
import 'package:smart_ai/ui/screen/sign_in/widgets/remember_forgot_widget.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/label_text_field_widget.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                            'Welcome back 👋',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            'Please enter your phone number & password to sign in.',
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                      ),
                      child: RememberForgotWidget(),
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
                    const NotAccountWidget(
                      offNamed: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeLarge,
              ),
              child: CustomButton(
                text: 'Log in',
                onTap: () => Get.offAllNamed(AppRoutes.homeRoute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
