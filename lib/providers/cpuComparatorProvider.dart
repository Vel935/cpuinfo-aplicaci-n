import 'package:flutter/material.dart';

class CpuComparatorProvider extends ChangeNotifier {
  bool _comparing = false;
  String _actualPage = "";

  bool get comparing => _comparing;
  String get actualPage => _actualPage;

  void updateState(bool value) {
    _comparing = value;
    notifyListeners(); // Notifica a los widgets suscritos sobre el cambio
  }

  void updateActualPage(String page) {
    _actualPage = page;
    notifyListeners(); // Notifica a los widgets suscritos sobre el cambio
  }
}
