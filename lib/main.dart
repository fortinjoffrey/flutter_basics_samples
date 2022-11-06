import 'package:basics_samples/pages/about/about_page.dart';
import 'package:basics_samples/pages/home/home_page.dart';
import 'package:basics_samples/pages/projects/projects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            settings: settings,
          );
        } else if (settings.name == '/about') {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const AboutPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            settings: settings,
          );
        } else if (settings.name == '/projects') {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const ProjectsPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
