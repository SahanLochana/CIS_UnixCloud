import 'package:flutter/material.dart';

class AdminBoard extends StatelessWidget {
  final String uid;
  const AdminBoard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("admin board"),
      ),
    );
  }
}
