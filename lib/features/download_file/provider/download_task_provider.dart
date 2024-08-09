import 'package:CIS_UnixCloud/features/download_file/data/remote/file_download.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DownloadTaskProvider extends ChangeNotifier {
  // instance of FileDownload
  FileDownload fileDownload = FileDownload();
  // progress veriable
  Map<String, double> _downloadTasks = {};
  Map<String, int> _downloadTaskFlags = {};
  Map<String, DownloadTask> _downloadTask = {};

  Map<String, double> get downloadTasks => _downloadTasks;
  Map<String, int> get downloadTasksFlags => _downloadTaskFlags;
  Map<String, DownloadTask> get downloadTask => _downloadTask;

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
        notifyListeners();
      },
      (stateCode) {
        print(stateCode.toString());
        _downloadTaskFlags[fileName] = stateCode;
        notifyListeners();
        if (_downloadTaskFlags[fileName] == 5) {
          _downloadTaskFlags[fileName] = 0;
          _downloadTasks[fileName] = 0.0;
        }
      },
      (task) {
        _downloadTask[fileName] = task;
        notifyListeners();
      },
    );
  }
}
