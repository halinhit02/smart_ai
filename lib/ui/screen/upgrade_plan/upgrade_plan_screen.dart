import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/purchase_controller.dart';
import 'package:smart_ai/ui/screen/upgrade_plan/widgets/plan_item.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
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
            ' ${purchaseController.currentPurchaseDetail.value
            ?.productID} plan.');
      });
    }
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
              return Obx(() {
                bool currentPlan = false;
                if (purchaseController.currentPurchaseDetail.value == null &&
                    index == 0) {
                  currentPlan = true;
                } else if (index > 0) {
                  currentPlan = currentPlan ||
                      purchaseController.currentPurchaseDetail.value?.productID
                              .compareTo(purchaseController
                                  .productDetailList[index - 1].id) ==
                          0;
                }
                if (index == 0) {
                  return PlanItem(
                    shortDescription: 'Enjoy all benefits, (save over 30%)',
                    price: 'Free',
                    duration: 'Life time',
                    descriptionList: AppConstants.freeDescription,
                    currentPlan: currentPlan,
                    freePlan: true,
                  );
                } else {
                  var item = purchaseController.productDetailList[index - 1];
                  return Obx(
                    () => PlanItem(
                      shortDescription: 'Enjoy all benefits, (save over 30%)',
                      price:
                          '${item.currencySymbol}${NumberFormat().format(item.rawPrice)}',
                      duration: item.title,
                      descriptionList: AppConstants.planDescription,
                      mostPopular: index == 3,
                      currentPlan: currentPlan,
                      purchasing: purchaseController.purchasing.isTrue,
                      onSelectPlan: () => purchaseController.buyItem(item),
                    ),
                  );
                }
              });
            },
          );
        }),
      ),
    );
  }
}
