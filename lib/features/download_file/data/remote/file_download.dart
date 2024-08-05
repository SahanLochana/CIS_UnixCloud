import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FileDownload {
  Future<void> downloadFile(String pathInstorage, String fileName,
      Function(double progress) onProgress) async {
    // path to download folder
    final Directory? downloadDir = await getDownloadsDirectory();

    // full path
    final filePath = "${downloadDir!.path}/Uni materials/$fileName";

    // File
    File saveFile = File(filePath);
    await saveFile.create(recursive: true);
    // storage ref
    final storageRef = FirebaseStorage.instance.ref();

    // path ref for download file
    final pathRef = storageRef.child(pathInstorage);

    try {
      // download file
      final downloadtask = pathRef.writeToFile(saveFile);

      // Listen for progress
      downloadtask.snapshotEvents.listen((tackSnapshot) async {
        switch (tackSnapshot.state) {
          case TaskState.running:
            double progress = (downloadtask.snapshot.bytesTransferred /
                downloadtask.snapshot.totalBytes);
            onProgress(progress);
            break;

          case TaskState.paused:
            print("poused");
            break;

          case TaskState.canceled:
            print("canceled");
            break;

          case TaskState.error:
            print("error");
            break;
          case TaskState.success:
            print("success");
            print(saveFile.path);
            break;
        }
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
