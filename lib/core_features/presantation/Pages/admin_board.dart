import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/upload_file/presentation/components/admin_page_tile.dart';

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
