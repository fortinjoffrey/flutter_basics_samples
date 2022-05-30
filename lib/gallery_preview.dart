import 'dart:typed_data';
import 'dart:ui';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:preload_page_view/preload_page_view.dart';

class GalleryPreview extends StatefulWidget {
  const GalleryPreview({
    Key? key,
    required this.assetEntity,
    required this.exifData,
    required this.firstImageBytes,
    required this.assetEntities,
    required this.firstImageIndex,
  }) : super(key: key);

  final AssetEntity assetEntity;
  final Uint8List firstImageBytes;
  final Map<String, IfdTag> exifData;
  final List<AssetEntity> assetEntities;
  // final List<AssetEntity> assetEntities;
  final int firstImageIndex;

  @override
  State<GalleryPreview> createState() => _GalleryPreviewState();
}

class _GalleryPreviewState extends State<GalleryPreview> {
  late final PreloadPageController _pageController;
  late int currentPageIndex;
  late Uint8List currentFileBytes;
  List<Uint8List?> assetsBytesList = [];

  Future<void> _preloadBeforeAndAfterBytes() async {
    if (currentPageIndex != 0) {
      final int beforeIndex = currentPageIndex - 1;
      assetsBytesList[beforeIndex] = await widget.assetEntities[beforeIndex].originBytes;
    }

    if (currentPageIndex != widget.assetEntities.length - 1) {
      final int afterIndex = currentPageIndex + 1;
      assetsBytesList[afterIndex] = await widget.assetEntities[afterIndex].originBytes;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.firstImageIndex;
    currentFileBytes = widget.firstImageBytes;
    _pageController = PreloadPageController(initialPage: currentPageIndex);
    widget.assetEntities.forEach((element) {
      assetsBytesList.add(null);
    });

    assetsBytesList[currentPageIndex] = currentFileBytes;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _preloadBeforeAndAfterBytes();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (assetEntity.type == AssetType.image) {
    //   final date = assetEntity.createDateTime;
    //   print(date);
    // }
    String? day;
    String? hm;

    var datetimeString = widget.exifData['Image DateTime']?.printable;
    if (datetimeString != null) {
      datetimeString = '2009-10-18 16:02:47';
      final datetime = DateTime.parse(datetimeString);
      hm = DateFormat.Hm().format(datetime);
      day = DateFormat.d().format(datetime);

      print('hm= $hm');
      print('day= $day');
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: Colors.grey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Column(
              children: [
                if (day != null) Text(day),
                if (hm != null) Text(hm),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PreloadPageView.builder(
                    preloadPagesCount: 1,
                    itemCount: widget.assetEntities.length,
                    itemBuilder: (context, index) {
                      print('index= $index');
                      return Image(
                        image: MemoryImage(assetsBytesList[index]!),
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      );
                    },

                    onPageChanged: (page) async {
                      WidgetsBinding.instance?.addPostFrameCallback((_) async {
                        await _preloadBeforeAndAfterBytes();
                        // setState(() {
                        currentPageIndex = page;
                      // });
                      });
                      // await _preloadBeforeAndAfterBytes();
                      // final Uint8List? bytes = await widget.assetEntities[page].originBytes;
                      // if (bytes == null) return;

                      // setState(() {
                      //   currentFileBytes = bytes;
                      // });
                      // final Map<String, IfdTag> exifData = await readExifFromBytes(bytes);

                      
                    },
                    controller: _pageController,
                    // children: [
                    //   Image(
                    //     image: MemoryImage(currentFileBytes),
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ],
                  ),
                ),
                // const Spacer(),
                Text('${currentPageIndex + 1} sur ${widget.assetEntities.length}'),
                const SizedBox(height: 32),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
