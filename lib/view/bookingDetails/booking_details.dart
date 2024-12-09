import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/res/components/custom_button.dart';
import 'package:ride_on/view/bookingDetails/widget/items.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key, required this.tourModel});
  final Datum tourModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              margin: const EdgeInsets.all(0),
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      tourModel.name ?? '',
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   
                    const Gap(16),
                    const Divider(),
                    Items(
                      icon: Icons.folder,
                      title: "File No:",
                      value: tourModel.fileNo ?? '',
                    ),
                    Items(
                      icon: Icons.directions_bus,
                      title: "Vehicle:",
                      value: tourModel.layout ?? '',
                    ),
                    Items(
                      icon: Icons.calendar_today,
                      title: "No. of Days:",
                      value: "${tourModel.noOfDays ?? ''}",
                    ),
                    Items(
                      icon: Icons.money,
                      title: "Advance Amount:",
                      value: "₹${tourModel.minimumAdvanceAmt ?? ''}",
                    ),
                    Items(
                      icon: Icons.event_seat,
                      title: "Available Seat:",
                      value: "${tourModel.availableSeat ?? ''}",
                    ),
                    Items(
                      icon: Icons.date_range,
                      title: "Start Date:",
                      value: tourModel.startDate ?? '',
                    ),
                    Items(
                      icon: Icons.date_range,
                      title: "End Date:",
                      value: tourModel.endDate ?? '',
                    ),
                    Items(
                      icon: Icons.location_on,
                      title: "Boarding Point:",
                      value: tourModel.boardingPoint ?? '',
                    ),
                    Items(
                      icon: Icons.location_on,
                      title: "Boarding Time:",
                      value: tourModel.boardingTime ?? '',
                    ),
                    Items(
                      icon: Icons.warning,
                      title: "Booking End:",
                      value: tourModel.bookingEndDate ?? '',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Card(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${tourModel.amount ?? ''}",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(16),
                  CustomButton(
                    onPressed: () {},
                    btnText: "Book Now",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
