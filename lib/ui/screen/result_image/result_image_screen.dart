import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
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
                          GestureDetector(
                            onTap: () {
                              final imageProvider = CachedNetworkImageProvider(
                                  imageModel?.imagePath ??
                                      imageController
                                          .imageModel?.data.first.url ??
                                      '');
                              showImageViewer(
                                context,
                                imageProvider,
                                swipeDismissible: true,
                                doubleTapZoomable: true,
                                useSafeArea: true,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusSizeDefault,
                              ),
                              child: CustomImage(
                                width: Get.width,
                                path: imageModel?.imagePath ??
                                    imageController
                                        .imageModel?.data.first.url ??
                                    '',
                                boxFit: BoxFit.cover,
                              ),
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
                            imageModel?.content ??
                                imageController
                                    .imageModel?.data.first.revisedPrompt ??
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
                            imageModel?.imagePath ??
                                imageController.imageModel?.data.first.url ??
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
