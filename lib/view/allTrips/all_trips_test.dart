import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/res/components/textfield/custom_textformfield.dart';
import 'package:ride_on/res/components/loading/trips_loading_horizontal.dart.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/busLayout/bus_layout_test.dart';
import 'package:ride_on/view/onDeprecation/bookingDetails/widget/items.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class AllTripsTest extends StatefulWidget {
  const AllTripsTest({super.key});

  @override
  State<AllTripsTest> createState() => _AllTripsTestState();
}

class _AllTripsTestState extends State<AllTripsTest> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final tourViewmodel = Provider.of<TourViewmodel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Trips"),
        ),
        body: Consumer<TourViewmodel>(
          builder: (context, tour, child) {
            return RefreshIndicator(
              onRefresh: () {
                return tourViewmodel.fetchTourList(context);
              },
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  CustomTextformfield(
                    controller: searchController,
                    onChanged: (newValue) {
                      tourViewmodel.filterTrip(searchController.text);
                    },
                    prefix: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurface.withValues(alpha: .7),
                    ),
                    labelText: "Search Destinations",
                  ),
                  const Gap(20),
                  switch (tour.status) {
                    Status.loading => ListView.separated(
                        itemCount: 5,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Gap(10),
                        itemBuilder: (context, index) =>
                            const TripsLoadingHorizontal(),
                      ),
                    Status.error => const Center(
                        child: Text("Something Went wrong"),
                      ),
                    Status.completed => searchController.text.isEmpty
                        ? ListView.separated(
                            itemCount: tour.tripList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Gap(15),
                            itemBuilder: (context, index) {
                              final data = tour.tripList[index];
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
                                              builder: (context) =>
                                                  BusLayoutTest(
                                                      tourModel: data),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width: size.width,
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
                                                    const EdgeInsets.all(8.0),
                                                child: Flex(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Text(
                                                      data.name ?? '',
                                                      style: theme
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Gap(5),
                                                    Items(
                                                      icon:
                                                          Icons.directions_bus,
                                                      title: "Layout:",
                                                      value: data.layout ?? '',
                                                    ),
                                                    Items(
                                                      icon: Icons.date_range,
                                                      title: "Start date:",
                                                      value:
                                                          data.startDate ?? '',
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
                                                          style: theme.textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w700,
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
                          )
                        : tour.filteredTripList.isEmpty
                            ? SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "No Result Found!",
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: tour.filteredTripList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const Gap(10),
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
                                                  builder: (context) =>
                                                      BusLayoutTest(
                                                          tourModel: data),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: size.width,
                                              child: Flex(
                                                direction: Axis.vertical,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    tripImages[Random().nextInt(
                                                        tripImages.length - 1)],
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
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            "₹${data.amount}",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge!
                                                                .copyWith(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
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
                  }
                ],
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
