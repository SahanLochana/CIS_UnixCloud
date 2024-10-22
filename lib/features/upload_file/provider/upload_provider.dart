import 'package:CIS_UnixCloud/core_features/Data/Models/module_model.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/firebase_services.dart';
import 'package:CIS_UnixCloud/features/upload_file/data/upload_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  double _currentProgress = 0;
  List<DropdownMenuItem> modules = [];

  double get progress => _currentProgress;
  List<DropdownMenuItem> get moduleItems => modules;

  void progressListener(
    BuildContext context,
    String moduleId,
    String category,
    FilePickerResult pdfFile,
  ) {
    UploadFile uploadClass = UploadFile();
    uploadClass.uploadFile(
      context,
      moduleId,
      category,
      pdfFile,
      (progress) {
        _currentProgress = progress;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<List<DropdownMenuItem<dynamic>>> fetchModules() async {
    FirebaseServices firebaseSer = FirebaseServices();
    List<ModuleModel> moduleModals = await firebaseSer.getModules();
    modules = moduleModals.map((module) {
      return DropdownMenuItem<String>(
        value: module.moduleId.toLowerCase(),
        child: Text(module.moduleId),
      );
    }).toList();
    return modules;
  }
}
