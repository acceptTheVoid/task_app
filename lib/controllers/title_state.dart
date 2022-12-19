import 'package:flutter/material.dart';

class TitleState extends ChangeNotifier {
  String _title = 'Средняя Мораль';

  String get title => _title;

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}
