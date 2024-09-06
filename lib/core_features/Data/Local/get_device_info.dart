import 'package:device_info_plus/device_info_plus.dart';

class GetInfo {
  Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int sdkVer = androidInfo.version.sdkInt;
    return sdkVer;
  }
}
