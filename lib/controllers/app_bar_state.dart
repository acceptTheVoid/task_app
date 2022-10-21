class AppBarState {
  bool _showOnlyChecked = false;
  bool _showOnlyFavorite = false;

  bool get showOnlyChecked => _showOnlyChecked;
  bool get showOnlyFavorite => _showOnlyFavorite;

  void toggleOnlyChecked() {
    _showOnlyChecked = !_showOnlyChecked;
  }

  void toggleOnlyFavorite() {
    _showOnlyFavorite = !_showOnlyFavorite;
  }
}
