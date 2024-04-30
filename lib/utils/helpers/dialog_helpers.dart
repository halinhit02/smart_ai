import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/widgets/custom_image.dart';
import '../constants/dimensions.dart';

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

  static showErrorMessage(String message) {
    return showMessage(message, error: true);
  }

  static Future showAlertDialog(
      BuildContext context, String title, String description,
      {Function()? onDone, Function()? onCancel}) async {
    await showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            contentTextStyle: Theme.of(context).textTheme.bodyMedium,
            content: Text(description),
            actions: [
              TextButton(
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(
                        Theme.of(context).textTheme.bodyMedium)),
                onPressed: () {
                  if (onCancel == null) {
                    Get.back();
                  } else {
                    onCancel();
                  }
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ))),
                onPressed: () {
                  if (onDone == null) {
                    Get.back();
                  } else {
                    onDone();
                  }
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  static showCustomDialog(
    BuildContext context,
    String title, {
    String description = '',
    String? imagePath,
    Widget? bottomWidget,
    bool dismissible = true,
    EdgeInsets? dialogPadding,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        child: Padding(
          padding: dialogPadding ??
              const EdgeInsets.all(
                Dimensions.paddingSizeLarge,
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                CustomImage(
                  path: imagePath,
                  boxFit: BoxFit.contain,
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  if (bottomWidget != null) bottomWidget,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
