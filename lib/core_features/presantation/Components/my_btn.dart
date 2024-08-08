import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final Function()? onTap;
  const MyBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: const MaterialStatePropertyAll(Color(0xFF3D5A80)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
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
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //     decoration: BoxDecoration(
    //       color: Colors.grey.shade900,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: const Text(
    //       "L O G I N",
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // );
  }
}
