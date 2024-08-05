import 'package:flutter/material.dart';

class MsgTile extends StatelessWidget {
  const MsgTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            border: Border.all(color: Colors.red.shade300, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade600),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Check your email/password",
                  style: TextStyle(fontSize: 16, color: Colors.red.shade600),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
