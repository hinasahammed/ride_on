import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.prefix,
    this.onChanged,
    this.prefixText,
  });
  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: .3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: .3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: .3),
          ),
        ),
        labelText: labelText,
        filled: true,
        fillColor: theme.colorScheme.surface,
        prefixIcon: prefix,
        prefixText: prefixText,
      ),
    );
  }
}
