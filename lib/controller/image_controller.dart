import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_ai/data/repository/gpt_repo.dart';
import 'package:smart_ai/data/repository/image_repo.dart';
import 'package:smart_ai/model/image_create_model.dart';
import 'package:smart_ai/model/image_model.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

import 'ads_controller.dart';

class ImageController extends GetxController {
  GPTRepo gptRepo;
  ImageRepo imageRepo;

  ImageController({
    required this.gptRepo,
    required this.imageRepo,
  });

  Rx<OpenAIImageSize> imageSize = OpenAIImageSize.size256.obs;
  Rx<OpenAIImageStyle> imageStyle = OpenAIImageStyle.natural.obs;
  Rx<OpenAIImageQuality> imageQuality = OpenAIImageQuality.hd.obs;
  RxList<ImageModel> imageList = <ImageModel>[].obs;
  RxBool loading = false.obs;
  RxBool generating = false.obs;
  RxBool saving = false.obs;

  OpenAIImageModel? imageModel;
  String? imageDescription;

  Future generateImage(String description) async {
    if (description.isEmpty) {
      DialogHelpers.showErrorMessage('Description not Empty.');
      return;
    }
    Get.find<AdsController>().showInterstitialAd(forceShow: true);
    imageDescription = description;
    generating.value = true;
    try {
      var image = await gptRepo.createImage(
        description,
        size: imageSize.value,
        style: imageStyle.value,
        quality: imageQuality.value,
      );
      if (image.haveData) {
        imageModel = image;
        ImageCreateModel imageCreateModel = ImageCreateModel(
          content: description,
          imagePath: image.data.first.url ?? '',
          model: 'dall-e-3',
        );
        imageRepo
            .createUserImage(imageCreateModel)
            .then((value) => imageList.add(value))
            .onError((error, stackTrace) {
          if (kDebugMode) {
            debugPrint('>>> Generate image error: $error');
          }
          DialogHelpers.showErrorMessage('Cannot image to history.');
        });
        Get.toNamed(AppRoutes.resultImageRoute());
      } else {
        DialogHelpers.showErrorMessage('Generate image occurred error.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('>>> Generate Image error: $e');
      }
      DialogHelpers.showErrorMessage('Something went wrong. $e');
    }
    generating.value = false;
  }

  Future getUserImage() async {
    try {
      loading.value = true;
      imageList.value = await imageRepo.getUserImage();
      loading.value = false;
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Get user Image error: $err');
      }
      DialogHelpers.showErrorMessage('Something went wrong.');
    }
  }

  Future deleteAllHistory() async {
    try {
      for (var element in imageList) {
        await imageRepo.deleteImage(element.id);
      }
      imageList.clear();
      DialogHelpers.showMessage('Delete all image successfully.');
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Delete all chat error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
  }

  Future deleteImage(int imageId) async {
    try {
      String message = await imageRepo.deleteImage(imageId);
      DialogHelpers.showMessage(message);
      getUserImage();
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Delete image error: $err');
      }
      DialogHelpers.showErrorMessage('Something went wrong.');
    }
  }

  Future saveImage(String imagePath) async {
    if (imagePath.isEmpty) {
      DialogHelpers.showMessage('Image path is empty.');
    }
    saving.value = true;
    try {
      await imageRepo.saveImageGallery(imagePath);
      DialogHelpers.showMessage('This image is saved to gallery.');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('>>> Save image  error: $e');
      }
      DialogHelpers.showErrorMessage(e.toString());
    }
    saving.value = false;
  }
}
