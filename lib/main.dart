import 'dart:io';

import 'package:basics_samples/data/file_utils.dart';
import 'package:basics_samples/screens/launchers/launchers_screen.dart';
import 'package:basics_samples/screens/webviews/webviews_screen.dart';
import 'package:basics_samples/screens/pdf_viewers/pdf_viewers_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdfFiles {
  final File simplePDF;
  final File largePDF;

  PdfFiles({required this.simplePDF, required this.largePDF});
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final File largePDF = await FileUtils.createFileFromUrl(
    'https://eu.ftp.opendatasoft.com/stif/PlansRegion/Plans/PLAN_POCHE_RESEAU.pdf',
  );
  final simplePDF = await FileUtils.createFileFromUrl(
    'https://www.africau.edu/images/default/sample.pdf',
  );
  final files = PdfFiles(simplePDF: simplePDF, largePDF: largePDF);
  runApp(MyApp(pdfFiles: files));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.pdfFiles});

  final PdfFiles pdfFiles;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'view-pdf-solutions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<PdfFiles>(
        create: (context) => pdfFiles,
        child: MainView(),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PdfViewersScreen(),
    WebviewsScreen(),
    LaunchersScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'PDF Viewers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_asset_rounded),
            label: 'Webviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'Launchers',
          ),
        ],
      ),
    );
  }
}
