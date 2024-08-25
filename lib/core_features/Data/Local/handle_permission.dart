import 'package:permission_handler/permission_handler.dart';

class PermissionHandle {
  Future<bool> isGranted() async {
    Permission storagePermission = Permission.storage;
    bool granted = await storagePermission.isGranted;
    return granted;
  }
}
