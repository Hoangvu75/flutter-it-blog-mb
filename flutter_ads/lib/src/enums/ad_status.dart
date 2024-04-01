enum AdStatus {
  init,
  loading,
  loaded,
  loadFailed,
  shown,
  closed,
  opened,
  paid,
  dismiss,
}

extension AdStatusExtension on AdStatus {
  bool get isInit => this == AdStatus.init;

  bool get isLoading => this == AdStatus.loading;

  bool get isLoaded => this == AdStatus.loaded;

  bool get isLoadFailed => this == AdStatus.loadFailed;

  bool get isShown => this == AdStatus.shown;

  bool get isClosed => this == AdStatus.closed;

  bool get isOpened => this == AdStatus.opened;

  bool get isPaid => this == AdStatus.paid;

  bool get isDismiss => this == AdStatus.dismiss;
}
