import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseRepo {
  InAppPurchase inAppPurchase = InAppPurchase.instance;

  Future<bool> isAvailable() async {
    return await inAppPurchase.isAvailable();
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
    return response.productDetails;
  }

  Stream<List<PurchaseDetails>> purchaseUpdatedStream() {
    return inAppPurchase.purchaseStream;
  }
}
