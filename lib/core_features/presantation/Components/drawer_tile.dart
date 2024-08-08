import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';

class DrawerTile extends StatelessWidget {
  final String imagePath;
  final String tileTitle;
  final String type;
  const DrawerTile(
      {super.key,
      required this.tileTitle,
      required this.type,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) => ListTile(
        onTap: () {
          value.typeUpdater(type);
          GoRouter.of(context).pushNamed(RouterConstants.modulesRouteName);
        },

        leading: Image.asset(
          imagePath,
          height: 25,
          width: 25,
        ), //TODO : change icon
        title: Text(
          tileTitle,
          style: TextStyle(fontFamily: "dmsans", fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
