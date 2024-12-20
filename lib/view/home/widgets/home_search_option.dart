import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/view/allTrips/all_trip_view.dart';

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
          spacing: 10,
          direction: Axis.horizontal,
          children: [
            Icon(
              Icons.search,
              color: theme.colorScheme.onSurface.withValues(alpha: .7),
            ),
            BodyLargeText(
              text: "Search Destinations",
              textColor: theme.colorScheme.onSurface.withValues(alpha: .7),
            ),
          ],
        ),
      ),
      openBuilder: (context, action) => const AllTripsView(),
    );
  }
}
