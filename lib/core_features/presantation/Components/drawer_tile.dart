import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String tileTitle;
  const DrawerTile({super.key, required this.tileTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // TODO : navigate to module
      },

      leading: const Icon(Icons.book_rounded), //TODO : change icon
      title: Text(tileTitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
