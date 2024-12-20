import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/res/components/text/label_large_text.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyLargeText(
          text: "Offers",
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: List.generate(
                3,
                (index) => Container(
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withValues(alpha: .8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyLargeText(
                        text: "Save 50% on your next trip",
                        textColor: theme.colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                      LabelLargeText(
                        text: "Valid till: 31 Dec",
                        textColor: theme.colorScheme.surface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
