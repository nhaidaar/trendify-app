import 'package:flutter/material.dart';

import '../../core/constant.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double titleSize;
  final double padding;
  final bool invert;
  final bool disabled;
  final VoidCallback? onTap;
  final Color? buttonColor;
  const CustomButton(
      {super.key,
      required this.title,
      this.titleSize = 16,
      this.padding = 16,
      this.onTap,
      this.invert = false,
      this.disabled = false,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: invert
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: invert ? Theme.of(context).colorScheme.primary : Colors.transparent,
            ),
          ),
          child: Text(
            title,
            style: semiboldTS.copyWith(
              color: invert ? Theme.of(context).colorScheme.primary : Colors.white,
              fontSize: titleSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
