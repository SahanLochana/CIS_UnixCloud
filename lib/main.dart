import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';
import 'package:student_manegment_app/Routes/routes_config.dart';
import 'package:student_manegment_app/features/download_file/provider/download_task_provider.dart';
import 'package:student_manegment_app/firebase_options.dart';
import 'package:student_manegment_app/core_features/presantation/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatusProvider>(
          create: (context) => StatusProvider(),
        ),
        ChangeNotifierProvider<DownloadTaskProvider>(
          create: (context) => DownloadTaskProvider(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: MyRouteConfig().routers,
        theme: myTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
