import 'package:basics_samples/pages/responsive_page_wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePageWrapper(
      desktopBuilder: (context) {
        return Container(
          color: Colors.red,
          child: const Center(
            child: Text('home'),
          ),
        );
      },
      mobileBuilder: (context) {
        return Container(
          color: Colors.red,
          child: const Center(
            child: Text('home'),
          ),
        );
      },
      activeTabName: 'home',
    );
  }
}
