import 'package:CIS_UnixCloud/Routes/routes_config.dart';
import 'package:CIS_UnixCloud/core_features/Provider/cache_provider.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/theme/theme_data.dart';
import 'package:CIS_UnixCloud/features/app_settings/local/store_data.dart';
import 'package:CIS_UnixCloud/features/download_file/provider/download_task_provider.dart';
import 'package:CIS_UnixCloud/features/upload_file/provider/upload_provider.dart';
import 'package:CIS_UnixCloud/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StoreData storeData = StoreData();
  if (await storeData.getCacheStatus() == null) {
    storeData.storeCacheStatus(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<StatusProvider>(
            create: (context) => StatusProvider(),
          ),
          ChangeNotifierProvider<DownloadTaskProvider>(
            create: (context) => DownloadTaskProvider(),
          ),
          ChangeNotifierProvider<UploadProvider>(
            create: (context) => UploadProvider(),
          ),
          ChangeNotifierProvider<CacheProvider>(
            create: (context) => CacheProvider(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: MyRouteConfig().routers,
          theme: myTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
