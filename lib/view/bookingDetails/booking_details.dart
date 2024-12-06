import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/model/tour_model/datum.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      tourModel.name ?? '',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "₹${tourModel.amount}",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            Card(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                color: theme.colorScheme.primaryContainer,
                padding: const EdgeInsets.all(8),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "File No: ${tourModel.fileNo ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Vehicle: ${tourModel.layout ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "No-of days: ${tourModel.noOfDays ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Advance Amount: ₹${tourModel.minimumAdvanceAmt ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        const Icon(
                          Icons.chair,
                        ),
                        const Gap(10),
                        Text(
                          "Seat: ${tourModel.availableSeat ?? ''}/${tourModel.maximumSeat ?? ''}",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    Text(
                      "Startdate: ${tourModel.startDate ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Enddate: ${tourModel.endDate ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Boarding Point: ${tourModel.boardingPoint ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Boarding Time: ${tourModel.boardingTime ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Booking end: ${tourModel.bookingEndDate ?? ''}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
