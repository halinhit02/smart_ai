import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'dialog_helpers.dart';

class FileHelpers {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<XFile?> pickImage({bool fromCamera = false}) async {
    try {
      XFile? file = await _imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return file;
    } catch (err) {
      debugPrint('>>> Pick file error: $err');
      DialogHelpers.showMessage('Cannot pick file.', error: true);
      return null;
    }
  }

  static String getExtension(String filePath) {
    if (filePath.isEmpty) {
      return '';
    }
    try {
      var str = filePath.split('.');
      if (str.isEmpty) {
        return '';
      }
      return str.last;
    } catch (err) {
      debugPrint('>>> Error: getting extension. $err');
      return '';
    }
  }
}
