import 'package:flutter/material.dart';

class LinkPastefield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const LinkPastefield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.grey.shade600, fontFamily: "dmsans"),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF3D5A80)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
    );
  }
}
