import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/view/allTrips/all_trip_view.dart';

class PopularTripsTitle extends StatelessWidget {
  const PopularTripsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BodyLargeText(
          text: "Popular trips",
          fontWeight: FontWeight.bold,
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
