import 'package:CIS_UnixCloud/core_features/Data/Models/module_model.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/firebase_services.dart';
import 'package:CIS_UnixCloud/features/upload_file/data/upload_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  double _currentProgress = 0;

  double get progress => _currentProgress;
  // List<DropdownMenuItem> get moduleItems => modules;

  void progressListener(
    BuildContext context,
    String moduleId,
    String category,
    String semName,
    FilePickerResult pdfFile,
  ) {
    UploadFile uploadClass = UploadFile();
    uploadClass.uploadFile(
      context,
      moduleId,
      category,
      semName,
      pdfFile,
      (progress) {
        _currentProgress = progress;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<Map<String, List<DropdownMenuItem>>> fetchModules(
      String semName) async {
    List<DropdownMenuItem> modules = [];
    List<DropdownMenuItem> sems = [];
    Map<String, List<DropdownMenuItem>> returndata = {};

    FirebaseServices firebaseSer = FirebaseServices();
    List<ModuleModel> moduleModals = await firebaseSer.getModules(semName);
    List<String> semesters = await firebaseSer.getSems();

    modules = moduleModals.map((module) {
      return DropdownMenuItem<String>(
        value: module.moduleId.toLowerCase(),
        child: Text(module.moduleId),
      );
    }).toList();

    sems = semesters.map((sem) {
      return DropdownMenuItem<String>(
        value: sem.toLowerCase(),
        child: Text(sem),
      );
    }).toList();

    returndata["modules"] = modules;
    returndata["sems"] = sems;
    return returndata;
  }
}
