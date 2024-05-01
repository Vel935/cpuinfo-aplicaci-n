import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpuinfo_application/models/cpus.dart';
import 'package:flutter/foundation.dart';

class CpuProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'processors';

  Future getProcessors() async {
    QuerySnapshot snapshot = await db.collection(collection).get();
    print(snapshot.docs.length);
    for (var doc in snapshot.docs) {
      print(doc.id);
      print(doc.data() as Map<String, dynamic>);
    }
    return snapshot.docs;
  }
}
