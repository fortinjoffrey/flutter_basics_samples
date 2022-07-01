import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardInputControlsWidget extends StatelessWidget {
  const KeyboardInputControlsWidget({
    Key? key,
    this.onBackPressed,
    this.onNextPressed,
    this.onDonePressed,
    this.controlsColor = CupertinoColors.activeBlue,
  }) : super(key: key);
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final VoidCallback? onDonePressed;
  final Color controlsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.extraLightBackgroundGray,
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 16.0),
        child: Row(
          children: [
            if (onBackPressed != null) ...[
              _NavigationIcon(
                onPressed: onBackPressed!,
                iconData: Icons.keyboard_arrow_up_outlined,
                color: controlsColor,
              ),
            ],
            if (onBackPressed != null && onNextPressed != null) ...[
              const SizedBox(width: 16.0),
            ],
            if (onNextPressed != null) ...[
              _NavigationIcon(
                onPressed: onNextPressed!,
                iconData: Icons.keyboard_arrow_down_outlined,
                color: controlsColor,
              ),
            ],
            Spacer(),
            CupertinoButton(
              padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
              onPressed: () {
                if (onDonePressed != null) {
                  onDonePressed?.call();
                  return;
                }
                FocusScope.of(context).unfocus();
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: controlsColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationIcon extends StatelessWidget {
  const _NavigationIcon({
    Key? key,
    required this.onPressed,
    required this.iconData,
    required this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        iconData,
        size: 32,
        color: color,
      ),
    );
  }
}
