class AppBarNotifier {
  bool _isUnchecked = false;
  bool _isOnlyFav = false;

  bool get isUnchecked => _isUnchecked;
  bool get isOnlyFav => _isOnlyFav;

  void setUnchecked() {
    _isUnchecked = !_isUnchecked;
  }

  void setOnlyFav() {
    _isOnlyFav = !_isOnlyFav;
  }
}
