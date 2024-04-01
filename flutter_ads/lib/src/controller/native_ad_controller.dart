import 'dart:async';

import 'package:easy_ads_flutter/src/controller/ad_controller.dart';

import '../../easy_ads_flutter.dart';

class NativeAdController extends AdController {
  NativeAdController({
    required super.adId,
    required this.factoryId,
    this.adChoicesPlacement = AdChoicesPlacement.bottomRightCorner,
    super.lowId,
  });

  final AdChoicesPlacement adChoicesPlacement;

  final String factoryId;

  NativeAd? _nativeAd;
  final String controllerId = DateTime.now().microsecondsSinceEpoch.toString();

  NativeAd? get ad => _nativeAd;

  @override
  Future<void> load() => _loadAd();

  Future<void> _loadAd({String? id, bool reloadOnFailed = true}) async {
    if (status.isLoading ||
        status.isLoaded ||
        status.isShown ||
        !EasyAds.instance.hasInternet) {
      return;
    }
    Completer<void> completer = Completer();

    final NativeAdOptions nativeAdOptions = NativeAdOptions(
        adChoicesPlacement: adChoicesPlacement
    );

    _nativeAd = NativeAd(
      adUnitId: id ?? adId,
      factoryId: factoryId,
      request: EasyAds.instance.adRequest,
      nativeAdOptions: nativeAdOptions,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _nativeAd = ad as NativeAd?;
          addEvent(AdStatus.loaded);
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) async {
          _nativeAd = null;
          addEvent(AdStatus.loadFailed, error: error);
          ad.dispose();
          if (reloadOnFailed && lowId != null) {
            await _loadAd(id: lowId, reloadOnFailed: false);
            if (!completer.isCompleted) {
              completer.completeError(error);
            }
          } else {
            if (!completer.isCompleted) {
              completer.completeError(error);
            }
          }
        },
      ),
    );
    addEvent(AdStatus.loading);
    _nativeAd?.load();
    return completer.future;
  }

  @override
  void reload() {
    disposeAd();
    load();
  }

  void disposeAd() {
    _nativeAd?.dispose();
    addEvent(AdStatus.init);
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
