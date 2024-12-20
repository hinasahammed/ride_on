import 'package:flutter/material.dart';

class LabelLargeText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const LabelLargeText({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.labelLarge!.copyWith(
        color: textColor ?? theme.colorScheme.onSurface,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
