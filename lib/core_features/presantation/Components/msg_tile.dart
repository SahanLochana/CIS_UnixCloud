import 'package:flutter/material.dart';

class ErrorMsgTile extends StatelessWidget {
  final String errorMSg;
  const ErrorMsgTile({super.key, required this.errorMSg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            border: Border.all(color: Colors.red.shade200, width: 2),
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
                  errorMSg,
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
