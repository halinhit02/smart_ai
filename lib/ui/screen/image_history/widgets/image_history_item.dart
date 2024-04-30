import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/image_controller.dart';
import 'package:smart_ai/model/image_model.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class ImageHistoryItem extends StatelessWidget {
  const ImageHistoryItem({
    super.key,
    required this.imageModel,
  });

  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
        ),
        color: Colors.red,
        child: const CustomImage(
          path: MyIcons.delete,
          color: Colors.white,
        ),
      ),
      key: ValueKey(imageModel),
      confirmDismiss: (direction) async {
        bool value = false;
        await DialogHelpers.showAlertDialog(
            context, 'Delete Image', "Do you want to delete the image?",
            onDone: () {
          value = true;
          Get.back();
          Get.find<ImageController>().deleteImage(imageModel.id);
        });
        return value;
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.paddingSizeSmall,
        ),
        padding: const EdgeInsets.only(
          top: Dimensions.radiusSizeDefault,
          bottom: Dimensions.radiusSizeDefault,
          left: Dimensions.paddingSizeLarge,
          right: Dimensions.paddingSizeLarge,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    imageModel.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraSmall,
                  ),
                  Text(
                    DateFormat.yMEd().format(imageModel.createdAt!),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                ],
              ),
            ),
            const CustomImage(
              path: MyIcons.arrowLeft,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
