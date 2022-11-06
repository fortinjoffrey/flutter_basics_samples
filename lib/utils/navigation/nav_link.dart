import 'package:flutter/material.dart';

class NavLink extends StatelessWidget {
  const NavLink({
    super.key,
    required this.onPressed,
    required this.text,
    this.isActive = false,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Stack(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
          if (isActive)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
