import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Widgets/category_row_widget.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Widgets/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  // save user id to provider
  void loadData() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Provider.of<StatusProvider>(context, listen: false)
          .checkUserIsAdmin(currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    // get current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        return Scaffold(
          // Drawer
          drawer: const MyDrawer(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            // backgroundColor: const Color(0xFF3D5A80),
            title: Text(
              currentUser!.uid.toString(),
              style: const TextStyle(color: Colors.white, fontFamily: "dmsans"),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Catogory tile holdiing container
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF3D5A80),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Center(child: CategoryRowWidget()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  // TODO : wrap with column and create feture for show annoucements
                  "Annoucement",
                  style: TextStyle(
                    fontFamily: "dmsans",
                    color: Colors.grey.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
