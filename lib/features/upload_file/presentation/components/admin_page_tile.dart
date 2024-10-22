import 'package:CIS_UnixCloud/features/upload_file/presentation/upload_page.dart';
import 'package:CIS_UnixCloud/features/upload_file/provider/upload_provider.dart';
import 'package:flutter/material.dart';

class AdminPageTile extends StatelessWidget {
  const AdminPageTile({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String moduleId;
    // ignore: unused_local_variable
    String category;
    return ElevatedButton(
      onPressed: () {
        // UploadProvider uProvider = UploadProvider();
        // uProvider.fetchModules();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PopUpWindow(
                  onChangedModuleId: (moduleId) {
                    moduleId = moduleId!;
                  },
                  onChangedCategory: (category) {
                    category = category!;
                  },
                )));
        showDialog(
          context: context,
          builder: (context) => PopUpWindow(
            onChangedCategory: (category) {
              category = category!;
            },
            onChangedModuleId: (moduleId) {
              moduleId = moduleId!;
            },
          ),
        );
      },
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Upload File",
              style: TextStyle(
                color: Color(0xFF3D5A80),
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
