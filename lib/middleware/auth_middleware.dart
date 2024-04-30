import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    Get.find<AuthController>().getUserLocal();
    if (Get.find<AuthController>().userModel.value == null) {
      return RouteSettings(name: AppRoutes.authRoute);
    }
    return super.redirect(route);
  }
}
