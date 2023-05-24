import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class MyPdfxWidget extends StatefulWidget {
  const MyPdfxWidget({super.key, required this.filePath});

  final String filePath;

  @override
  State<MyPdfxWidget> createState() => _MyPdfxWidgetState();
}

enum PdfxWidgetType { pdfView, pdfViewPinch }

class _MyPdfxWidgetState extends State<MyPdfxWidget> {
  late PdfControllerPinch pdfPinchController;
  late PdfController pdfController;
  PdfxWidgetType type = PdfxWidgetType.pdfView;

  @override
  void initState() {
    super.initState();
    log('initState', name: 'ST2');
    pdfPinchController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.filePath),
    );
    pdfController = PdfController(
      document: PdfDocument.openFile(widget.filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChoosePdfViewRow(
          onChanged: (bool value) {
            setState(() {
              type = value ? PdfxWidgetType.values[1] : PdfxWidgetType.values[0];
            });
          },
          type: type,
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              switch (type) {
                case PdfxWidgetType.pdfView:
                  return PdfView(
                    controller: pdfController,
                  );
                case PdfxWidgetType.pdfViewPinch:
                  // /!\ I had to reinit the controller here which is bad otherwise the widget renders a blank page /!\
                  pdfPinchController = PdfControllerPinch(
                    document: PdfDocument.openFile(widget.filePath),
                  );
                  return PdfViewPinch(
                    controller: pdfPinchController,
                    scrollDirection: Axis.horizontal,
                  );
              }
            },
          ),
        ),
      ],
    );
    // return PdfViewPinch(controller: pdfPinchController);
  }
}

class _ChoosePdfViewRow extends StatelessWidget {
  const _ChoosePdfViewRow({
    required this.type,
    required this.onChanged,
  });

  final PdfxWidgetType type;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          PdfxWidgetType.values[0].name,
          style: TextStyle(color: type == PdfxWidgetType.values[0] ? Colors.black : Colors.grey),
        ),
        Switch(
          value: type == PdfxWidgetType.values[1],
          onChanged: onChanged,
        ),
        Text(
          PdfxWidgetType.values[1].name,
          style: TextStyle(color: type == PdfxWidgetType.values[1] ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}
