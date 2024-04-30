import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/image_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class ResultImageScreen extends StatelessWidget {
  const ResultImageScreen({super.key, this.imageId});

  final String? imageId;

  @override
  Widget build(BuildContext context) {
    var imageController = Get.find<ImageController>();
    var imageModel = imageController.imageList
        .firstWhereOrNull((e) => e.id.toString() == imageId);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Result Image',
      ),
      body: SafeArea(
        child: imageController.imageModel != null || imageModel != null
            ? Column(
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSizeDefault,
                            ),
                            child: CustomImage(
                              width: Get.width,
                              path:
                                  imageController.imageModel?.data.first.url ??
                                      imageModel?.imagePath ??
                                      '',
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                          Text(
                            'Image Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            imageController
                                    .imageModel?.data.first.revisedPrompt ??
                                imageModel?.content ??
                                imageController.imageDescription ??
                                '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge,
                      vertical: Dimensions.paddingSizeSmall,
                    ),
                    child: Obx(
                      () => CustomButton(
                        text: 'Save',
                        loading: imageController.saving.isTrue,
                        onTap: () => imageController.saveImage(
                            imageController.imageModel?.data.first.url ??
                                imageModel?.imagePath ??
                                ''),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('Have no image.'),
              ),
      ),
    );
  }
}
