import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_manegment_app/core_features/Data/Models/doc_modal.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';

class ItemTile extends StatelessWidget {
  final DocDataModal docDataModal;
  const ItemTile({super.key, required this.docDataModal});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(docDataModal.fileName),
          ],
        ),
      ),
    );
  }
}
