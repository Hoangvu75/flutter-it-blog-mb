import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

import 'core/config/get_it.dart';
import 'infrastructure/routing/app_pages.dart';

class App extends MaterialApp {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false
      ..animationStyle = EasyLoadingAnimationStyle.opacity;
    configureDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppPages.router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        ),
      ),
    );
  }
}
