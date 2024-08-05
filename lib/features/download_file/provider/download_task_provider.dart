import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/download_file/data/remote/file_download.dart';

class DownloadTaskProvider extends ChangeNotifier {
  // instance of FileDownload
  FileDownload fileDownload = FileDownload();
  // progress veriable
  Map<String, double> _downloadTasks = {};

  Map<String, double> get downloadTasks => _downloadTasks;

  // task state veriable
  // 0 = running, 1 = pouse, -1 = cancel
  late int stateCode;

  // progress updater
  void updateProgress(String cloudPath, String fileName) {
    fileDownload.downloadFile(cloudPath, fileName, (progress) {
      _downloadTasks[fileName] = progress;
      print(downloadTasks[fileName].toString());
      print(progress);
      notifyListeners();
    });
  }

  void updatestate() {}
}
