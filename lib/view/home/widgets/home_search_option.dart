import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/view/allTrips/all_trips_test.dart';

class HomeSearchOption extends StatelessWidget {
  const HomeSearchOption({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      transitionDuration: const Duration(milliseconds: 600),
      closedBuilder: (context, action) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: .3),
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Icon(
              Icons.search,
              color: theme.colorScheme.onSurface.withValues(alpha: .7),
            ),
            const Gap(10),
            Text(
              "Search Destinations",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .7),
              ),
            )
          ],
        ),
      ),
      openBuilder: (context, action) => const AllTripsTest(),
    );
  }
}
