import 'package:flutter/material.dart';

class ErrorMsgTile extends StatelessWidget {
  final int errorCode;
  const ErrorMsgTile({super.key, required this.errorCode});

  @override
  Widget build(BuildContext context) {
    String? errorMsg;
    switch (errorCode) {
      case 2:
        errorMsg = "Check your email/password";
        break;
      case 3 || 5:
        errorMsg = "check your internet connection";
        break;
      case 4:
        errorMsg = "Something went wrong";
        break;
      default:
        errorMsg = "Somthing went wrong";
        break;
    }
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
                  errorMsg,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade600,
                      fontFamily: "dmsans"),
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
