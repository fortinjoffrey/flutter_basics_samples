import 'package:basics_samples/data/url_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUrlLauncherWidget extends StatefulWidget {
  const MyUrlLauncherWidget({super.key, required this.url});

  final String url;

  @override
  State<MyUrlLauncherWidget> createState() => _MyUrlLauncherWidgetState();
}

class _MyUrlLauncherWidgetState extends State<MyUrlLauncherWidget> {
  bool shouldOpenInExternalApplication = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Open in external application'),
              Spacer(),
              Switch(
                value: shouldOpenInExternalApplication,
                onChanged: (value) {
                  setState(() {
                    shouldOpenInExternalApplication = value;
                  });
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UrlUtils.tryLaunchUrlWithUrlLauncher(
              widget.url,
              mode: shouldOpenInExternalApplication ? LaunchMode.externalNonBrowserApplication : LaunchMode.inAppWebView,
            );
          },
          child: const Text('Launch URL'),
        ),
      ],
    );
  }
}
