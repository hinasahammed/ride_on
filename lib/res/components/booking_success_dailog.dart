import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/res/components/button/custom_button.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';

class BookingSuccessDailog extends StatelessWidget {
  const BookingSuccessDailog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          Assets.images.bookingSuccess,
          repeat: false,
          width: 150,
          height: 150,
        ),
        const BodyLargeText(
          text: "Booking Successful!",
          fontWeight: FontWeight.w600,
        ),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Reference",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const BodyLargeText(text: "BUS-2024-8559"),
              ],
            ),
            Icon(
              Icons.copy,
              color: theme.colorScheme.onSurface,
            )
          ],
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: CustomButton(
            onPressed: () {
              Navigator.pop(context);
            },
            btnText: "Continue",
          ),
        )
      ],
    );
  }
}
