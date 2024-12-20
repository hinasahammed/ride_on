import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/res/components/text/label_large_text.dart';

class SeatStatus extends StatelessWidget {
  const SeatStatus({super.key, required this.color, required this.title});
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
        ),
        const Gap(5),
        LabelLargeText(text: title),
      ],
    );
  }
}
