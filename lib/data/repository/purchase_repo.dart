import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/helpers/app_helper.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class PurchaseRepo {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<bool> isAvailable() async {
    return await _inAppPurchase.isAvailable();
  }

  Future<List<ProductDetails>> getAllProductDetails(List<String> kIds) async {
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(kIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      return Future.error('Not found purchase products.');
    }
    if (response.error != null) {
      if (kDebugMode) {
        debugPrint(
            '>>> Get all product details error: ${response.error?.message}');
      }
      return Future.error('Cannot get purchase products.');
    }
    var result = response.productDetails;
    result.sort((e1, e2) => e1.rawPrice.compareTo(e2.rawPrice));
    return result;
  }

  Stream<List<PurchaseDetails>> purchaseUpdatedStream() {
    return _inAppPurchase.purchaseStream;
  }

  Future<bool> buy(ProductDetails productDetails) async {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    if (AppConstants.productIds.contains(productDetails.id)) {
      try {
        return await _inAppPurchase.buyNonConsumable(
            purchaseParam: purchaseParam);
      } catch (e) {
        if (e.toString().contains('duplicate')) {
          DialogHelpers.showMessage(
            'You had bought this plan. Please try again later.',
          );
        }
        return Future.error(e);
      }
    } else {
      return Future.error('${productDetails.id} is not a known product.');
    }
  }

  Future restorePurchase() async {
    return await _inAppPurchase.restorePurchases(
        applicationUserName: AppConstants.appName);
  }

  Future<bool> isExpiredProduct(PurchaseDetails purchaseDetails) async {
    int createTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(purchaseDetails.transactionDate ?? '0'))
        .millisecondsSinceEpoch;
    int serverTime = AppHelper.getServerTimeMillis(utc: true);
    int totalDays =
        ((serverTime - createTime) / (1000 * 60 * 60 * 60 * 24)).floor();
    int productIndex =
        AppConstants.productIds.indexOf(purchaseDetails.productID);
    if (productIndex == 0) {
      if (totalDays > 31) {
        return true;
      }
    } else if (productIndex == 1) {
      if (totalDays > 31 * 3) {
        return true;
      }
    } else if (productIndex == 2) {
      if (totalDays > 6 * 31) {
        return true;
      }
    } else if (productIndex == 3) {
      if (totalDays > 12 * 31) {
        return true;
      }
    }
    return false;
  }
}
