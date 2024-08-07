import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/upload_file/data/upload_pdf.dart';

class UploadProvider extends ChangeNotifier {
  double _currentProgress = 0;

  double get progress => _currentProgress;

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
        print(_currentProgress);
        notifyListeners();
      },
    );
    notifyListeners();
  }
}
