import 'package:basics_samples/components/packages_chip_list.dart';
import 'package:basics_samples/main.dart';
import 'package:basics_samples/screens/launchers/components/my_flutter_custom_tabs_widget.dart';
import 'package:basics_samples/screens/launchers/components/my_open_file_widget.dart';
import 'package:basics_samples/screens/launchers/components/my_url_launcher_widget.dart';
import 'package:basics_samples/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LaunchersPackages {
  url_launcher,
  flutter_custom_tabs,
  open_filex,
}

class LaunchersScreen extends StatefulWidget {
  const LaunchersScreen({super.key});

  @override
  State<LaunchersScreen> createState() => _LaunchersScreenState();
}

class _LaunchersScreenState extends State<LaunchersScreen> {
  LaunchersPackages selectedPackage = LaunchersPackages.url_launcher;
  URLTypes selectedURLType = URLTypes.website;
  bool shoulduseFilePath = false;
  late final PdfFiles pdfFiles;

  @override
  void initState() {
    super.initState();
    pdfFiles = context.read<PdfFiles>();
  }

  String getUrl() {
    if (shoulduseFilePath) {
      switch (selectedURLType) {
        case URLTypes.pdf:
          return pdfFiles.simplePDF.path;
        case URLTypes.pdf_large:
          return pdfFiles.largePDF.path;
        case URLTypes.website:
        case URLTypes.website_ssl_issue:
          return getURLForType(selectedURLType);
      }
    }
    return getURLForType(selectedURLType);
  }

  @override
  Widget build(BuildContext context) {
    final url = getUrl();

    return Scaffold(
      appBar: AppBar(
        title: Text('LaunchersScreen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PackagesChipList<LaunchersPackages>(
              enumValues: LaunchersPackages.values,
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
            child: PackagesChipList<URLTypes>(
              enumValues: URLTypes.values,
              selectedValue: selectedURLType,
              onSelected: (value) => setState(() => selectedURLType = value),
              labelBuilder: (package) => package.name,
            ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('${shoulduseFilePath ? 'path' : 'url'}: $url'),
          ),
          Builder(
            builder: (context) {
              switch (selectedPackage) {
                case LaunchersPackages.url_launcher:
                  return MyUrlLauncherWidget(url: url);
                case LaunchersPackages.flutter_custom_tabs:
                  return MyFlutterCustomTabsWidget(url: url);
                case LaunchersPackages.open_filex:
                  return MyOpenFileWidget(path: url);
              }
            },
          ),
        ],
      ),
    );
  }
}
