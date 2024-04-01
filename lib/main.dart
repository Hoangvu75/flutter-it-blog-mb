import 'dart:io';

import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/firebase/firebase_options.dart';
import 'core/firebase/google_ad_id_manager.dart';
import 'generated/assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await EasyAds.instance.initialize(
    adIdManager,
    Image.asset(Assets.imagesAppIcon),
    unityTestMode: true,
    adMobAdRequest: const AdRequest(),
    admobConfiguration: RequestConfiguration(testDeviceIds: []),
    fbTestingId: '73f92d66-f8f6-4978-999f-b5e0dd62275a',
    fbiOSAdvertiserTrackingEnabled: true,
  );
  await EasyAds.instance.initAdmob(
    appOpenAdUnitId: Platform.isAndroid
        ? "ca-app-pub-3940256099942544/9257395921"
        : "ca-app-pub-3940256099942544/5575463023",
  );
  runApp(const ProviderScope(child: App()));
}