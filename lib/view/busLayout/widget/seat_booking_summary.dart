import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/custom_button.dart';
import 'package:ride_on/view/busLayout/widget/checkout_items.dart';
import 'package:ride_on/view/busLayout/widget/seat_status.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

class SeatBookingSummary extends StatelessWidget {
  const SeatBookingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TourController>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SeatStatus(
                  color: theme.colorScheme.surface,
                  title: "Available",
                ),
                SeatStatus(
                  color: theme.colorScheme.primaryContainer,
                  title: "Booked",
                ),
                SeatStatus(
                  color: theme.colorScheme.primary,
                  title: "Selected",
                ),
              ],
            ),
            const Divider(),
            const Gap(10),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CheckoutItems(
                  title: "Ticket Price",
                  value: "₹200",
                ),
                const CheckoutItems(
                  title: "Total Price",
                  value: "₹400",
                ),
                CheckoutItems(
                  title: "Selected Seat",
                  value: "${value.selectedSlot.length} Seat",
                )
              ],
            ),
            const Divider(),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () {},
                btnText: "Book Now",
              ),
            )
          ],
        ),
      ),
    );
  }
}
