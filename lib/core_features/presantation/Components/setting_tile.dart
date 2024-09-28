import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';

class SettingTile extends StatelessWidget {
  final String imagePath;
  final String tileTitle;
  const SettingTile(
      {super.key, required this.tileTitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) => ListTile(
        onTap: () {
          GoRouter.of(context).pushNamed(RouterConstants.settingPageRouteName);
        },
        leading: Image.asset(
          imagePath,
          height: 25,
          width: 25,
        ),
        title: Text(
          tileTitle,
          style: const TextStyle(
              fontFamily: "dmsans", fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
