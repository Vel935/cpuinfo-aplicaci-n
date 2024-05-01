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
}
