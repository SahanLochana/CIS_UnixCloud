import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/presantation/Widgets/item_list_widget.dart';

class ItemsPage extends StatelessWidget {
  final String moduleId;
  const ItemsPage({super.key, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Files",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey.shade900,
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
