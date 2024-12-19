import 'package:flutter/material.dart';
import 'package:ride_on/view/allTrips/all_trip_view.dart';

class PopularTripsTitle extends StatelessWidget {
  const PopularTripsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular trips",
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllTripsView(),
              ),
            );
          },
          child: const Text("See all"),
        )
      ],
    );
  }
}
