import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String tileTitle;
  const DrawerTile({super.key, required this.tileTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // navigate
      },
      leading: const Icon(Icons.book_rounded),
      title: Text(tileTitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
