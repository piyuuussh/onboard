import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  var _langCode = 0;

  dynamic get langCode => _langCode;

  void setLangCode(dynamic value) {
    _langCode = value;
    notifyListeners();
  }
}
