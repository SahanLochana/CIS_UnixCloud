import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
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

  String? selectedModuleId;
  String selectedSem = "semester 02";
  String selectedCategory = "notes";
  String? filename;
  FilePickerResult? pickedFile;

  void writeToDB() async {
    msg.toastMsg(context, "Link uploading Started",
        "${nameController.text} uploading started", ToastificationType.info);
    await writeOnDB.writeOnDB(
        selectedModuleId!,
        selectedCategory,
        "${selectedModuleId!.toUpperCase()} ${nameController.text} Record",
        linkController.text,
        selectedSem);
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
        body: FutureBuilder(
          future: UploadProvider().fetchModules(selectedSem),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // show loading animation while data load
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWave());
              // when got error
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
              // if there no data
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            // if has data
            List<DropdownMenuItem> itemList = snapshot.data;
            if (selectedModuleId == null && itemList.isNotEmpty) {
              selectedModuleId = itemList[0].value; // Set a default value
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // semester picker
                  DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      style: _style,
                      value: selectedSem,
                      items: const [
                        DropdownMenuItem(
                            value: "semester 01", child: Text("Semester 01")),
                        DropdownMenuItem(
                            value: "semester 02", child: Text("Semester 02")),
                        DropdownMenuItem(
                            value: "semester 03", child: Text("Semester 03")),
                      ],
                      onChanged: (sem) {
                        print(sem);
                        print(selectedSem);
                        setState(() {
                          selectedSem = sem!;
                          selectedModuleId = null;
                        });
                        widget.onChangedCategory(sem);
                      }),

                  // category
                  DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      style: _style,
                      value: selectedCategory,
                      items: const [
                        DropdownMenuItem(value: "notes", child: Text("Notes")),
                        DropdownMenuItem(
                            value: "slides", child: Text("Slides")),
                        DropdownMenuItem(
                            value: "records", child: Text("Records")),
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
                      isExpanded: false,
                      borderRadius: BorderRadius.circular(10),
                      style: _style,
                      value: selectedModuleId,
                      items: itemList,
                      onChanged: (module) {
                        print(module.toString());
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
                            FilePickerResult? result =
                                await pickFile.getPdfFile();
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
                                            selectedModuleId!,
                                            selectedCategory,
                                            selectedSem,
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
                            selectedModuleId = itemList[0].value;
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
            );
          },
        ),
      ),
    );
  }
}
