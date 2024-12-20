import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/button/custom_button.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/res/components/text/label_large_text.dart';
import 'package:ride_on/res/components/textfield/custom_textformfield.dart';
import 'package:ride_on/viewmodel/provider/seat_layout_viewmodel.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Details"),
      ),
      body: Consumer<SeatLayoutViewmodel>(builder: (context, value, child) {
        value.selectedSlot
            .sort((a, b) => a.slotNumber!.compareTo(b.slotNumber!));
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      value.selectedSlot.length,
                      (index) => Card(
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          color: theme.colorScheme.surface,
                          child: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BodyLargeText(
                                    text: "Passenger ${index + 1}",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  BodyLargeText(
                                    text:
                                        "Seat ${value.selectedSlot[index].slotNumber ?? ''}",
                                    textColor: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const CustomTextformfield(
                                labelText: "Enter Name",
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String?>(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: theme.colorScheme.surface,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: .3),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: .3),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: .3),
                                          ),
                                        ),
                                      ),
                                      value: "Male",
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Male",
                                          child: Text("Male"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Female",
                                          child: Text("Female"),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  const Expanded(
                                    child: CustomTextformfield(
                                      labelText: "Age",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        color: theme.colorScheme.surface,
                        child: const Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyLargeText(
                              text: "Contact Details",
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextformfield(
                              labelText: "Enter Email",
                            ),
                            CustomTextformfield(
                              prefixText: "+91",
                              labelText: "Enter Phone",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: Flex(
                spacing: 10,
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const BodyLargeText(text: "Seats: "),
                      ...value.selectedSlot.map(
                        (e) => LabelLargeText(text: "${e.slotNumber ?? ''}, "),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () {},
                      btnText: "Proceed to Payment",
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
