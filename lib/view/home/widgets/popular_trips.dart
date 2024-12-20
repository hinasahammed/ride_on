import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/res/components/exceptionView/no_data_found.dart';
import 'package:ride_on/res/components/loading/shimmer_loading.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/res/components/text/label_large_text.dart';
import 'package:ride_on/view/seatLayout/seat_layout_view.dart';
import 'package:ride_on/view/home/widgets/date_and_seat.dart';
import 'package:ride_on/view/home/widgets/popular_trips_title.dart';
import 'package:ride_on/viewmodel/provider/all_trips_viewmodel.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Consumer<AllTripsViewmodel>(
      builder: (context, tour, child) => Flex(
        spacing: 10,
        direction: Axis.vertical,
        children: [
          const PopularTripsTitle(),
          switch (tour.status) {
            Status.loading => ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Gap(10),
                itemBuilder: (context, index) => const ShimmerLoading(),
              ),
            Status.error => const Text("Something Went Wrong"),
            Status.completed => tour.tripList.isEmpty
                ? const Center(
                    child: NoDataFound(),
                  )
                : SizedBox(
                    height: 210,
                    child: ListView.separated(
                      itemCount: tour.tripList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 8),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const Gap(10),
                      itemBuilder: (context, index) {
                        var data = tour.tripList[index];
                        return data == null
                            ? const Text("No data found")
                            : Card(
                                margin: const EdgeInsets.all(0),
                                clipBehavior: Clip.hardEdge,
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SeatLayoutView(tourModel: data),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: size.width * .8,
                                    child: Flex(
                                      direction: Axis.vertical,
                                      spacing: 5,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image.asset(
                                        //   busImages[Random().nextInt(
                                        //       busImages.length - 1)],
                                        //   height: 200,
                                        //   width: double.infinity,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        // const Gap(5),
                                        Text(
                                          data.name ?? '',
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          data.layout ?? '',
                                          style: theme.textTheme.labelLarge!
                                              .copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: .6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        DateAndSeat(
                                          startDate: data.startDate ?? '',
                                          availableSeat:
                                              "${data.availableSeat ?? ''}",
                                        ),

                                        Flex(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          direction: Axis.horizontal,
                                          children: [
                                            BodyLargeText(
                                              text: "₹${data.amount}",
                                              textColor:
                                                  theme.colorScheme.primary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: LabelLargeText(
                                                text: "Book now",
                                                textColor:
                                                    theme.colorScheme.onPrimary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
          }
        ],
      ),
    );
  }
}
