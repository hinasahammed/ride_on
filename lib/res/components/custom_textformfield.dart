import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.prefix,
  });
  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(.3),
          ),
        ),
        labelText: labelText,
        filled: true,
        fillColor: theme.colorScheme.surface,
        prefixIcon: prefix,
      ),
    );
  }
}
