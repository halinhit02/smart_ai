import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_ai/controller/purchase_controller.dart';
import 'package:smart_ai/data/repository/ads_repo.dart';

class AdsController extends GetxController {
  final AdmobRepo adsRepo;

  AdsController({required this.adsRepo});

  InterstitialAd? _interstitialAd;
  AppOpenAd? _appOpenAd;
  BannerAd? _bannerAd;
  int _latestTimeShowed = 0;

  InterstitialAd? get interstitialAd => _interstitialAd;

  BannerAd? get bannerAd => _bannerAd;

  AppOpenAd? get appOpenAd => _appOpenAd;

  @override
  void onInit() async {
    super.onInit();
    _loadInterstitialAds();
    _loadAd();
  }

  @override
  void onClose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _appOpenAd?.dispose();
    super.onClose();
  }

  _loadAd() async {
    await adsRepo.loadBannerAd(BannerAdListener(
      onAdLoaded: (Ad ad) {
        _bannerAd = ad as BannerAd;
        update();
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
    ));
  }

  _loadInterstitialAds() {
    adsRepo.loadInterstitialAd(InterstitialAdLoadCallback(onAdLoaded: (ad) {
      _interstitialAd = ad;
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {},
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _interstitialAd = null;
          _loadInterstitialAds();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _interstitialAd = null;
          _loadInterstitialAds();
        },
      );
    }, onAdFailedToLoad: (error) {
      _interstitialAd = null;
      _loadInterstitialAds();
    }));
  }

  showInterstitialAd({Function? onFinish, bool forceShow = false}) {
    if (Get.find<PurchaseController>().isPremium) {
      if (onFinish != null) {
        onFinish();
      }
      return;
    }
    if (forceShow) {
      if (_interstitialAd != null) {
        _interstitialAd
            ?.show()
            .then((value) => onFinish != null ? onFinish() : () {});
      } else if (onFinish != null) {
        onFinish();
      }
      return;
    }
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now - _latestTimeShowed < 30 * 1000) {
      return;
    } else {
      _latestTimeShowed = now;
    }
    if (_interstitialAd != null) {
      _interstitialAd
          ?.show()
          .then((value) => onFinish != null ? onFinish() : () {});
    } else if (onFinish != null) {
      onFinish();
    }
  }
}
