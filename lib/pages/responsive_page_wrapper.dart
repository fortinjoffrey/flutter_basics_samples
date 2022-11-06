import 'package:basics_samples/utils/navigation/nav_bar.dart';
import 'package:basics_samples/utils/navigation/nav_drawer.dart';
import 'package:basics_samples/utils/navigation/nav_link.dart';
import 'package:basics_samples/utils/responsive_builder.dart';
import 'package:flutter/material.dart';

class ResponsivePageWrapper extends StatefulWidget {
  const ResponsivePageWrapper({
    super.key,
    required this.desktopBuilder,
    required this.mobileBuilder,
    required this.activeTabName,
  });

  final Widget Function(BuildContext) desktopBuilder;
  final Widget Function(BuildContext) mobileBuilder;
  final String activeTabName;

  @override
  State<ResponsivePageWrapper> createState() => _ResponsivePageWrapperState();
}

class _ResponsivePageWrapperState extends State<ResponsivePageWrapper> with SingleTickerProviderStateMixin {
  late final List<NavLink> navigationLinks;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    navigationLinks = [
      NavLink(
        onPressed: () => Navigator.of(context).pushNamed('/'),
        text: 'Home',
        isActive: widget.activeTabName == 'home',
      ),
      NavLink(
        onPressed: () => Navigator.of(context).pushNamed('/about'),
        text: 'About',
        isActive: widget.activeTabName == 'about',
      ),
      NavLink(
        onPressed: () => Navigator.of(context).pushNamed('/projects'),
        text: 'Projects',
        isActive: widget.activeTabName == 'projects',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NavDrawer(
        links: navigationLinks,
        onClose: () => scaffoldKey.currentState?.closeEndDrawer(),
      ),
      body: ResponsiveBuilder(
        desktopBuilder: (_) {
          if (scaffoldKey.currentState?.isEndDrawerOpen == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scaffoldKey.currentState?.closeEndDrawer();
            });
          }
          return DesktopView(
            navigationLinks: navigationLinks,
            desktopBuilder: widget.desktopBuilder,
          );
        },
        mobileBuilder: (_) => MobileView(
          onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          mobileBuilder: widget.mobileBuilder,
        ),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
    required this.navigationLinks,
    required this.desktopBuilder,
  });

  final List<NavLink> navigationLinks;
  final Widget Function(BuildContext) desktopBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NavBar(navigationLinks: navigationLinks),
        Expanded(
          child: desktopBuilder(context),
        )
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.onMenuPressed,
    required this.mobileBuilder,
  });

  final VoidCallback onMenuPressed;
  final Widget Function(BuildContext) mobileBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          mobileBuilder(context),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                onPressed: onMenuPressed,
                icon: const Icon(Icons.menu_rounded),
                color: Colors.white,
                hoverColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
