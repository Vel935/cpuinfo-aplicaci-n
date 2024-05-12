import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CpuProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'processors';

  Future<String> createCPU(Map<String, dynamic> cpu) async {
    notifyListeners();
    var defaultId = await db.collection(collection).add(cpu);
    notifyListeners();
    return 'CPU added with default ID: $defaultId';
  }

  // Metodos usados para la lista de procesadores:

  Future getProcessors() async {
    QuerySnapshot snapshot = await db.collection(collection).get();
    print(snapshot.docs.length);
    for (var doc in snapshot.docs) {
      print(doc.id);
      print(doc.data() as Map<String, dynamic>);
    }
    return snapshot.docs;
  }

  Future<List<String>> getProcessorsFamilies() async {
    QuerySnapshot snapshot = await db.collection(collection).get();
    Set<String> families = {}; // Cambio a un conjunto en lugar de una lista
    for (var doc in snapshot.docs) {
      // Convertir el resultado de doc.data() a Map<String, dynamic>
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        // Obtener directamente el valor del campo "familia"
        String? family =
            data["family"]; // Asumiendo que el nombre del campo es "familia"

        if (family != null) {
          families.add(family);
        }
      }
    }
    return families
        .toList(); // Convertir el conjunto a una lista antes de retornarlo
  }

  modifyProcessorAndId(
      String id, String newId, Map<String, dynamic> cpu) async {
    deleteProcessor(id);
    await db.collection(collection).doc(newId).set(cpu);
    notifyListeners();
  }

  deleteProcessor(String id) async {
    await db.collection(collection).doc(id).delete();
    notifyListeners();
  }

  deactivateProcessor(String id) async {
    await db.collection(collection).doc(id).update({'visible': false});
    notifyListeners();
  }

  modifyProcessor(String id, Map<String, dynamic> cpu) async {
    await db.collection(collection).doc(id).update(cpu);
    notifyListeners();
  }
}
