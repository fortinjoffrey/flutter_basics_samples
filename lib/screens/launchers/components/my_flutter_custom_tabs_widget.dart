import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class MyFlutterCustomTabsWidget extends StatefulWidget {
  const MyFlutterCustomTabsWidget({super.key, required this.url});

  final String url;

  @override
  State<MyFlutterCustomTabsWidget> createState() => _MyFlutterCustomTabsWidgetState();
}

class _MyFlutterCustomTabsWidgetState extends State<MyFlutterCustomTabsWidget> {
  Color? toolbarColor;
  Color? preferredControlTintColor;
  Brightness? statusBarBrightness;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'ToolbarColor',
                style: TextStyle(color: toolbarColor),
              ),
              Spacer(),
              DropdownButton<Color>(
                value: toolbarColor,
                items: [
                  DropdownMenuItem(child: Text("null"), value: null),
                  DropdownMenuItem(
                      child: Text("Theme.of(context).primaryColor"), value: Theme.of(context).primaryColor),
                  if (Theme.of(context).primaryColor != Colors.red)
                    DropdownMenuItem(child: Text("Red"), value: Colors.red),
                  if (Theme.of(context).primaryColor != Colors.green)
                    DropdownMenuItem(child: Text("Green"), value: Colors.green),
                  if (Theme.of(context).primaryColor != Colors.blue)
                    DropdownMenuItem(child: Text("Blue"), value: Colors.blue),
                ],
                onChanged: (value) {
                  setState(() => toolbarColor = value);
                },
              ),
            ],
          ),
        ),
        if (Platform.isIOS) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'preferredControlTintColor',
                  style: TextStyle(color: preferredControlTintColor),
                ),
                Spacer(),
                DropdownButton<Color>(
                  value: preferredControlTintColor,
                  items: [
                    DropdownMenuItem(child: Text("null"), value: null),
                    DropdownMenuItem(child: Text("White"), value: Colors.white),
                    DropdownMenuItem(child: Text("Red"), value: Colors.red),
                    DropdownMenuItem(child: Text("Green"), value: Colors.green),
                    DropdownMenuItem(child: Text("Blue"), value: Colors.blue),
                  ],
                  onChanged: (value) {
                    setState(() => preferredControlTintColor = value);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'statusBarBrightness',
                ),
                Spacer(),
                DropdownButton<Brightness>(
                  value: statusBarBrightness,
                  items: [
                    DropdownMenuItem(child: Text("null"), value: null),
                    DropdownMenuItem(child: Text("Light"), value: Brightness.light),
                    DropdownMenuItem(child: Text("Dark"), value: Brightness.dark),
                  ],
                  onChanged: (value) {
                    setState(() => statusBarBrightness = value);
                  },
                ),
              ],
            ),
          ),
        ],
        ElevatedButton(
          onPressed: () {
            _launchURL(context, widget.url);
          },
          child: const Text('Launch URL'),
        ),
      ],
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: toolbarColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          // or user defined animation.
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          statusBarBrightness: statusBarBrightness,
          preferredBarTintColor: toolbarColor,
          preferredControlTintColor: preferredControlTintColor,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
