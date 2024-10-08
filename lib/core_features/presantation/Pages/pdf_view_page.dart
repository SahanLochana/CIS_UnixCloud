import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/pdf_page_nav_btn.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewPage extends StatefulWidget {
  final String url;
  final String fileName;
  final String onDevice;
  const PdfViewPage(
      {super.key,
      required this.url,
      required this.fileName,
      required this.onDevice});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  late PdfControllerPinch pdfControllerPinch;

  // initialize page numbers
  int currentPage = 1, allPages = 0;

  // holding pdf loading state
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.onDevice == "true") {
      pdfControllerPinch =
          PdfControllerPinch(document: PdfDocument.openFile(widget.url));
    } else {
      pdfControllerPinch = PdfControllerPinch(
          document: PdfDocument.openData(InternetFile.get(widget.url)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.fileName,
          style: const TextStyle(
              fontFamily: "dmsans", color: Colors.white, fontSize: 14),
        ),
      ),
      floatingActionButton: Container(
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PdfPageNavBtn(
                pdfControllerPinch: pdfControllerPinch,
                isRight: false,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "$currentPage/$allPages",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              PdfPageNavBtn(
                pdfControllerPinch: pdfControllerPinch,
                isRight: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: [
        PdfViewPinch(
          scrollDirection: Axis.vertical,
          controller: pdfControllerPinch,
          onDocumentLoaded: (document) {
            setState(() {
              allPages = document.pagesCount;
              isLoading = false;
            });
          },
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
        ),
        if (isLoading) const LoadingWave()
      ]),
    );
  }
}
