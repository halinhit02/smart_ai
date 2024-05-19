import 'dart:async';

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
  RxBool isAvailable = true.obs;

  @override
  void onInit() {
    _getAvailable();
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

  Future _getProductDetails() async {
    try {
      productDetailList.value = await purchaseRepo.getAllProductDetails(
        AppConstants.productIds,
      );
    } catch (e) {
      DialogHelpers.showErrorMessage(e.toString());
    }
    productLoading.value = false;
  }

  Future _getAvailable() async {
    isAvailable.value = await purchaseRepo.isAvailable();
  }

  Future _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        //_showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          //_handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }
}
