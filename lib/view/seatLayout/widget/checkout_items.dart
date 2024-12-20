import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/label_large_text.dart';

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
        LabelLargeText(
          text: title,
          fontWeight: FontWeight.w600,
        ),
        LabelLargeText(
          text: value,
          textColor: theme.colorScheme.onSurface.withValues(alpha: .6),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
