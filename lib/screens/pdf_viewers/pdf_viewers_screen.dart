import 'package:basics_samples/main.dart';
import 'package:basics_samples/screens/pdf_viewers/components/my_flutter_pdfview_widget.dart';
import 'package:basics_samples/screens/pdf_viewers/components/my_pdfx_widget.dart';
import 'package:basics_samples/components/packages_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PDFViewersPackages {
  flutter_pdfview,
  pdfx,
}

enum _PDFTypes {
  pdf,
  pdf_large,
}

class PdfViewersScreen extends StatefulWidget {
  const PdfViewersScreen({Key? key}) : super(key: key);

  @override
  _PdfViewersScreenState createState() => _PdfViewersScreenState();
}

class _PdfViewersScreenState extends State<PdfViewersScreen> {
  late final PdfFiles _files;

  PDFViewersPackages selectedPackage = PDFViewersPackages.flutter_pdfview;
  _PDFTypes selectedPDFType = _PDFTypes.pdf;

  @override
  void initState() {
    super.initState();
    _files = context.read<PdfFiles>();
  }

  String getFilePath() {
    switch (selectedPDFType) {
      case _PDFTypes.pdf:
        return _files.simplePDF.path;
      case _PDFTypes.pdf_large:
        return _files.largePDF.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = getFilePath();
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewers'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PackagesChipList<PDFViewersPackages>(
              enumValues: PDFViewersPackages.values,
              selectedValue: selectedPackage,
              onSelected: (value) {
                setState(() {
                  selectedPackage = value;
                });
              },
              labelBuilder: (package) => package.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 8, bottom: 8),
            child: PackagesChipList<_PDFTypes>(
              enumValues: _PDFTypes.values,
              selectedValue: selectedPDFType,
              onSelected: (value) => setState(() => selectedPDFType = value),
              labelBuilder: (package) => package.name,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                switch (selectedPackage) {
                  case PDFViewersPackages.flutter_pdfview:
                    return MyFlutterPdfViewWidget(filePath: path);
                  case PDFViewersPackages.pdfx:
                    return MyPdfxWidget(key: UniqueKey(), filePath: path);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
