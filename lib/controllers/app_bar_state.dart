import 'package:flutter/foundation.dart';

class AppBarState extends ChangeNotifier {
  bool _showOnlyCompleted = false;
  bool _showOnlyFavorite = false;

  bool get showOnlyCompleted => _showOnlyCompleted;
  bool get showOnlyFavorite => _showOnlyFavorite;

  void toggleOnlyChecked() {
    _showOnlyCompleted = !_showOnlyCompleted;
    notifyListeners();
  }

  void toggleOnlyFavorite() {
    _showOnlyFavorite = !_showOnlyFavorite;
    notifyListeners();
  }
}
