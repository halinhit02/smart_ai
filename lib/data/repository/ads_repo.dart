import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobRepo {
  Future<void> loadOpenAds(AppOpenAdLoadCallback callback) {
    return AppOpenAd.load(
      adUnitId: _openAppAdUnitId,
      request: const AdRequest(),
      adLoadCallback: callback,
    );
  }

  loadBannerAd(BannerAdListener bannerAdListener) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            Get.size.width.truncate());
    if (size == null) {
      return;
    }
    BannerAd(
      adUnitId: _bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: bannerAdListener,
    ).load();
  }

  loadInterstitialAd(InterstitialAdLoadCallback onCallback) {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: onCallback,
    );
  }

  static String get _bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-5301774779419611/8059364867';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5301774779419611/8989303152';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get _interstitialAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-5301774779419611/4093281269';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5301774779419611/7676221482';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get _openAppAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9257395921';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/5575463023';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-5301774779419611/2393186781';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5301774779419611/4555234128';
    }
    throw UnsupportedError('Unsupported platform');
  }
}
