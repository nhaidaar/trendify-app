import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final String icon;
  final double size;
  final bool active;
  const PostButton({
    super.key,
    required this.icon,
    this.size = 24,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(icon),
      size: size,
      color: !active
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.primary,
    );
  }
}
