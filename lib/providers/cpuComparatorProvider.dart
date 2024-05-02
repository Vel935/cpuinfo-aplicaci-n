import 'package:flutter/material.dart';

class CpuComparatorProvider extends ChangeNotifier {
  bool _comparing = false;

  bool get comparing => _comparing;

  void actualizarComparando(bool value) {
    _comparing = value;
    notifyListeners(); // Notifica a los widgets suscritos sobre el cambio
  }
}
