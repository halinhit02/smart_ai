import 'package:flutter/material.dart';
import 'package:teen_match/ui/base/custom_button.dart';
import 'package:get/get.dart';
import 'package:teen_match/ui/base/custom_image.dart';

import '../theme/text_theme.dart';
import '../util/dimensions.dart';

class DialogHelpers {
  static showMessage(String message,
      {BuildContext? context, bool error = false}) {
    Get.closeAllSnackbars();
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              error ? Theme.of(context).colorScheme.error : Colors.green,
        ),
      );
      return;
    }
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: error ? Get.theme.colorScheme.error : Colors.green,
      duration: const Duration(seconds: 4),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }

  static showCustomDialog(BuildContext context, String title,
      {String description = '',
      String? imagePath,
      bool buttonShow = false,
      String? buttonText,
      Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        child: Container(
          padding: const EdgeInsets.all(
            Dimensions.paddingSizeExtraLarge + 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                CustomImage(
                  path: imagePath,
                  fit: BoxFit.contain,
                  height: 150,
                ),
              if (imagePath != null)
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
              Column(
                children: [
                  Text(
                    title,
                    style: heading4.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeDefault,
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: bodyLargeRegular,
                      ),
                    ),
                  if (buttonShow && buttonText != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeExtraLarge,
                      ),
                      child: CustomButton(
                        text: buttonText,
                        onPressed: onPressed,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
