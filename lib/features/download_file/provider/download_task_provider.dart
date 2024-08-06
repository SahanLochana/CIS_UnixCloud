import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/download_file/data/remote/file_download.dart';

class DownloadTaskProvider extends ChangeNotifier {
  // instance of FileDownload
  FileDownload fileDownload = FileDownload();
  // progress veriable
  Map<String, double> _downloadTasks = {};
  Map<String, int> _downloadTaskFlags = {};

  Map<String, double> get downloadTasks => _downloadTasks;
  Map<String, int> get downloadTasksFlags => _downloadTaskFlags;

  // task state veriable
  // 0 = running, 1 = pouse, -1 = cancel
  late int stateCode;

  // progress updater
  void updateProgress(BuildContext context, String cloudPath, String fileName) {
    fileDownload.downloadFile(
      context,
      cloudPath,
      fileName,
      (progress) {
        _downloadTasks[fileName] = progress;
        print(progress);
        notifyListeners();
      },
      (stateCode) {
        _downloadTaskFlags[fileName] = stateCode;
        notifyListeners();
        if (_downloadTaskFlags[fileName] == 5) {
          _downloadTaskFlags[fileName] = 0;
          _downloadTasks[fileName] = 0.0;
        }
      },
    );
  }
}
