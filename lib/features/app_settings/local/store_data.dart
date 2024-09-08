import 'package:shared_preferences/shared_preferences.dart';

class StoreData {
  Future<void> storeCacheStatus(bool isEnabled) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("caching", isEnabled);
  }

  Future<bool?> getCacheStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? cacheStatus = prefs.getBool("caching");
    return cacheStatus;
  }
}
