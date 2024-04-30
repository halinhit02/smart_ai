import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/account/widgets/horizontal_title_widget.dart';
import 'package:smart_ai/ui/screen/account/widgets/menu_profile_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/images.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Andrew Ainslay',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'andrew.ainsley@yourdomain.com',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  CupertinoIcons.right_chevron,
                  size: 18,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeDefault,
                bottom: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
              ),
              margin: const EdgeInsets.only(
                top: Dimensions.paddingSizeLarge,
                bottom: Dimensions.paddingSizeSmall,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(
                  Dimensions.radiusSizeLarge,
                ),
              ),
              child: Row(
                children: [
                  const CustomImage(
                    path: Images.starUpgrade,
                    size: 64,
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upgrade to PRO!',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Enjoy all benefits without restrictions',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade50,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            HorizontalTitleWidget(title: 'General'),
            MenuProfileItem(
              iconPath: MyIcons.personalInfo,
              title: 'Personal Info',
              route: '',
            ),
            MenuProfileItem(
              iconPath: MyIcons.security,
              title: 'Security',
            ),
            MenuProfileItem(
              iconPath: MyIcons.language,
              title: 'Language',
            ),
            MenuProfileItem(
              iconPath: MyIcons.darkMode,
              title: 'Dark Mode',
            ),
            HorizontalTitleWidget(title: 'About'),
            MenuProfileItem(
              iconPath: MyIcons.helpCenter,
              title: 'Help Center',
            ),
            MenuProfileItem(
              iconPath: MyIcons.privacy,
              title: 'Privacy Policy',
            ),
            MenuProfileItem(
              iconPath: MyIcons.helpCenter,
              title: 'Help Center',
            ),
            MenuProfileItem(
              iconPath: MyIcons.logout,
              title: 'Logout',
              titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
              onTap: () => Get.offAllNamed(AppRoutes.authRoute),
            ),
          ],
        ),
      ),
    );
  }
}
