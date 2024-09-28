import 'package:CIS_UnixCloud/core_features/Data/Models/doc_modal.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/open_telegram.dart';
import 'package:CIS_UnixCloud/features/toast_massege/toast_massege.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class RecordTile extends StatelessWidget {
  final DocDataModal docDataModal;
  const RecordTile({super.key, required this.docDataModal});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        OpenTelegram openTelegram = OpenTelegram();
        try {
          openTelegram.openTelegram(docDataModal.url);
        } catch (e) {
          debugPrint(e.toString());
          ToastMassege().toastMsg(context, "Link can't open",
              "Can't open the link !", ToastificationType.error);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
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
                docDataModal.fileName,
                softWrap: true,
                style: const TextStyle(fontFamily: "dmsans"),
              ),
            ),
            const Icon(Icons.telegram_rounded)
          ],
        ),
      ),
    );
  }
}
