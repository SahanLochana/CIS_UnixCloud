import 'package:cloud_firestore/cloud_firestore.dart';

class WriteOnDB {
  String reoderCato(String category) {
    if (category == "notes") {
      return "Notes";
    } else {
      return "Slides";
    }
  }

  Future<void> writeOnDB(
      String moduleId, String category, String fileName, String url) async {
    // doc data
    Map<String, dynamic> docData = {"fileName": fileName, "url": url};

    String reodercato = reoderCato(category);

    // ref to db
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;

      String collectionPath =
          "/modules/${moduleId.toUpperCase()}/${reodercato}";

      // ref to category collection
      CollectionReference categoryCollectionRef = db.collection(collectionPath);

      // ref to doc
      DocumentReference docRef = categoryCollectionRef.doc(fileName);

      // save data
      await docRef.set(docData);
    } catch (e) {
      print(e.toString());
    }
  }
}
