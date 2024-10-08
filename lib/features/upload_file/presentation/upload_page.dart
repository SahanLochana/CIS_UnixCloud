import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:CIS_UnixCloud/features/upload_file/data/get_file.dart';
import 'package:CIS_UnixCloud/features/upload_file/data/write_on_db.dart';
import 'package:CIS_UnixCloud/features/upload_file/presentation/components/link_paste.dart';
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
  TextEditingController linkController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  ToastMassege msg = ToastMassege();

  WriteOnDB writeOnDB = WriteOnDB();

  String selectedModuleId = "is1101";
  String selectedCategory = "notes";
  String? filename;
  FilePickerResult? pickedFile;

  void writeToDB() async {
    msg.toastMsg(context, "Link uploading Started",
        "${nameController.text} uploading started", ToastificationType.info);
    await writeOnDB.writeOnDB(
        selectedModuleId,
        selectedCategory,
        "${selectedModuleId.toUpperCase()} ${nameController.text} Record",
        linkController.text);
    msg.toastMsg(
        // ignore: use_build_context_synchronously
        context,
        "Link uploading Finished",
        "${nameController.text} uploading Finished",
        ToastificationType.success);
  }

  final TextStyle _style = const TextStyle(
    fontFamily: "dmsans",
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Upload files",
            style: TextStyle(color: Colors.white, fontFamily: "dmsans"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // category
              DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  style: _style,
                  value: selectedCategory,
                  items: const [
                    DropdownMenuItem(value: "notes", child: Text("Notes")),
                    DropdownMenuItem(value: "slides", child: Text("Slides")),
                    DropdownMenuItem(value: "records", child: Text("Records")),
                  ],
                  onChanged: (category) {
                    setState(() {
                      selectedCategory = category!;
                    });
                    widget.onChangedCategory(category);
                  }),
              const SizedBox(
                height: 20,
              ),
              // module ID
              DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  style: _style,
                  value: selectedModuleId,
                  items: const [
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
                    DropdownMenuItem(
                        value: "is1107(p)", child: Text("IS1107(P)")),
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
              const SizedBox(
                height: 20,
              ),

              // placeholder for file name
              if (filename != null)
                Column(
                  children: [
                    Text(filename!),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              //

              // file pick btn
              selectedCategory != "records"
                  ? ElevatedButton(
                      onPressed: () async {
                        GetFile pickFile = GetFile();
                        FilePickerResult? result = await pickFile.getPdfFile();
                        setState(() {
                          pickedFile = result;
                          filename = result!.names.single;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xFF3D5A80)),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("Choose a file..",
                          style: TextStyle(
                            fontFamily: "dmsans",
                            color: Colors.white,
                          )),
                    )
                  : Column(
                      children: [
                        LinkPastefield(
                          hintText: "telegram link",
                          controller: linkController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LinkPastefield(
                          hintText: "Date and time (optional : part)",
                          controller: nameController,
                        ),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              value.progress > 0 && selectedCategory != "records"
                  ? Column(
                      children: [
                        LinearProgressIndicator(
                          semanticsValue: value.progress.toString(),
                          color: Colors.green.shade400,
                          value: value.progress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopUpActionBtn(
                      btnTitle: "Upload",
                      onPressed: value.progress > 0
                          ? () {}
                          : selectedCategory != "records"
                              ? () {
                                  try {
                                    msg.toastMsg(context, "File Uploading",
                                        filename!, ToastificationType.info);
                                    value.progressListener(
                                        context,
                                        selectedModuleId,
                                        selectedCategory,
                                        pickedFile!);
                                  } catch (e) {
                                    if (e.toString() ==
                                        "Null check operator used on a null value") {
                                      msg.toastMsg(
                                          context,
                                          "File not selected",
                                          "Please select a file",
                                          ToastificationType.error);
                                    } else {
                                      msg.toastMsg(
                                          context,
                                          "Error",
                                          "Somthing went wrong !",
                                          ToastificationType.error);
                                    }
                                  }
                                }
                              : () {
                                  writeToDB();
                                }),
                  const SizedBox(
                    width: 20,
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
            ],
          ),
        ),
      ),
    );
  }
}
