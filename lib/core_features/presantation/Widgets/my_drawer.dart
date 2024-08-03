import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';
import 'package:student_manegment_app/core_features/presantation/Components/drawer_tile.dart';

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
                    const DrawerHeader(child: Center(child: Text("U S E R"))),
                    const DrawerTile(tileTitle: "N o t e s"),
                    const DrawerTile(tileTitle: "S l i d e s"),
                    const DrawerTile(tileTitle: "R e s o u c e s"),
                    if (value.isUserAdmin)
                      const DrawerTile(tileTitle: "A d m i n")
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    ListTile(
                      onTap: () async {
                        // clear before logout
                        value.resetRole();

                        // logout
                        await FirebaseAuth.instance.signOut();
                      },
                      leading: const Icon(Icons.book_rounded),
                      title: const Text("LogOut"),
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
