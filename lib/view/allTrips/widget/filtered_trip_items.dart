import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/view/seatLayout/seat_layout_view.dart';
import 'package:ride_on/view/home/widgets/date_and_seat.dart';
import 'package:ride_on/viewmodel/provider/tour_viewmodel.dart';

class FilteredTripItems extends StatelessWidget {
  const FilteredTripItems({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Consumer<TourViewmodel>(
      builder: (context, tour, child) => ListView.separated(
        itemCount: tour.filteredTripList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Gap(10),
        itemBuilder: (context, index) {
          final data = tour.filteredTripList[index];
          return data == null
              ? const Text("No data found")
              : Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(0),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatLayoutView(tourModel: data),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: size.width,
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   busImages[Random().nextInt(busImages.length - 1)],
                          //   height: 200,
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),
                          // const Gap(5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flex(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  data.name ?? '',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(5),
                                Text(
                                  data.layout ?? '',
                                  style: theme.textTheme.labelLarge!.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: .6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(10),
                                DateAndSeat(
                                  startDate: data.startDate ?? '',
                                  availableSeat: "${data.availableSeat ?? ''}",
                                ),
                                const Gap(10),
                                Flex(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      "₹${data.amount}",
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "Book Now",
                                        style: theme.textTheme.labelLarge!
                                            .copyWith(
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
