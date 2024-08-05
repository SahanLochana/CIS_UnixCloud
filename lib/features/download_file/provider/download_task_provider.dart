import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/download_file/data/remote/file_download.dart';

class DownloadTaskProvider extends ChangeNotifier {
  // instance of FileDownload
  FileDownload fileDownload = FileDownload();
  // progress veriable
  double cureentProgress = 0.0;

  // task state veriable
  // 0 = running, 1 = pouse, -1 = cancel
  late int stateCode;

  // progress updater
  void updateProgress() {
    fileDownload.downloadFile("", "", (progress) {
      cureentProgress = progress;
    });
  }

  void updatestate() {}
}
