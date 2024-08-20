import 'package:flutter/material.dart';
import 'package:trendify/core/constant.dart';

class CustomField extends StatelessWidget {
  final String fieldTitle;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  const CustomField({
    super.key,
    required this.fieldTitle,
    this.focusNode,
    this.keyboardType,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: semiboldTS,
        ),
        const SizedBox(height: 12),
        CustomFieldOnly(
          focusNode: focusNode,
          keyboardType: keyboardType,
          controller: controller,
          hintText: hintText,
        )
      ],
    );
  }
}

class CustomFieldOnly extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool obscureText;
  final bool enabled;
  final VoidCallback? onTap;
  final String? hintText;
  const CustomFieldOnly({
    super.key,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabled: enabled,
        fillColor: enabled ? null : Theme.of(context).colorScheme.background,
        filled: !enabled,
        suffixIcon: isPassword
            ? InkWell(
                onTap: onTap,
                child: Ink(
                  child: ImageIcon(
                    AssetImage(
                      !obscureText ? 'assets/icons/password_visible.png' : 'assets/icons/password_invisible.png',
                    ),
                  ),
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: mediumTS.copyWith(fontSize: 14),
        contentPadding: const EdgeInsets.all(16),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
      ),
    );
  }
}
