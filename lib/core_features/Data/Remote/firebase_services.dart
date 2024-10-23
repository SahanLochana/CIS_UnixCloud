import 'package:CIS_UnixCloud/core_features/Data/Models/doc_modal.dart';
import 'package:CIS_UnixCloud/core_features/Data/Models/module_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  var db = FirebaseFirestore.instance;

  // get modules
  Future<List<ModuleModel>> getModules() async {
    List<ModuleModel> modulesList = [];
    await db.collection("modules").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map docData = docSnapshot.data();
          if (docData.isEmpty) {
            throw "Data unavailable";
          }
          ModuleModel moduleModel = toModuleModel(docData);
          modulesList.add(moduleModel);
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return modulesList;
  }

  Future<List<String>> getSems() async {
    List<String> semList = [];
    await db.collection("semesters").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print(docSnapshot.data().toString());
          Map docData = docSnapshot.data();
          if (docData.isEmpty) {
            throw "Data unavailable";
          }

          semList.add(docData["semName"]);
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return semList;
  }

  // Snapshot data convert to moduleModel
  ModuleModel toModuleModel(Map moduleData) {
    String moduleName = moduleData["moduleName"];
    String moduleId = moduleData["moduleId"];
    return ModuleModel(moduleName: moduleName, moduleId: moduleId);
  }

  // get document data
  Future<List<DocDataModal>> getdocs(String moduleId, String category) async {
    List<DocDataModal> docsList = [];
    await db.collection("modules/$moduleId/$category").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map docData = docSnapshot.data();
          if (docData.isEmpty) {
            throw "Files Not Found";
          }
          DocDataModal docDataModel = toDocDataModal(docData);
          docsList.add(docDataModel);
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return docsList;
  }

  // Snapshot data conver to DocDataModel
  DocDataModal toDocDataModal(Map docData) {
    String fileName = docData["fileName"];
    String url = docData["url"];
    return DocDataModal(fileName: fileName, url: url);
  }

  // get user's role
  Future<bool> checkUserRole(String uId) async {
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('users').doc(uId);

    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      return data["isAdmin"];
    } else {
      throw "something error";
    }
  }
}
