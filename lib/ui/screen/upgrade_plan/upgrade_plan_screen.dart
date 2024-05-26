import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/purchase_controller.dart';
import 'package:smart_ai/ui/screen/upgrade_plan/widgets/plan_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/helpers/app_helper.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class UpgradePlanScreen extends StatelessWidget {
  const UpgradePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var purchaseController = Get.find<PurchaseController>();
    if (purchaseController.currentPurchaseDetail.value != null &&
        purchaseController.isRestore) {
      purchaseController.isRestore = false;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        DialogHelpers.showMessage('You had upgraded to PRO and continue with'
            ' ${purchaseController.currentPurchaseDetail.value?.productID} plan.');
      });
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upgrade to PRO!',
        actions: [
          TextButton(
            onPressed: () => purchaseController.restorePurchase(),
            child: const Text('Restore'),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
        ],
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
          var productList = purchaseController.productDetailList
              .where((p0) => p0.rawPrice > 0)
              .toList();
          var firstPrice = productList.firstOrNull?.rawPrice.round() ?? 0;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: purchaseController.productDetailList.length + 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeDefault,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  itemBuilder: (itemCtx, index) {
                    return Obx(() {
                      bool currentPlan = false;
                      if (purchaseController.currentPurchaseDetail.value ==
                              null &&
                          index == 0) {
                        currentPlan = true;
                      } else if (index > 0) {
                        currentPlan = currentPlan ||
                            purchaseController
                                    .currentPurchaseDetail.value?.productID
                                    .compareTo(purchaseController
                                        .productDetailList[index - 1].id) ==
                                0;
                      }
                      if (index == 0) {
                        return PlanItem(
                          shortDescription:
                              'Enjoy all benefits, (save over 30%)',
                          price: 'Free',
                          duration: 'Life time',
                          descriptionList: AppConstants.freeDescription,
                          currentPlan: currentPlan,
                          freePlan: true,
                        );
                      } else {
                        var item =
                            purchaseController.productDetailList[index - 1];
                        int savePercent = 0;
                        var rawPrice = item.rawPrice.round();
                        int productIndex =
                            AppConstants.productIds.indexOf(item.id);
                        if (productIndex == 1) {
                          savePercent = ((firstPrice * 3 - rawPrice) /
                                  (firstPrice * 3) *
                                  100)
                              .round();
                        } else if (productIndex == 2) {
                          savePercent = ((firstPrice * 6 - rawPrice) /
                                  (firstPrice * 6) *
                                  100)
                              .round();
                        } else if (productIndex > 2) {
                          savePercent = ((firstPrice * 12 - rawPrice) /
                                  (firstPrice * 12) *
                                  100)
                              .round();
                        }
                        return Obx(
                          () => PlanItem(
                              shortDescription: index < 2
                                  ? 'Enjoy all benefits.'
                                  : 'Enjoy all benefits, (save over $savePercent%)',
                              price:
                                  '${item.currencySymbol}${NumberFormat().format(item.rawPrice)}',
                              duration: item.title,
                              freeTrial: AppConstants.freeTrials[index - 1],
                              descriptionList: AppConstants.planDescription,
                              mostPopular: index == 3,
                              currentPlan: currentPlan,
                              purchasing: purchaseController.purchasing.isTrue,
                              onSelectPlan: () {
                                var products = purchaseController
                                    .productDetailList
                                    .where((p0) => p0.id == item.id)
                                    .toList();
                                products.sort((p1, p2) =>
                                    p1.rawPrice.compareTo(p2.rawPrice));
                                purchaseController.buyItem(products.first);
                              }),
                        );
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall,
                    horizontal: Dimensions.paddingSizeLarge,
                  ),
                  child: Text(
                    'Subscriptions will be auto renew. You can cancel or make change at any time.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppHelper.openLink(FirebaseRemoteConfig.instance
                        .getString(AppConfig.privacyLinkKey));
                  },
                  child: Text(
                    'Private Policy | Terms of Use',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeLarge,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
