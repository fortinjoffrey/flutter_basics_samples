import 'package:basics_samples/utils/navigation/nav_link.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.navigationLinks,
  });

  final List<NavLink> navigationLinks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1024),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: navigationLinks,
        ),
      ),
    );
  }
}
