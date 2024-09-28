import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final bool isTrying;
  final Function()? onTap;
  const MyBtn({super.key, required this.onTap, required this.isTrying});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isTrying ? () {} : onTap,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.pressed)
                ? const Color.fromARGB(255, 122, 152, 191)
                : null;
          },
        ),
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF3D5A80)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isTrying
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                "SIGN IN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "dmsans",
                ),
              ),
      ),
    );
  }
}
