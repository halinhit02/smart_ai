import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/widgets/custom_dropdown.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/message_field_widget.dart';

class CreateChatScreen extends StatelessWidget {
  const CreateChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppConstants.appName,
        actions: [
          CustomDropdownButton<String>(
            items: AppConfig.chatModels,
            values: AppConfig.chatModels,
            hint: 'Model',
            buttonWidth: 120,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge * 2,
                    ),
                    CustomImage(
                      path: Images.intelligence,
                      width: 72,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    Text(
                      'Capabilities',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                          ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: AppConstants.capabilities.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSizeDefault,
                          ),
                          color: Colors.grey.shade100,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall - 3,
                          horizontal: Dimensions.paddingSizeLarge,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                          vertical: Dimensions.paddingSizeLarge,
                        ),
                        child: Text(
                          AppConstants.capabilities[index],
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Text(
                      'There are just a few examples of what I can do',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
                vertical: Dimensions.paddingSizeExtraSmall,
              ),
              child: MessageFieldWidget(
                onTap: () => Get.toNamed(AppRoutes.chatRoute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
