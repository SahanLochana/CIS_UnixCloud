import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/drawer_tile.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/setting_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        return Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // drower tiles

                    const DrawerHeader(child: Center(child: Text("U S E R"))),
                    const DrawerTile(
                      imagePath: "assets\\icons\\document.png",
                      tileTitle: "N o t e s",
                      type: "Notes",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DrawerTile(
                      imagePath: "assets\\icons\\slide.png",
                      tileTitle: "S l i d e s",
                      type: "Slides",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DrawerTile(
                      imagePath: "assets\\icons\\video.png",
                      tileTitle: "R e c o r d s",
                      type: "Records",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // show this only user is a admin
                    if (value.isUserAdmin)
                      ListTile(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                              RouterConstants.adminBoardRouteName,
                              pathParameters: {"uid": value.uid});
                        },
                        leading: Image.asset(
                          "assets\\icons\\admin.png",
                          height: 25,
                          width: 25,
                        ),
                        title: const Text(
                          'Admin Board',
                          style: TextStyle(
                              fontFamily: "dmsans",
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SettingTile(
                      imagePath: "assets\\icons\\video.png",
                      tileTitle: "S e t t i n g s",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    ListTile(
                      onTap: () async {
                        // clear before logout
                        //value.resetRole();

                        // logout
                        //await FirebaseAuth.instance.signOut();

                        // TODO remove after test
                        GoRouter.of(context).pushNamed(
                          RouterConstants.semestersPageRouteName,
                        );
                      },
                      leading: const Icon(Icons.book_rounded),
                      title: const Text(
                        "LogOut",
                        style: TextStyle(fontFamily: "dmsans"),
                      ),
                      trailing: const Icon(Icons.logout_rounded),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
