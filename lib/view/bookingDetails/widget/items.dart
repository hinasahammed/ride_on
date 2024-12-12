import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Items extends StatelessWidget {
  const Items(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      this.color});
  final IconData icon;
  final String title;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(8),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
