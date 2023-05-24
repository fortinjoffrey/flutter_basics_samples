import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MyFlutterPdfViewWidget extends StatelessWidget {
  const MyFlutterPdfViewWidget({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    print(filePath);
    return ExcludeSemantics(
      excluding: Platform.isIOS,
      child: PDFView(
        key: UniqueKey(),
        filePath: filePath,
        enableSwipe: false,
        swipeHorizontal: false,
        autoSpacing: true,
        // pageFling: true,
        pageSnap: true,
        fitEachPage: false,
        fitPolicy: FitPolicy.BOTH,
      ),
    );
  }
}
