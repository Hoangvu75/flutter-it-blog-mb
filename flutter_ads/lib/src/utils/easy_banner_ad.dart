import 'dart:async';

import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';

import 'easy_loading_ad.dart';

class EasyBannerAd extends StatefulWidget {
  final AdNetwork adNetwork;
  final AdSize? adSize;
  final String? adId;
  final String? lowId;
  final bool? isCollapsible;
  final Widget? loadingWidget;
  final BannerAdController? controller;
  final Border? borderBanner;

  const EasyBannerAd({
    super.key,
    this.adNetwork = AdNetwork.admob,
    this.adId,
    this.lowId,
    this.adSize,
    this.isCollapsible,
    this.controller,
    this.loadingWidget,
    this.borderBanner,
  })  : assert(
          controller == null || adId == null,
          'Cannot provide both a controller and adId\n'
          'To provide both, use "controller: BannerAdController(adId: adId, ...)".',
        ),
        assert(
          controller == null || isCollapsible == null,
          'Cannot provide both a controller and isCollapsible\n'
          'To provide both, use "controller: BannerAdController(isCollapsible: isCollapsible, ...)".',
        ),
        assert(
          controller == null || lowId == null,
          'Cannot provide both a controller and lowId\n'
          'To provide both, use "controller: BannerAdController(lowId: lowId, ...)".',
        ),
        assert(
          controller == null || adSize == null,
          'Cannot provide both a controller and adSize\n'
          'To provide both, use "controller: BannerAdController(adSize: adSize, ...)".',
        ),
        assert(
          controller != null || adId != null,
          'Provide at least a adId or controller',
        );

  @override
  State<EasyBannerAd> createState() => _EasyBannerAdState();
}

class _EasyBannerAdState extends State<EasyBannerAd>
    with WidgetsBindingObserver {
  late BannerAdController controller;

  bool get isShow =>
      controller.status.isLoaded ||
      controller.status.isPaid ||
      controller.status.isOpened ||
      controller.status.isClosed;

  bool get isCollapsible {
    bool isCollapsible = false;
    if (widget.controller != null) {
      isCollapsible = controller.isCollapsible;
    } else {
      isCollapsible = widget.isCollapsible ?? false;
    }
    return isCollapsible;
  }

  bool pausedApp = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initAd();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EasyBannerAd oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null) {
      if (oldWidget.controller!.controllerId !=
          widget.controller!.controllerId) {
        controller = widget.controller!;
      }
    } else {
      if (oldWidget.adId != widget.adId) {
        controller = BannerAdController(
          adId: widget.adId!,
          adSize: widget.adSize,
          lowId: widget.lowId,
          isCollapsible: widget.isCollapsible ?? false,
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!(EasyAds.instance.appLifecycleReactor?.isExcludeScreen ?? false)) {
      if (!EasyAds.instance.isFullscreenAdShowing) {
        if (isCollapsible) {
          pausedApp = state == AppLifecycleState.paused;
          if (pausedApp) {
            controller.disposeAd();
          }
        }
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if (!isCollapsible) {
      return buildBannerAd();
    }
    return StreamBuilder<bool>(
      initialData: true,
      stream: CollapseBannerAdStream.instance.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            if (controller.status.isInit) {
              controller.load();
            }
            return buildBannerAd();
          }
        }
        controller.disposeAd();
        return _buildLoading();
      },
    );
  }

  Widget buildBannerAd() {
    final ad = controller.ad;
    if (controller.status.isLoadFailed) {
      return const SizedBox();
    }
    if (ad == null && !controller.status.isLoaded) {
      return SizedBox(
        child: EasyAds.instance.hasInternet ? widget.loadingWidget : null,
      );
    }
    return Container(
      height: controller.adSize?.height.toDouble(),
      width: controller.adSize?.width.toDouble(),
      decoration: BoxDecoration(
        color: Colors.white,
        border: widget.borderBanner ??
            const Border(
              top: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
      ),
      child: Stack(
        children: [
          if (ad != null && isShow)
            StatefulBuilder(
              builder: (context, setState) => AdWidget(ad: ad),
            ),
          if (controller.status.isLoading)
            Container(
              key: ValueKey(controller.controllerId),
              color: Colors.white,
              child: widget.loadingWidget ?? const EasyLoadingAd(),
            ),
        ],
      ),
    );
  }

  SizedBox _buildLoading() {
    return SizedBox(
      child: EasyAds.instance.hasInternet ? widget.loadingWidget : null,
    );
  }

  Future<void> _initAd() async {
    if (widget.controller == null) {
      controller = BannerAdController(
        adId: widget.adId!,
        adSize: widget.adSize,
        lowId: widget.lowId,
        isCollapsible: widget.isCollapsible ?? false,
      );
      controller.load();
    } else {
      controller = widget.controller!;
    }
    if (!EasyAds.instance.hasInternet || pausedApp) {
      return;
    }
    controller.stream.listen((event) {
      if (mounted && isShow) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }
}
