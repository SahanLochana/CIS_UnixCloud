import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:CIS_UnixCloud/features/upload_file/data/get_file.dart';
import 'package:CIS_UnixCloud/features/upload_file/presentation/components/popup_btn.dart';
import 'package:CIS_UnixCloud/features/upload_file/provider/upload_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class PopUpWindow extends StatefulWidget {
  final Function(String?) onChangedModuleId;
  final Function(String?) onChangedCategory;
  const PopUpWindow({
    super.key,
    required this.onChangedModuleId,
    required this.onChangedCategory,
  });

  @override
  State<PopUpWindow> createState() => _PopUpWindowState();
}

class _PopUpWindowState extends State<PopUpWindow> {
  String selectedModuleId = "is1101";
  String selectedCategory = "notes";
  String? filename;
  FilePickerResult? pickedFile;

  final TextStyle _style = TextStyle(
    fontFamily: "dmsans",
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(
      builder: (context, value, child) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Upload a file ...",
          style: TextStyle(
            fontFamily: "dmsans",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // category
            DropdownButton(
                borderRadius: BorderRadius.circular(10),
                style: _style,
                value: selectedCategory,
                items: [
                  DropdownMenuItem(value: "notes", child: Text("Notes")),
                  DropdownMenuItem(value: "slides", child: Text("Slides")),
                ],
                onChanged: (category) {
                  setState(() {
                    selectedCategory = category!;
                  });
                  widget.onChangedCategory(category);
                }),
            SizedBox(
              height: 20,
            ),
            // module ID
            DropdownButton(
                borderRadius: BorderRadius.circular(10),
                style: _style,
                value: selectedModuleId,
                items: [
                  DropdownMenuItem(value: "is1101", child: Text("IS1101")),
                  DropdownMenuItem(value: "is1102", child: Text("IS1102")),
                  DropdownMenuItem(value: "is1103", child: Text("IS1103")),
                  DropdownMenuItem(value: "is1104", child: Text("IS1104")),
                  DropdownMenuItem(value: "is1105", child: Text("IS1105")),
                  DropdownMenuItem(
                      value: "is1106(p)", child: Text("IS1106(P)")),
                  DropdownMenuItem(
                      value: "is1106(t)", child: Text("IS1106(T)")),
                  DropdownMenuItem(value: "is1107", child: Text("IS1107")),
                  DropdownMenuItem(value: "is1108", child: Text("IS1108")),
                  DropdownMenuItem(value: "is1109", child: Text("IS1109")),
                  DropdownMenuItem(value: "is1110", child: Text("IS1110")),
                  DropdownMenuItem(value: "is1111", child: Text("IS1111")),
                  DropdownMenuItem(
                      value: "is-egp-1101", child: Text("IS-EGP-1101")),
                ],
                onChanged: (module) {
                  setState(() {
                    selectedModuleId = module!;
                  });
                  widget.onChangedModuleId(module);
                }),
            SizedBox(
              height: 20,
            ),

            // placeholder for file name
            if (filename != null)
              Column(
                children: [
                  Text(filename!),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            //

            // file pick btn
            ElevatedButton(
              onPressed: () async {
                GetFile pickFile = GetFile();
                FilePickerResult? result = await pickFile.getPdfFile();
                setState(() {
                  pickedFile = result;
                  filename = result!.names.single;
                });
              },
              child: Text("Choose a file..",
                  style: TextStyle(
                    fontFamily: "dmsans",
                    color: Colors.white,
                  )),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF3D5A80)),
                elevation: MaterialStatePropertyAll(0),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            value.progress > 0
                ? LinearProgressIndicator(
                    semanticsValue: value.progress.toString(),
                    color: Colors.green.shade400,
                    value: value.progress,
                  )
                : Container(),
          ],
        ),
        actions: [
          PopUpActionBtn(
            btnTitle: "Upload",
            onPressed: value.progress > 0
                ? () {}
                : () {
                    ToastMassege msg = ToastMassege();
                    try {
                      msg.toastMsg(context, "File Uploading", filename!,
                          ToastificationType.info);
                      print("pressed ${pickedFile!.files.single.path}");
                      value.progressListener(context, selectedModuleId,
                          selectedCategory, pickedFile!);
                    } catch (e) {
                      if (e.toString() ==
                          "Null check operator used on a null value") {
                        msg.toastMsg(context, "File not selected",
                            "Please select a file", ToastificationType.error);
                      } else {
                        msg.toastMsg(context, "Error", "Somthing went wrong !",
                            ToastificationType.error);
                      }
                    }
                  },
          ),
          PopUpActionBtn(
            btnTitle: "Reset",
            onPressed: () {
              setState(() {
                selectedModuleId = "is1101";
                selectedCategory = "notes";
                filename = null;
                pickedFile = null;
              });
            },
          ),
        ],
      ),
    );
  }
}
