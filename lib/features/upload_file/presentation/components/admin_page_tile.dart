import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/upload_file/presentation/poupip_window.dart';

class AdminPageTile extends StatelessWidget {
  const AdminPageTile({super.key});

  @override
  Widget build(BuildContext context) {
    String _moduleId;
    String _category;
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => PopUpWindow(
            onChangedCategory: (category) {
              _category = category!;
              print(_category);
            },
            onChangedModuleId: (moduleId) {
              _moduleId = moduleId!;
              print(_moduleId);
            },
          ),
        );
      },
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets\\icons\\upload.png",
              height: 40,
              width: 40,
              color: const Color(0xFF3D5A80),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Upload File",
              style: TextStyle(
                color: const Color(0xFF3D5A80),
                fontWeight: FontWeight.bold,
                fontFamily: "dmsans",
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
