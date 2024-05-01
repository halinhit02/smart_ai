import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ai/data/data_source/local/user_local_source.dart';
import 'package:smart_ai/data/data_source/remote/user_remote_source.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/utils/helpers/file_helpers.dart';

class UserRepo {
  UserLocalSource userLocalSource;
  UserRemoteSource userRemoteSource;

  UserRepo({
    required this.userLocalSource,
    required this.userRemoteSource,
  });

  Future<UserModel> editUser(UserModel userModel) async {
    var userResponse = await userRemoteSource.editUserModel(userModel);
    if (userResponse.success && userResponse.data != null) {
      return userResponse.data!;
    } else {
      return Future.error(userResponse.message);
    }
  }

  Future<String> uploadFile(String filePath, int userId,
      [String? contentType]) async {
    File file = File(filePath);
    if (!file.existsSync()) {
      return Future.error('File not found.');
    }
    var storageRef =
        '/photos/avatar_$userId.${FileHelpers.getExtension(filePath)}';
    debugPrint('>>> Firebase Storage: $storageRef');
    var uploadTask = await FirebaseStorage.instance.ref(storageRef).putFile(
        file,
        SettableMetadata(
          contentType: contentType,
        ));
    return await uploadTask.ref.getDownloadURL();
  }
}
