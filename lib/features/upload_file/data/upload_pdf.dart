import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/toast_massege/toast_massege.dart';
import 'package:student_manegment_app/features/upload_file/data/write_on_db.dart';
import 'package:toastification/toastification.dart';

class UploadFile {
  // cancel task
  void cancalTask(UploadTask task) {
    task.cancel();
  }

  //upload task
  Future<void> uploadFile(
    BuildContext context,
    String moduleId,
    String category,
    FilePickerResult pdfFile,
    Function(double) onProgress,
  ) async {
    // storage ref
    try {
      ToastMassege msg = ToastMassege();

      final storageRef = FirebaseStorage.instance.ref();

      File file = File(pdfFile.files.single.path!);

      // storage path to save
      Reference refToFile = storageRef.child(
          "modules/semester 01/$moduleId/$category/${pdfFile.names.single!}");

      try {
        await refToFile.getMetadata();
        return;
      } catch (e) {}

      // upload
      final uploadTask = refToFile.putFile(file);

      // listen to task state
      await uploadTask.snapshotEvents.listen(
        cancelOnError: true,
        (TaskSnapshot tasksnapshot) async {
          WriteOnDB writeOnDB = WriteOnDB();
          switch (tasksnapshot.state) {
            case TaskState.running:
              final progress =
                  tasksnapshot.bytesTransferred / tasksnapshot.totalBytes;
              onProgress(progress);
              break;
            case TaskState.canceled:
              print("Canceled");
              onProgress(0.0);
              break;

            case TaskState.paused:
              print("Poused");
              break;

            case TaskState.success:
              print("success");
              msg.toastMsg(context, "File Uploaded !", pdfFile.names.single!,
                  ToastificationType.success);
              String url = await refToFile.getDownloadURL();
              if (url == null) {
                print("url not found");
                return;
              }
              await writeOnDB.writeOnDB(
                  moduleId, category, pdfFile.names.single!, url);

              onProgress(0.0);
              break;
            case TaskState.error:
              print("error");
              onProgress(0.0);
              break;
            default:
              print("some error");
              break;
          }
        },
      );

      // get download url
    } on FirebaseException catch (e) {
      // handle error
      print("error - ${e.toString()}");
    } catch (error) {
      print(error.toString());
    }
  }
}
