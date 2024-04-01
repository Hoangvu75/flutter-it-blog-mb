import 'dart:async';

import 'package:flutter/material.dart';

import '../../easy_ads_flutter.dart';
import '../utils/easy_loading_ad.dart';

class EasyAdmobNativeAd extends EasyAdBase {
  final AdRequest _adRequest;
  final String _factoryId;
  final double _height;
  final Widget? loadingWidget;

  EasyAdmobNativeAd(
    String adUnitId,
    String factoryId,
    double height, {
    AdRequest? adRequest,
    this.loadingWidget,
  })  : _adRequest = adRequest ?? const AdRequest(),
        _factoryId = factoryId,
        _height = height,
        super(adUnitId);

  NativeAd? _nativeAd;
  bool _isAdLoaded = false;
  bool _isAdLoading = false;
  bool _isAdLoadedFailed = false;

  @override
  AdUnitType get adUnitType => AdUnitType.native;

  @override
  AdNetwork get adNetwork => AdNetwork.admob;

  @override
  void dispose() {
    _isAdLoaded = false;
    _isAdLoadedFailed = false;
    _nativeAd?.dispose();
    _nativeAd = null;
  }

  @override
  bool get isAdLoaded => _isAdLoaded;

  @override
  bool get isAdLoadedFailed => _isAdLoadedFailed;

  @override
  Future<bool> load() async {
    Completer<bool> completer = Completer();
    _nativeAd = NativeAd(
      adUnitId: adUnitId,
      factoryId: _factoryId,
      request: _adRequest,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _nativeAd = ad as NativeAd?;
          _isAdLoaded = true;
          _isAdLoadedFailed = false;
          _isAdLoading = false;
          onAdLoaded?.call(adNetwork, adUnitType, ad);
          completer.complete(true);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _nativeAd = null;
          _isAdLoaded = false;
          _isAdLoading = false;
          _isAdLoadedFailed = true;
          onAdFailedToLoad?.call(adNetwork, adUnitType, ad, error.toString());
          ad.dispose();
          completer.complete(false);
        },
        onAdOpened: (Ad ad) => onAdClicked?.call(adNetwork, adUnitType, ad),
        onAdClosed: (Ad ad) => onAdDismissed?.call(adNetwork, adUnitType, ad),
        onAdImpression: (Ad ad) => onAdShowed?.call(adNetwork, adUnitType, ad),
        onPaidEvent: (ad, valueMicros, precision, currencyCode) =>
            onPaidEvent?.call(
          adNetwork,
          adUnitType,
          ad,
          valueMicros,
          precision,
          currencyCode,
        ),
      ),
    );
    _nativeAd?.load();
    _isAdLoading = true;
    onAdLoading?.call(adNetwork, adUnitType, null);
    return completer.future;
  }

  @override
  dynamic show() {
    final ad = _nativeAd;
    if (_isAdLoading) {
      return SizedBox(
        height: _height,
        child: loadingWidget ?? const EasyLoadingAd(),
      );
    }
    if (ad == null || !_isAdLoaded) {
      return SizedBox(
        height: _height,
      );
    }
    return SizedBox(
      height: _height,
      child: AdWidget(ad: ad),
    );
  }

  @override
  bool get isAdLoading => _isAdLoading;
}
