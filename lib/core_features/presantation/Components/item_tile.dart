// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/Data/Local/get_device_info.dart';
import 'package:CIS_UnixCloud/core_features/Data/Local/handle_permission.dart';
import 'package:CIS_UnixCloud/core_features/Data/Models/doc_modal.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/cache_func.dart';
import 'package:CIS_UnixCloud/core_features/Provider/cache_provider.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
import 'package:CIS_UnixCloud/features/app_settings/local/store_data.dart';
import 'package:CIS_UnixCloud/features/download_file/data/remote/file_download.dart';
import 'package:CIS_UnixCloud/features/download_file/provider/download_task_provider.dart';
import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
    final cacheProvider = Provider.of<CacheProvider>(context);
    int? showBar =
        downloadProvider.downloadTasksFlags[widget.docDataModal.fileName];

    // cloud path
    final cloudPath =
        "modules/semester 01/${widget.moduleId}/${stateProvider.selectedCategory}/${widget.docDataModal.fileName}"
            .toLowerCase();

    void downloadFunc() async {
      FileDownload download = FileDownload();
      bool isExists =
          await download.checkFileExists(widget.docDataModal.fileName);
      ToastMassege msg = ToastMassege();
      if (!isExists) {
        downloadProvider.updateProgress(
            context, cloudPath, widget.docDataModal.fileName);
        msg.toastMsg(
          context,
          "Downloading",
          widget.docDataModal.fileName,
          ToastificationType.info,
        );
      } else {
        msg.toastMsg(context, "File Alredy exists",
            widget.docDataModal.fileName, ToastificationType.info);
      }
    }

    double deviceWidth = MediaQuery.sizeOf(context).width;
    final StoreData prefData = StoreData();
    CachingPdf cachingPdf = CachingPdf();
    return GestureDetector(
      onTap: () async {
        String filename = widget.docDataModal.fileName;
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Caching...."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: LoadingWave()),
              ],
            ),
          ),
        );

        bool isAvailable = await cachingPdf.isAvailable(filename);
        String? path = await cachingPdf.pdfPath(filename);
        int fileSize = await File(path).length();

        // Wait for the cachePdf function to complete
        if (!isAvailable && cacheProvider.isEnabled) {
          path = await cachingPdf.cachePdf(context, filename, cloudPath);
        }
        // print(path);
        context.pop();
        print(fileSize.toString());
        // Check if the path is valid before navigating
        if (path != null && fileSize > 500) {
          // Navigate to the PDF view page
          GoRouter.of(context).pushNamed(
            RouterConstants.pdfViewRouteName,
            pathParameters: {
              "url": path,
              "fileName": filename,
              "onDevice": "true",
            },
          );
        } else {
          GoRouter.of(context).pushNamed(
            RouterConstants.pdfViewRouteName,
            pathParameters: {
              "url": widget.docDataModal.url,
              "fileName": filename,
              "onDevice": "false",
            },
          );
        }
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
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: deviceWidth - 155,
                  child: Text(
                    widget.docDataModal.fileName,
                    softWrap: true,
                    style: const TextStyle(fontFamily: "dmsans"),
                  ),
                ),
                showBar == 1
                    ? IconButton(
                        onPressed: () async {
                          FileDownload download = FileDownload();
                          await download.cancalTask(downloadProvider
                              .downloadTask["widget.docDataModal.fileName"]);
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () async {
                          int sdkVer = await GetInfo().getAndroidVersion();
                          if (sdkVer <= 28) {
                            await PermissionHandle()
                                .handlePermission(context, downloadFunc);
                            return;
                          }
                          downloadFunc();
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
