import 'package:CIS_UnixCloud/core_features/presantation/Widgets/item_list_widget.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  // get module id for get documents
  final String moduleId;
  const ItemsPage({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Files",
          style: TextStyle(
            fontFamily: "dmsans",
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ItemListWidget(
          moduleId: moduleId,
        ),
      ),
    );
  }
}
