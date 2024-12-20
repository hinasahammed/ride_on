import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/button/custom_button.dart';
import 'package:ride_on/res/utils/utils.dart';
import 'package:ride_on/view/seatLayout/widget/booking_details.dart';
import 'package:ride_on/view/seatLayout/widget/checkout_items.dart';
import 'package:ride_on/view/seatLayout/widget/seat_status.dart';
import 'package:ride_on/viewmodel/provider/seat_layout_viewmodel.dart';

class SeatBookingSummary extends StatelessWidget {
  const SeatBookingSummary({super.key, required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<SeatLayoutViewmodel>(
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
                onPressed: () async {
                  // Utils().showBookinSuccess(context);
                  if (value.selectedSlot.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BookingDetails(),
                      ),
                    );
                  } else {
                    Utils().showToast("Select a seat to proceed");
                  }
                },
                btnText: "Proceed to Book",
              ),
            )
          ],
        ),
      ),
    );
  }
}
