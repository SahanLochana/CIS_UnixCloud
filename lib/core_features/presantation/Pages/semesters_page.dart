import 'package:CIS_UnixCloud/core_features/presantation/Components/semester_tile.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Widgets/semester_list_widget.dart';
import 'package:flutter/material.dart';

class SemestersPage extends StatelessWidget {
  const SemestersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Semesters",
          style: TextStyle(fontFamily: "dmsans", color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SemesterListWidget(),
      ),
    );
  }
}
