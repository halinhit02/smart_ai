import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';

import '../../../utils/constants/dimensions.dart';
import '../../../utils/constants/images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image.dart';

class StartChatScreen extends StatelessWidget {
  const StartChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppConstants.appName,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
            vertical: Dimensions.paddingSizeExtraLarge,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: Dimensions.radiusSizeExtraLarge,
              ),
              CustomImage(
                path: Images.intelligence,
                size: 120,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: Dimensions.paddingSizeLarge * 2,
              ),
              RichText(
                  text: TextSpan(
                text: 'Welcome to',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: 'SmartAI 👋',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: Dimensions.paddingSizeLarge * 2,
              ),
              Text(
                'Start chatting with SmartAI now.\n You can ask me anything.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge * 2,
              ),
              CustomButton(
                onTap: () => Get.toNamed(AppRoutes.createChatRoute),
                text: 'Start Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
