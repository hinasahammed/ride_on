import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/custom_button.dart';
import 'package:ride_on/res/utils/utils.dart';
import 'package:ride_on/view/busLayout/widget/checkout_items.dart';
import 'package:ride_on/view/busLayout/widget/seat_status.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class SeatBookingSummary extends StatelessWidget {
  const SeatBookingSummary({super.key, required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TourViewmodel>(
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
                CheckoutItems(
                  title: "Ticket Price",
                  value: "₹$price",
                ),
                CheckoutItems(
                  title: "Total Price",
                  value: "₹${value.selectedSlot.length * price}",
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
                onPressed: () {
                  Utils().showBookinSuccess(context);
                },
                btnText: "Book Now",
              ),
            )
          ],
        ),
      ),
    );
  }
}
