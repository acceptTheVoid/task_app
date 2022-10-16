import 'package:flutter/material.dart';

class AppBarNotifier extends ChangeNotifier {
  bool _isUnchecked = false;
  bool _isOnlyFav = false;

  bool get isUnchecked => _isUnchecked;
  bool get isOnlyFav => _isOnlyFav;

  void setUnchecked() {
    _isUnchecked = !_isUnchecked;
    notifyListeners();
  }

  void setOnlyFav() {
    _isOnlyFav = !_isOnlyFav;
    notifyListeners();
  }
}
