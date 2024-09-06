import 'dart:io';

import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CachingPdf extends ToastMassege {
  // get file path
  Future<String> pdfPath(String pdfName) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    String path = "${internalPath.path}/$pdfName";
    return path;
  }

  // check alreday available
  Future<bool> isAvailable(String pdfName) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    File file = File("${internalPath.path}/$pdfName");
    return await file.exists();
  }

  // download function
  Future<String?> cachePdf(
      BuildContext context, String pdfName, String pathInstorage) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    File saveFile = File("${internalPath.path}/$pdfName");
    await saveFile.create(recursive: true);
    // storage ref
    final storageRef = FirebaseStorage.instance.ref();

    // path ref for download file
    final pathRef = storageRef.child(pathInstorage);
    try {
      final downloadtask = await pathRef.writeToFile(saveFile);
      if (downloadtask.state == TaskState.success) {
        return saveFile.path;
      } else if (downloadtask.state == TaskState.error) {}
    } catch (e) {
      return null;
    }
    return null;
  }

  // function manager
}
