import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';

class DrawerTile extends StatelessWidget {
  final String tileTitle;
  const DrawerTile({super.key, required this.tileTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).pushNamed(RouterConstants.adminBoardRouteName,
            pathParameters: {"uid": "22CIS0334"});
      },

      leading: const Icon(Icons.book_rounded), //TODO : change icon
      title: Text(tileTitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
