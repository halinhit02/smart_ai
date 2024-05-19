import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/purchase_controller.dart';
import 'package:smart_ai/ui/screen/upgrade_plan/widgets/description_item.dart';
import 'package:smart_ai/ui/screen/upgrade_plan/widgets/plan_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class UpgradePlanScreen extends StatelessWidget {
  const UpgradePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var purchaseController = Get.find<PurchaseController>();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Upgrade to PRO!',
      ),
      body: SafeArea(
        child: Obx(() {
          if (purchaseController.isAvailable.isFalse) {
            return const Center(
              child: Text('In App Purchase isn\'t available in your country'),
            );
          } else if (purchaseController.productDetailList.isEmpty) {
            return const Center(
              child: Text('Cannot load items.'),
            );
          } else if (purchaseController.productDetailList.isEmpty &&
              purchaseController.productLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print(purchaseController.productDetailList.first.toString());
          return ListView.separated(
            itemCount: purchaseController.productDetailList.length + 1,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeDefault,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            itemBuilder: (itemCtx, index) {
              if (index == 0) {
                return PlanItem(
                  shortDescription: 'Enjoy all benefits, (save over 30%)',
                  price: 'Free',
                  duration: 'Life time',
                  descriptionList: AppConstants.freeDescription,
                  currentPlan: true,
                  mostPopular: true,
                  onSelectPlan: () {},
                );
              } else {
                var item = purchaseController.productDetailList[index - 1];
                return PlanItem(
                  shortDescription: 'Enjoy all benefits, (save over 30%)',
                  price: '${item.currencySymbol}${item.price}',
                  duration: item.currencyCode,
                  descriptionList: AppConstants.planDescription,
                  mostPopular: index == 2,
                  onSelectPlan: () {},
                );
              }
            },
          );
        }),
      ),
    );
  }
}
