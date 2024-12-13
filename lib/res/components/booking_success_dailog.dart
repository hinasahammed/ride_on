import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/res/components/common/custom_button.dart';

class BookingSuccessDailog extends StatelessWidget {
  const BookingSuccessDailog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          Assets.images.bookingSuccess,
          repeat: false,
          width: 150,
          height: 150,
        ),
        Text(
          "Booking Successful!",
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(20),
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
                Text(
                  "BUS-2024-8559",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.copy,
              color: theme.colorScheme.onSurface,
            )
          ],
        ),
        const Gap(20),
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
