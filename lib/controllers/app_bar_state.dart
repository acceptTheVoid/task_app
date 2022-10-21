import 'package:flutter/foundation.dart';

class AppBarState extends ChangeNotifier {
  bool _showOnlyChecked = false;
  bool _showOnlyFavorite = false;

  bool get showOnlyChecked => _showOnlyChecked;
  bool get showOnlyFavorite => _showOnlyFavorite;

  void toggleOnlyChecked() {
    _showOnlyChecked = !_showOnlyChecked;
    notifyListeners();
  }

  void toggleOnlyFavorite() {
    _showOnlyFavorite = !_showOnlyFavorite;
    notifyListeners();
  }
}
