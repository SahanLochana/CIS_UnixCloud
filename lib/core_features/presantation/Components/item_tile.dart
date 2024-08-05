import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_manegment_app/core_features/Data/Models/doc_modal.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';

class ItemTile extends StatelessWidget {
  final DocDataModal docDataModal;
  const ItemTile({super.key, required this.docDataModal});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        // navigate to pdf view page.
        GoRouter.of(context).pushNamed(
          RouterConstants.pdfViewRouteName,
          pathParameters: {"url": docDataModal.url},
        );
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
            SizedBox(
              width: deviceWidth - 120,
              child: Text(
                docDataModal.fileName,
                softWrap: true,
              ),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.download_rounded))
          ],
        ),
      ),
    );
  }
}
