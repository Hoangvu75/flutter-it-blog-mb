import 'dart:async';

import 'package:logger/logger.dart';

import '../../easy_ads_flutter.dart';

typedef AdStatusCallback = void Function(AdStatus status);

abstract class AdController {
  AdController({
    required this.adId,
    this.lowId,
  });

  final String adId;
  final String? lowId;

  final StreamController<AdStatus> _streamController =
      StreamController.broadcast();

  Stream<AdStatus> get stream => _streamController.stream;
  AdStatus _status = AdStatus.init;

  AdStatus get status => _status;

  FutureOr<void> load();

  late final logger = Logger();

  void reload() {}

  void dispose() {
    _streamController.close();
  }

  void addEvent(AdStatus status, {LoadAdError? error}) {
    _status = status;
    if (error != null) {
      logger.e(error);
    }
    _streamController.sink.add(status);
  }
}
