import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/ui/screen/account/widgets/horizontal_title_widget.dart';
import 'package:smart_ai/ui/screen/account/widgets/menu_profile_item.dart';
import 'package:smart_ai/ui/screen/account/widgets/upgrade_widget.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/images.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';
import 'package:smart_ai/utils/helpers/app_helper.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

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
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(
                    path: authController.userModel.value?.photo ??
                        Images.defaultPhoto,
                    size: 68,
                    isOval: true,
                    boxFit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authController.userModel.value?.fullName ??
                            'SmartAI User',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        authController.userModel.value?.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            const UpgradeWidget(),
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
              iconPath: MyIcons.delete,
              title: 'Delete Account',
              onTap: () {
                DialogHelpers.showAlertDialog(
                    context,
                    'Delete Account',
                    'Are you sure you want to delete your account? '
                        'All data and related information will be permanently deleted and cannot be recovered.',
                    onDone: () {
                  DialogHelpers.showMessage('Your account is deleted.');
                  authController.signOut();
                });
              },
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
