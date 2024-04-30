import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/screen/account/widgets/horizontal_title_widget.dart';
import 'package:smart_ai/ui/screen/account/widgets/menu_profile_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';
import 'package:smart_ai/utils/helpers/app_helper.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    var privacyLink =
        FirebaseRemoteConfig.instance.getString(AppConfig.privacyLinkKey);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Account',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: Dimensions.paddingSizeLarge,
          right: Dimensions.paddingSizeLarge,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomImage(
                  path:
                      "https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp",
                  size: 68,
                  boxFit: BoxFit.fill,
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                Expanded(
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authController.userModel.value?.fullName ??
                                'SmartAI User',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            authController.userModel.value?.email ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
            const HorizontalTitleWidget(title: 'General'),
            MenuProfileItem(
              iconPath: MyIcons.personalInfo,
              title: 'Change Profile',
              route: AppRoutes.changeProfileRoute,
            ),
            MenuProfileItem(
              iconPath: MyIcons.security,
              title: 'Change Password',
              route: AppRoutes.changePasswordRoute,
            ),
            MenuProfileItem(
              iconPath: MyIcons.security,
              title: 'Setting',
            ),
            const HorizontalTitleWidget(title: 'About'),
            MenuProfileItem(
              iconPath: MyIcons.helpCenter,
              title: 'Help Center',
              onTap: () => AppHelper.openLink(privacyLink),
            ),
            MenuProfileItem(
              iconPath: MyIcons.privacy,
              title: 'Privacy Policy',
              onTap: () => AppHelper.openLink(privacyLink),
            ),
            MenuProfileItem(
              iconPath: MyIcons.logout,
              title: 'Logout',
              titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
              onTap: () => authController.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
