import 'package:basics_samples/main.dart';
import 'package:basics_samples/screens/webviews/components/my_flutter_inappwebview_widget.dart';
import 'package:basics_samples/screens/webviews/components/my_webview_flutter_widget.dart';
import 'package:basics_samples/components/packages_chip_list.dart';
import 'package:basics_samples/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _WebviewPackages {
  webview_flutter,
  flutter_inappwebview,
}

class WebviewsScreen extends StatefulWidget {
  const WebviewsScreen({super.key});

  @override
  State<WebviewsScreen> createState() => _WebviewsScreenState();
}

class _WebviewsScreenState extends State<WebviewsScreen> {
  bool shouldOpenInExternalApplication = false;

  _WebviewPackages selectedPackage = _WebviewPackages.webview_flutter;
  URLTypes selectedURLType = URLTypes.website;
  bool shoulduseFilePath = false;

  late final PdfFiles pdfFiles;

  String getUrl() {
    if (shoulduseFilePath) {
      switch (selectedURLType) {
        case URLTypes.pdf:
          return 'file:${pdfFiles.simplePDF.path}';
        case URLTypes.pdf_large:
          return 'file:${pdfFiles.largePDF.path}';
        case URLTypes.website:
        case URLTypes.website_ssl_issue:
          return getURLForType(selectedURLType);
      }
    }
    return getURLForType(selectedURLType);
  }

  @override
  void initState() {
    super.initState();
    pdfFiles = context.read<PdfFiles>();
  }

  @override
  Widget build(BuildContext context) {
    final url = getUrl();

    return Scaffold(
      appBar: AppBar(
        title: Text('PdfInWebViewsScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 8, bottom: 8),
            child: PackagesChipList<_WebviewPackages>(
              enumValues: _WebviewPackages.values,
              selectedValue: selectedPackage,
              onSelected: (value) => setState(() => selectedPackage = value),
              labelBuilder: (package) => package.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 8, bottom: 8),
            child: PackagesChipList<URLTypes>(
              enumValues: URLTypes.values,
              selectedValue: selectedURLType,
              onSelected: (value) => setState(() => selectedURLType = value),
              labelBuilder: (package) => package.name,
            ),
          ),
          Builder(
            builder: (context) {
              switch (selectedPackage) {
                case _WebviewPackages.webview_flutter:
                  return SizedBox.shrink();
                case _WebviewPackages.flutter_inappwebview:
                  return SizedBox.shrink();
              }
            },
          ),
          Builder(
            builder: (context) {
              switch (selectedURLType) {
                case URLTypes.pdf:
                case URLTypes.pdf_large:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Use URL or File path'),
                        Spacer(),
                        Switch(
                          value: shoulduseFilePath,
                          onChanged: (value) {
                            setState(() {
                              shoulduseFilePath = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                case URLTypes.website:
                case URLTypes.website_ssl_issue:
                  return const SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                switch (selectedPackage) {
                  case _WebviewPackages.webview_flutter:
                    return MyWebviewFlutterWidget(
                      url: url,
                    );
                  case _WebviewPackages.flutter_inappwebview:
                    return MyFlutterInappwebviewWidget(
                      url: url,
                      // url: getURLForType(selectedURLType),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
