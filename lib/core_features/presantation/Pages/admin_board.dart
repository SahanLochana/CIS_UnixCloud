import 'package:CIS_UnixCloud/features/upload_file/presentation/components/admin_page_tile.dart';
import 'package:flutter/material.dart';

class AdminBoard extends StatelessWidget {
  final String uid;
  const AdminBoard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "admin board",
          style: TextStyle(fontFamily: "dmsans", color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            AdminPageTile(),
          ],
        ),
      ),
    );
  }
}
