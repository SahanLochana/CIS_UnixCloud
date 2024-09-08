import 'package:CIS_UnixCloud/core_features/Data/Remote/cache_func.dart';
import 'package:CIS_UnixCloud/features/app_settings/local/store_data.dart';
import 'package:flutter/material.dart';

class CacheProvider extends ChangeNotifier {
  int _cacheSizeInByte = 0;
  bool _isCacheEnabled = true;
  CachingPdf cachePdf = CachingPdf();
  StoreData prefData = StoreData();

  int get sizeInByte => _cacheSizeInByte;
  bool get isEnabled => _isCacheEnabled;

  // get file size
  void getFileSize() async {
    _cacheSizeInByte = await cachePdf.getFolderSize();
    notifyListeners();
  }

  // get status
  void updateStatus() async {
    bool? status = await prefData.getCacheStatus();

    if (status != null) {
      _isCacheEnabled = status;
    }
    notifyListeners();
  }

  // update status in pref
  void updatePref(bool isEnabled) async {
    await prefData.storeCacheStatus(isEnabled);
    notifyListeners();
  }

  // delete cache
  void deleteCache() {
    cachePdf.deleteCacheFolder();
    notifyListeners();
  }
}
