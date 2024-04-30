import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:smart_ai/data/data_source/remote/image_remote_source.dart';
import 'package:smart_ai/model/image_create_model.dart';
import 'package:smart_ai/model/image_model.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';

class ImageRepo {

  ImageRemoteSource imageRemoteSource;

  ImageRepo({required this.imageRemoteSource});

  Future<List<ImageModel>> getUserImage() async {
    var imageResponse = await imageRemoteSource.getUserImage();
    if (imageResponse.success && imageResponse.data != null) {
      return imageResponse.data!;
    } else {
      return Future.error(imageResponse.message);
    }
  }

  Future<ImageModel> createUserImage(ImageCreateModel imageCreateModel) async {
    var imageResponse = await imageRemoteSource.createImage(imageCreateModel);
    if (imageResponse.success && imageResponse.data != null) {
      return imageResponse.data!;
    } else {
      return Future.error(imageResponse.message);
    }
  }

  Future<String> deleteImage(int imageId) async {
    var imageResponse = await imageRemoteSource.deleteImage(imageId);
    if (imageResponse.success) {
      return imageResponse.message;
    } else {
      return Future.error(imageResponse.message);
    }
  }

  Future saveImageGallery(String imagePath) async {
    var response = await Dio()
        .get(imagePath, options: Options(responseType: ResponseType.bytes));
    return await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
        quality: 100,
        name:
            '${AppConstants.appName}-${DateTime.now().millisecondsSinceEpoch}');
  }
}
