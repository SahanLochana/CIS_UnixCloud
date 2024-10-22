import 'package:flutter/material.dart';

class SemestersPage extends StatelessWidget {
  const SemestersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Modules",
          style: TextStyle(fontFamily: "dmsans", color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
