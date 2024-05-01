import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CpuProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'processors';

  Future<String> createCPU(Map<String, dynamic> cpu) async {
    // Generate custom ID based on brand, family, and model
    String brand = cpu['brand'];
    String family = cpu['family'];
    String model = cpu['model'];
    String customId = '$brand $family $model';

    // Add custom ID to CPU data
    cpu['id'] = customId;

    // Add CPU to Firestore with custom ID
    await db.collection(collection).doc(customId).set(cpu);

    notifyListeners();

    return customId;
  }

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
}
