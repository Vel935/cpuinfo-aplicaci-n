import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CpuComparatorProvider extends ChangeNotifier {
  bool _comparing = false;
  String palabra = "SANCOCHO";
  bool chica = false;

  Map<String, dynamic>? _data1;
  Map<String, dynamic>? _data2;

  String _lastButtonPressed =
      "sabor"; // Variable para almacenar el último botón presionado

  bool get comparing => _comparing;

  Map<String, dynamic>? get data1 => _data1;
  Map<String, dynamic>? get data2 => _data2;

  String get lastButtonPressed =>
      _lastButtonPressed; // Getter para obtener el último botón presionado
  bool get getpalabra => chica;

  void updateState(bool value) {
    _comparing = value;
    notifyListeners(); // Notifica a los widgets suscritos sobre el cambio
  }

  void update(bool value) {
    chica = value;
    notifyListeners(); // Notifica a los widgets suscritos sobre el cambio
  }

  void setData1(DocumentSnapshot snapshot) {
    _data1 = snapshot.data() as Map<String, dynamic>;
    notifyListeners();
  }

  void setData2(DocumentSnapshot snapshot) {
    _data2 = snapshot.data() as Map<String, dynamic>;
    notifyListeners();
  }

  void setLastButtonPressed(String value) {
    _lastButtonPressed =
        value; // Método para actualizar el último botón presionado
    palabra = value;
    notifyListeners();
  }
}
