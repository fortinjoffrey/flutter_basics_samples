import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/file_utils.dart';
import 'package:photofilters/photofilters.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imageLib;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final file = await saveImageFromUrlToFile('https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096');

  runApp(MaterialApp(
      home: MyApp(
    imageFile: file,
  )));
}

class MyApp extends StatefulWidget {
  final File imageFile;

  const MyApp({super.key, required this.imageFile});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Filter> filters = presetFiltersList;
  File? filteredFile;
  late Uint8List bytes;
  late imageLib.Image? image;
  final filtersCustom = [
    NoFilter(),
    AddictiveBlueFilter(),
    AddictiveRedFilter(),
    AdenFilter(),
    AmaroFilter(),
    AshbyFilter(),
    BrannanFilter(),
    BrooklynFilter(),
    CharmesFilter(),
    CremaFilter(),
    DogpatchFilter(),
    EarlybirdFilter(),
    F1977Filter(),
    GinghamFilter(),
    GinzaFilter(),
    HefeFilter(),
    HelenaFilter(),
    HudsonFilter(),
  ];
  late Future<List<int>> filterBytes;

  @override
  void initState() {
    super.initState();
    bytes = widget.imageFile.readAsBytesSync();
    image = imageLib.decodeImage(bytes);

    filterBytes = compute(applyFilter, <String, dynamic>{
      "filter": filtersCustom[0],
      "image": image,
      "filename": 'toto.jpg',
    });
  }

  Future getImageFromPhotoFilter(context) async {
    // final image = imageLib.decodeImage(bytes);
    Map? imagefile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Photo Filter Example'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ...filtersCustom
                        .map((f) => Column(
                              children: [
                                PhotoFilter(
                                  filename: 'titi.jpg',
                                  filter: f,
                                  image: image!,
                                ),
                                Text(f.name)
                              ],
                            ))
                        .toList()
                  ],
                ),
              ));
        },
        // builder: (context) => PhotoFilterSelector(
        //   title: const Text("Photo Filter Example"),
        //   image: image!,
        //   filters: presetFiltersList,
        //   filename: 'toto.jpg',
        //   loader: const Center(child: CircularProgressIndicator()),
        //   fit: BoxFit.contain,
        // ),
      ),
    );
  }

  Future getImageFromPhotoFilterSelector(context) async {
    // final image = imageLib.decodeImage(bytes);
    Map? imagefile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: 'toto.jpg',
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        filteredFile = imagefile['image_filtered'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // File to Image
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Filter Example'),
      ),
      body: Center(
        child: Container(
          child: filteredFile == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            getImageFromPhotoFilter(context);
                          },
                          child: const Text('PhotoFilter usage')),
                      TextButton(
                          onPressed: () {
                            getImageFromPhotoFilterSelector(context);
                          },
                          child: const Text('PhotoFilter usage')),
                      const Text('No image selected.'),
                    ],
                  ),
                )
              : Image.file(filteredFile!),
        ),
      ),
    );
  }
}
