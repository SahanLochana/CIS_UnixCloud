import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/core_features/Data/Models/doc_modal.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';
import 'package:student_manegment_app/features/download_file/data/remote/file_download.dart';
import 'package:student_manegment_app/features/download_file/provider/download_task_provider.dart';
import 'package:student_manegment_app/features/toast_massege/toast_massege.dart';
import 'package:toastification/toastification.dart';

class ItemTile extends StatefulWidget {
  final String moduleId;
  final DocDataModal docDataModal;
  const ItemTile(
      {super.key, required this.docDataModal, required this.moduleId});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<StatusProvider>(context);
    final downloadProvider = Provider.of<DownloadTaskProvider>(context);
    int? showBar =
        downloadProvider.downloadTasksFlags[widget.docDataModal.fileName];
    print("showbar ${widget.docDataModal.fileName} $showBar");

    // cloud path
    final cloudPath =
        "modules/semester 01/${widget.moduleId}/${stateProvider.selectedCategory}/${widget.docDataModal.fileName}"
            .toLowerCase();

    double deviceWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        // navigate to pdf view page.
        GoRouter.of(context).pushNamed(
          RouterConstants.pdfViewRouteName,
          pathParameters: {"url": widget.docDataModal.url},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets\\icons\\pdf round.png",
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: deviceWidth - 155,
                  child: Text(
                    widget.docDataModal.fileName,
                    softWrap: true,
                    style: TextStyle(fontFamily: "dmsans"),
                  ),
                ),
                showBar == 1
                    ? IconButton(
                        onPressed: () {}, icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () async {
                          FileDownload download = FileDownload();
                          bool isExists = await download
                              .checkFileExists(widget.docDataModal.fileName);
                          ToastMassege msg = ToastMassege();
                          if (!isExists) {
                            print(cloudPath);
                            downloadProvider.updateProgress(context, cloudPath,
                                widget.docDataModal.fileName);
                            msg.toastMsg(
                              context,
                              "Downloading",
                              widget.docDataModal.fileName,
                              ToastificationType.info,
                            );
                          } else {
                            msg.toastMsg(
                                context,
                                "File Alredy exists",
                                widget.docDataModal.fileName,
                                ToastificationType.info);
                          }
                        },
                        icon: Center(
                          child: Image.asset(
                            "assets\\icons\\download.png",
                            height: 20,
                            width: 20,
                          ),
                        ))
              ],
            ),
            showBar == 1
                ? LinearProgressIndicator(
                    color: Colors.green.shade300,
                    value: downloadProvider
                        .downloadTasks[widget.docDataModal.fileName],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
