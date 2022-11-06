import 'package:basics_samples/utils/navigation/nav_link.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
    required this.links,
    required this.onClose,
  });

  final List<NavLink> links;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                  hoverColor: Colors.transparent,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: links,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
