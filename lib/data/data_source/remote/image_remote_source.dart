import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/image_create_model.dart';
import 'package:smart_ai/model/image_model.dart';

import '../../../model/api_response_model.dart';
import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_constants.dart';

class ImageRemoteSource extends GetConnect {

  SharedPreferences sharedPrefs;

  ImageRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = AppConfig.baseUrl;
    httpClient.addRequestModifier<Object?>((request) =>
    request
      ..headers.addAll({
        'Authorization':
        sharedPrefs.getString(AppConstants.accessTokenKey) ?? '',
      }));
  }

  Future<ApiResponseModel<List<ImageModel>>> getUserImage() async {
    var response = await get(AppConfig.imageEndpoint);
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<List<ImageModel>>.fromJson(body,
              (data) => List.from(data.map((e) => ImageModel.fromJson(e))));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<ImageModel>> createImage(
      ImageCreateModel imageCreateModel) async {
    var response =
    await post(AppConfig.imageEndpoint, imageCreateModel.toJson());
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<ImageModel>.fromJson(
          body, (data) => ImageModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel> deleteImage(int imageId) async {
    var response = await delete('${AppConfig.imageEndpoint}/$imageId');
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel.fromJson(body);
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
