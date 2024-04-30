import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/auth/widgets/not_account_widget.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomImage(
                      path: MyIcons.appIcon,
                      size: 96,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      "Let's dive in into your account!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                    ),
                    // CustomButton(
                    //   leadingPadding: const EdgeInsets.symmetric(
                    //     horizontal: Dimensions.paddingSizeLarge,
                    //   ),
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   leading: const CustomImage(
                    //     path: MyIcons.google,
                    //   ),
                    //   borderSide: BorderSide(
                    //     width: 1,
                    //     color: Colors.grey.shade300,
                    //   ),
                    //   color: Colors.transparent,
                    //   textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //   text: 'Continue with Google',
                    //   onTap: () {},
                    // ),
                    // const SizedBox(
                    //   height: Dimensions.paddingSizeDefault,
                    // ),
                    // CustomButton(
                    //   leadingPadding: const EdgeInsets.symmetric(
                    //     horizontal: Dimensions.paddingSizeLarge,
                    //   ),
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   leading: const CustomImage(
                    //     path: MyIcons.apple,
                    //   ),
                    //   borderSide: BorderSide(
                    //     width: 1,
                    //     color: Colors.grey.shade300,
                    //   ),
                    //   color: Colors.transparent,
                    //   textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //   text: 'Continue with Apple',
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  CustomButton(
                    text: 'Login',
                    color: Theme.of(context).colorScheme.primary,
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    onTap: () => Get.toNamed(AppRoutes.signInRoute),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  const NotAccountWidget(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
