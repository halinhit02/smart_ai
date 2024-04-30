import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/message_field_widget.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../utils/constants/app_config.dart';
import '../../widgets/custom_dropdown.dart';

class CreateAssistantScreen extends StatelessWidget {
  const CreateAssistantScreen({
    super.key,
    this.title,
    this.description,
    this.index,
  });

  final String? title;
  final String? description;
  final String? index;

  @override
  Widget build(BuildContext context) {
    var somethingLikes = AppConstants.somethingLikes[index] ?? [];
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimensions.paddingSizeLarge,
              left: Dimensions.paddingSizeSmall,
            ),
            child: CustomDropdownButton<String>(
              items: AppConfig.chatModels,
              values: AppConfig.chatModels,
              hint: 'Model',
              buttonWidth: 120,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Type something like:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: somethingLikes.length,
                      itemBuilder: (itemCtx, index) => Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSizeLarge,
                                )),
                            margin: const EdgeInsets.only(
                                bottom: Dimensions.radiusSizeDefault),
                            padding: const EdgeInsets.all(
                              Dimensions.paddingSizeLarge,
                            ),
                            child: Text(
                              somethingLikes[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                            ),
                          ))
                ],
              )),
              const SizedBox(
                height: Dimensions.paddingSizeLarge,
              ),
              MessageFieldWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.chatRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
