import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

// navigate through pdf pages

class PdfPageNavBtn extends StatelessWidget {
  final bool isRight;
  const PdfPageNavBtn({
    super.key,
    required this.pdfControllerPinch,
    required this.isRight,
  });

  final PdfControllerPinch pdfControllerPinch;

  @override
  Widget build(BuildContext context) {
    return isRight
        ? IconButton(
            onPressed: () {
              pdfControllerPinch.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            },
            icon: const Icon(Icons.chevron_right_rounded, color: Colors.white),
          )
        : IconButton(
            onPressed: () {
              pdfControllerPinch.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            },
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          );
  }
}
