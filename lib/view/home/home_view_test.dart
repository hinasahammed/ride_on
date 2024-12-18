import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/res/components/exceptionView/no_data_found.dart';
import 'package:ride_on/res/components/loading/trips_loading_horizontal.dart.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/busLayout/bus_layout_test.dart';
import 'package:ride_on/view/onDeprecation/bookingDetails/widget/items.dart';
import 'package:ride_on/view/home/widgets/home_banner.dart';
import 'package:ride_on/view/home/widgets/popular_trips_title.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class HomeViewTest extends StatefulWidget {
  const HomeViewTest({super.key});

  @override
  State<HomeViewTest> createState() => _HomeViewTestState();
}

class _HomeViewTestState extends State<HomeViewTest> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var tourController = Provider.of<TourViewmodel>(context, listen: false);
      tourController.tripTesting();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final tourController = Provider.of<TourViewmodel>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   leading: Assets.images.rideOnLogo.image(),
      //   title: const Text("RideOn"),
      // ),
      body: RefreshIndicator(
        onRefresh: () {
          return tourController.tripTesting();
        },
        child: ListView(
          children: [
            const HomeBanner(),
            Consumer<TourViewmodel>(
              builder: (context, tour, child) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    const PopularTripsTitle(),
                    const Gap(10),
                    switch (tour.status) {
                      Status.loading => SizedBox(
                          height: 300,
                          child: ListView.separated(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const Gap(10),
                            itemBuilder: (context, index) =>
                                const TripsLoadingHorizontal(),
                          ),
                        ),
                      Status.error => const Text("No data found"),
                      Status.completed => tour.tripList.isEmpty
                          ? const Center(
                              child: NoDataFound(),
                            )
                          : SizedBox(
                              height: 380,
                              child: ListView.builder(
                                itemCount: tour.tripList.length < 5
                                    ? tour.tripList.length
                                    : 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var data = tour.tripList[index];
                                  return data == null
                                      ? const Text("No data found")
                                      : Card(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          clipBehavior: Clip.hardEdge,
                                          elevation: 4,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BusLayoutTest(
                                                          tourModel: data),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: size.width * .8,
                                              child: Flex(
                                                direction: Axis.vertical,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    busImages[Random().nextInt(
                                                        busImages.length - 1)],
                                                    height: 200,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const Gap(5),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Flex(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      direction: Axis.vertical,
                                                      children: [
                                                        Text(
                                                          data.name ?? '',
                                                          style: theme.textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .onSurface,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const Gap(5),
                                                        Items(
                                                          icon: Icons
                                                              .directions_bus,
                                                          title: "Layout:",
                                                          value:
                                                              data.layout ?? '',
                                                        ),
                                                        Items(
                                                          icon:
                                                              Icons.date_range,
                                                          title: "Start date:",
                                                          value:
                                                              data.startDate ??
                                                                  '',
                                                        ),
                                                        const Gap(5),
                                                        Flex(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          direction:
                                                              Axis.horizontal,
                                                          children: [
                                                            Text(
                                                              "₹${data.amount}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                "View Details",
                                                                style: theme
                                                                    .textTheme
                                                                    .labelLarge!
                                                                    .copyWith(
                                                                  color: theme
                                                                      .colorScheme
                                                                      .onPrimary,
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
                            ),
                    }
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
