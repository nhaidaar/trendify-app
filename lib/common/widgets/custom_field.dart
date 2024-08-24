import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendify/core/constant.dart';

class CustomField extends StatelessWidget {
  final String fieldTitle;
  final List<TextInputFormatter>? textInputFormatter;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool obscureText;
  final bool enabled;
  final VoidCallback? onTap;
  final String? hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  const CustomField({
    super.key,
    required this.fieldTitle,
    this.textInputFormatter,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
    this.hintText,
    this.validator,
    this.autoValidateMode,
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
          textInputFormatter: textInputFormatter,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          isPassword: isPassword,
          obscureText: obscureText,
          enabled: enabled,
          onTap: onTap,
          hintText: hintText,
          validator: validator,
          autoValidateMode: autoValidateMode,
        )
      ],
    );
  }
}

class CustomFieldOnly extends StatelessWidget {
  final List<TextInputFormatter>? textInputFormatter;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool obscureText;
  final bool enabled;
  final VoidCallback? onTap;
  final String? hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  const CustomFieldOnly({
    super.key,
    this.textInputFormatter,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
    this.hintText,
    this.validator,
    this.autoValidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: textInputFormatter,
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
                      !obscureText
                          ? 'assets/icons/password_visible.png'
                          : 'assets/icons/password_invisible.png',
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
      validator: validator,
      autovalidateMode: autoValidateMode,
    );
  }
}
