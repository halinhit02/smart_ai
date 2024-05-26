import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:smart_ai/data/repository/purchase_repo.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class PurchaseController extends GetxController {
  PurchaseRepo purchaseRepo;

  PurchaseController({
    required this.purchaseRepo,
  });

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  RxList<ProductDetails> productDetailList = RxList();
  RxBool productLoading = true.obs;
  RxBool purchasing = false.obs;
  RxBool isAvailable = true.obs;
  bool isRestore = true;
  Rx<PurchaseDetails?> currentPurchaseDetail = Rx(null);

  bool get isPremium => currentPurchaseDetail.value != null;

  @override
  void onInit() {
    purchaseRepo.restorePurchase();
    _getProductDetails();
    _subscription =
        purchaseRepo.purchaseUpdatedStream().listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.onInit();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future buyItem(ProductDetails productDetails) async {
    if (currentPurchaseDetail.value == null ||
        currentPurchaseDetail.value?.productID != productDetails.id) {
      purchasing.value = true;
      await purchaseRepo.buy(productDetails);
      purchasing.value = false;
    }
  }

  Future _getProductDetails() async {
    try {
      await _getAvailable();
      if (isAvailable.isFalse) {
        return;
      }
      productDetailList.value = await purchaseRepo.getAllProductDetails(
        AppConstants.productIds,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('>>> Get product details error: $e');
      }
      //DialogHelpers.showErrorMessage(e.toString());
    }
    productLoading.value = false;
  }

  Future _getAvailable() async {
    isAvailable.value = await purchaseRepo.isAvailable();
  }

  Future _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.sort((a, b) => int.parse(a.transactionDate ?? '0')
        .compareTo(int.parse(b.transactionDate ?? '0')));
    purchasing.value = true;
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.error != null && kDebugMode) {
      debugPrint(
          '>>> Handle purchase error: ${purchaseDetails.error?.message}');
    }
    if (purchaseDetails.status == PurchaseStatus.pending) {
      /*DialogHelpers.showMessage(
          'This product is pending. Please, try again later.');*/
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        DialogHelpers.showErrorMessage(
            'Something went wrong. Please, try again.');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        bool isExpired = await purchaseRepo.isExpiredProduct(purchaseDetails);
        if (!isExpired) {
          currentPurchaseDetail.value = purchaseDetails;
          if (purchaseDetails.status == PurchaseStatus.purchased &&
              !isRestore) {
            DialogHelpers.showMessage('You had upgraded to PRO with'
                ' ${currentPurchaseDetail.value?.productID} plan.');
          }
        } else {
          currentPurchaseDetail.value = null;
          if (purchaseDetails.status == PurchaseStatus.purchased) {
            DialogHelpers.showMessage('You have failed to upgrade to PRO.');
          }
        }
      }
      purchasing.value = false;
    }
    if (purchaseDetails.pendingCompletePurchase) {
      await InAppPurchase.instance.completePurchase(purchaseDetails);
    }
  }
}
