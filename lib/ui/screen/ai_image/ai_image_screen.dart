import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/ads_controller.dart';
import 'package:smart_ai/controller/image_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_dropdown.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/custom_text_field.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';
import 'package:smart_ai/utils/helpers/format_helpers.dart';

class AIImageScreen extends StatelessWidget {
  const AIImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var imageController = Get.find<ImageController>();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI Image',
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.historyImageRoute),
              icon: const CustomImage(
                path: MyIcons.historyInactive,
                color: Colors.black87,
              )),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomTextField(
              controller: descriptionController,
              hint: 'Type anything...',
              maxLines: 5,
              minLines: 5,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Size',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  CustomDropdownButton(
                    items: OpenAIImageSize.values
                        .map((e) => FormatHelpers.upperFirstCharacter(
                            e.name.toString()))
                        .toList(),
                    values: OpenAIImageSize.values,
                    value: imageController.imageSize.value,
                    hint: 'Image Size',
                    onChanged: (value) {
                      if (value != null) {
                        imageController.imageSize.value = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeDefault,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Style',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  CustomDropdownButton(
                    items: OpenAIImageStyle.values
                        .map((e) => FormatHelpers.upperFirstCharacter(
                            e.name.toString()))
                        .toList(),
                    value: imageController.imageStyle.value,
                    values: OpenAIImageStyle.values,
                    hint: 'Image Style',
                    onChanged: (value) {
                      if (value != null) {
                        imageController.imageStyle.value = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeDefault,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Quality',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  CustomDropdownButton(
                    items: OpenAIImageQuality.values
                        .map((e) => e.name.toString().toUpperCase())
                        .toList(),
                    value: imageController.imageQuality.value,
                    values: OpenAIImageQuality.values,
                    hint: 'Image Quality',
                    onChanged: (value) {
                      if (value != null) {
                        imageController.imageQuality.value = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            Obx(
              () => CustomButton(
                text: 'Generate',
                loading: imageController.generating.isTrue,
                onTap: () =>
                    imageController.generateImage(descriptionController.text),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
