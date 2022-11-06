import 'package:basics_samples/pages/responsive_page_wrapper.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePageWrapper(
      desktopBuilder: (context) {
        return Container(
          color: Colors.green,
          child: const Center(
            child: Text('about'),
          ),
        );
      },
      mobileBuilder: (context) {
        return Container(
          color: Colors.green,
          child: const Center(
            child: Text('about'),
          ),
        );
      },
      activeTabName: 'about',
    );
  }
}
