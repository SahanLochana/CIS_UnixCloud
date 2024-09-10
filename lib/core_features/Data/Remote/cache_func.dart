import 'dart:io';

import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CachingPdf extends ToastMassege {
  // get file path
  Future<String> pdfPath(String pdfName) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    String path = "${internalPath.path}/PdfCache/$pdfName";
    return path;
  }

  // check alreday available
  Future<bool> isAvailable(String pdfName) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    File file = File("${internalPath.path}/PdfCache/$pdfName");
    return await file.exists();
  }

  // download function
  Future<String?> cachePdf(
      BuildContext context, String pdfName, String pathInstorage) async {
    Directory internalPath = await getApplicationDocumentsDirectory();
    File saveFile = File("${internalPath.path}/PdfCache/$pdfName");
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

  // get cache size
  Future<int> getFolderSize() async {
    int sizeInByte = 0;
    Directory internalPath = await getApplicationDocumentsDirectory();
    Directory dir = Directory("${internalPath.path}/PdfCache");

    try {
      if (await dir.exists()) {
        // List all files and directories recursively
        await for (FileSystemEntity entity
            in dir.list(recursive: true, followLinks: false)) {
          if (entity is File) {
            // Add the file size to the total
            sizeInByte += await entity.length();
          }
        }
        (sizeInByte / (1024 * 1024)).toStringAsFixed(2);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return sizeInByte;
  }

  // clear cache
  Future<void> deleteCacheFolder() async {
    try {
      // Get the cache directory
      Directory internalPath = await getApplicationDocumentsDirectory();
      Directory dir = Directory("${internalPath.path}/PdfCache");

      // Check if the directory exists
      if (await dir.exists()) {
        // Delete the directory and all its contents
        await dir.delete(recursive: true);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
