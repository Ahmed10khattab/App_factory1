import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._privateConstructor();
  static final AdManager instance = AdManager._privateConstructor();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialReady = false;

  BannerAd? _bannerAd;

  void loadInterstitial() {
     
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isInterstitialReady = false;

    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialReady = true;
          debugPrint('✅ Interstitial Loaded');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isInterstitialReady = false;
          debugPrint('❌ Failed to load interstitial: $error');
        },
      ),
    );
  }

  void showInterstitial({required VoidCallback onAdDismissed}) {
    if (_isInterstitialReady && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitial(); // Load next ad
        onAdDismissed();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitial();
        onAdDismissed();
      });
      _interstitialAd!.show();
    } else {
      onAdDismissed();
    }
  }

  /// ---------------- Banner ----------------
  void loadBanner({required String adUnitId}) {
    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => debugPrint("✅ Banner Loaded"),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint("❌ Banner failed: $error");
        },
      ),
    )..load();
  }

  BannerAd? get bannerAd => _bannerAd;

  void dispose() {
    _interstitialAd?.dispose();
    _bannerAd?.dispose();
  }
}
