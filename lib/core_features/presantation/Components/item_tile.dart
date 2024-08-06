import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/core_features/Data/Models/doc_modal.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';
import 'package:student_manegment_app/features/download_file/provider/download_task_provider.dart';

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
                SizedBox(
                  width: deviceWidth - 120,
                  child: Text(
                    widget.docDataModal.fileName,
                    softWrap: true,
                    style: TextStyle(fontFamily: "dmsans"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      print(cloudPath);
                      downloadProvider.updateProgress(
                          cloudPath, widget.docDataModal.fileName);
                    },
                    icon: const Icon(Icons.download_rounded))
              ],
            ),
            LinearProgressIndicator(
              value:
                  downloadProvider.downloadTasks[widget.docDataModal.fileName],
            )
          ],
        ),
      ),
    );
  }
}
