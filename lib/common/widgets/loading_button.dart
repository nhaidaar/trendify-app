import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool invert;

  const LoadingButton({
    super.key,
    this.invert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9.5),
      decoration: BoxDecoration(
        color: invert
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: invert ? Theme.of(context).colorScheme.primary : Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: invert ? Theme.of(context).colorScheme.primary : Colors.white,
          ),
        ],
      ),
    );
  }
}
