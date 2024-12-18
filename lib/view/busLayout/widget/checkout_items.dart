import 'package:flutter/material.dart';

class CheckoutItems extends StatelessWidget {
  const CheckoutItems({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: .6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
