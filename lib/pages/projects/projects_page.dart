import 'package:basics_samples/pages/responsive_page_wrapper.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePageWrapper(
      desktopBuilder: (context) {
        return Container(
          color: Colors.blue,
          child: const Center(
            child: Text('projects'),
          ),
        );
      },
      mobileBuilder: (context) {
        return Container(
          color: Colors.blue,
          child: const Center(
            child: Text('projects'),
          ),
        );
      }, activeTabName: 'projects',
    );
  }
}
