class GlobalUser {
  static final GlobalUser _instance = GlobalUser._internal();

  String userId = '';

  factory GlobalUser() {
    return _instance;
  }

  GlobalUser._internal();
}
