import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteOnDB {
  String reorderCato(String category) {
    switch (category) {
      case "notes":
        return "Notes";
      case "slides":
        return "Slides";
      case "records":
        return "Records";
      default:
        return "error";
    }
  }

  Future<void> writeOnDB(String moduleId, String category, String fileName,
      String url, String semName) async {
    // doc data
    Map<String, dynamic> docData = {"fileName": fileName, "url": url};

    String reorderCatoName = reorderCato(category);

    // ref to db
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;

      String collectionPath =
          "semesters/${semName.toLowerCase()}/modules/${moduleId.toUpperCase()}/$reorderCatoName";

      // ref to category collection
      CollectionReference categoryCollectionRef = db.collection(collectionPath);

      // ref to doc
      DocumentReference docRef = categoryCollectionRef.doc(fileName);

      // save data
      await docRef.set(docData);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
