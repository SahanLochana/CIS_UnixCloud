import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

class PermissionHandle {
  Future<void> handlePermission(
      BuildContext context, Function downloadFunc) async {
    // Check the current permission status
    PermissionStatus status = await Permission.storage.status;

    // Handle the status accordingly
    if (status.isDenied) {
      // Request permission
      status = await Permission.storage.request();
      if (status.isGranted) {
        // Permission granted, proceed with download
        await downloadFunc();
      } else {
        // Permission denied, do nothing or handle it
        print("Permission denied");
        ToastMassege().toastMsg(
            context,
            "Permission Denied",
            "Storage permission need to download pdfs",
            ToastificationType.warning);
      }
      return;
    } else if (status.isPermanentlyDenied) {
      // If the permission is permanently denied, open app settings
      await openAppSettings();
      return;
    } else if (status.isGranted) {
      // If permission is already granted, proceed with the download
      await downloadFunc();
    }
  }
}
