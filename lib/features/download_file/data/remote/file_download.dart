// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

class FileDownload {
  Future<void> cancalTask(DownloadTask? task) async {
    if (task != null) {
      await task.cancel();
    }
  }

  Future<bool> checkFileExists(String filename) async {
    File file = File("/storage/emulated/0/Download/Uni materials/$filename");
    return await file.exists();
  }

  Future<void> downloadFile(
    BuildContext context,
    String pathInstorage,
    String fileName,
    Function(double progress) onProgress,
    Function(int stateCode) onChangeStateCode,
    Function(DownloadTask task) ontask,
  ) async {
    ToastMassege msg = ToastMassege();
    // path to download folder
    final Directory downloadDir =
        Directory("/storage/emulated/0/Download/Uni materials");

    // full path
    final filePath = "${downloadDir.path}/$fileName";

    // File
    File saveFile = File(filePath);
    if (await checkFileExists(fileName)) {
      ToastMassege msg = ToastMassege();
      msg.toastMsg(
          context, "File Alredy exists", fileName, ToastificationType.info);
      return;
    }

    await saveFile.create(recursive: true);
    // storage ref
    final storageRef = FirebaseStorage.instance.ref();

    // path ref for download file
    final pathRef = storageRef.child(pathInstorage);

    try {
      // download file
      final downloadtask = pathRef.writeToFile(saveFile);
      await ontask(downloadtask);

      // Listen for progress
      downloadtask.snapshotEvents.listen(cancelOnError: true,
          (tackSnapshot) async {
        switch (tackSnapshot.state) {
          case TaskState.running:
            double progress = (downloadtask.snapshot.bytesTransferred /
                downloadtask.snapshot.totalBytes);
            onProgress(progress);
            onChangeStateCode(1);
            break;

          case TaskState.paused:
            onChangeStateCode(-1);
            break;

          case TaskState.canceled:
            onChangeStateCode(2);
            break;

          case TaskState.error:
            onChangeStateCode(3);
            break;
          case TaskState.success:
            msg.toastMsg(context, "Sucsessfuly Downloaded", fileName,
                ToastificationType.success);
            onChangeStateCode(5);
            break;
        }
      });
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}
