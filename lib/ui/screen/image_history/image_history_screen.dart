import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/image_controller.dart';
import 'package:smart_ai/ui/screen/image_history/widgets/image_history_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/images.dart';

import '../../../utils/constants/my_icons.dart';
import '../../../utils/helpers/dialog_helpers.dart';
import '../../widgets/custom_image.dart';

class ImageHistoryScreen extends StatefulWidget {
  const ImageHistoryScreen({super.key});

  @override
  State<ImageHistoryScreen> createState() => _ImageHistoryScreenState();
}

class _ImageHistoryScreenState extends State<ImageHistoryScreen> {
  var imageController = Get.find<ImageController>();

  @override
  void initState() {
    super.initState();
    imageController.getUserImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Image History',
        actions: [
          IconButton(
            onPressed: () {
              DialogHelpers.showAlertDialog(context, 'Delete All Image',
                  'Do you want to delete all your image?', onDone: () {
                Get.back();
                imageController.deleteAllHistory();
              });
            },
            icon: const CustomImage(
              path: MyIcons.delete,
              size: 22,
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => imageController.getUserImage(),
          child: Obx(() {
            return imageController.loading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : imageController.imageList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CustomImage(
                              path: Images.empty,
                              height: Get.height * 0.2,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraLarge,
                          ),
                          Text(
                            'Empty',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade900,
                                ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            'You have no history.',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey.shade900,
                                    ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: imageController.imageList.length,
                        itemBuilder: (itemCtx, index) => GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.resultImageRoute(
                              imageId: imageController.imageList[index].id)),
                          child: ImageHistoryItem(
                            imageModel: imageController.imageList[index],
                          ),
                        ),
                      );
          }),
        ),
      ),
    );
  }
}
