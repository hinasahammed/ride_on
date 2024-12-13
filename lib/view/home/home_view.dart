import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/trips_loading_horizontal.dart.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/bookingDetails/widget/items.dart';
import 'package:ride_on/view/busLayout/bus_layout_view.dart';
import 'package:ride_on/view/home/widgets/home_banner.dart';
import 'package:ride_on/view/home/widgets/popular_trips_title.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    refreshData(context);
  }

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<TourViewmodel>(context, listen: false)
        .fetchTourList(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeController = Provider.of<TourViewmodel>(context, listen: false);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      // appBar: AppBar(
      //   leading: Assets.images.rideOnLogo.image(),
      //   title: const Text("RideOn"),
      // ),
      body: RefreshIndicator(
        onRefresh: () {
          return refreshData(context);
        },
        child: ListView(
          children: [
            const HomeBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  const PopularTripsTitle(),
                  const Gap(10),
                  FutureBuilder(
                    future: homeController.fetchTourList(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 300,
                          child: ListView.separated(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const Gap(10),
                            itemBuilder: (context, index) =>
                                const TripsLoadingHorizontal(),
                          ),
                        );
                      }
                      if (!snapshot.hasData ||
                          snapshot.data?.data == null ||
                          snapshot.data!.data!.isEmpty) {
                        return const Center(
                          child: Text("No Trip found"),
                        );
                      } else {
                        return SizedBox(
                          height: 380,
                          child: ListView.builder(
                            itemCount: snapshot.data!.data!.length < 5
                                ? snapshot.data!.data!.length
                                : 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.data![index];
                              return Card(
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
                                            BusLayoutView(tourModel: data),
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
                                          tripImages[Random()
                                              .nextInt(tripImages.length - 1)],
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        const Gap(5),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Gap(5),
                                              Items(
                                                icon: Icons.directions_bus,
                                                title: "Layout:",
                                                value: data.layout ?? '',
                                              ),
                                              Items(
                                                icon: Icons.date_range,
                                                title: "Start date:",
                                                value: data.startDate ?? '',
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "₹${data.amount}",
                                                  style: theme
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: theme
                                                        .colorScheme.primary,
                                                    fontWeight: FontWeight.w700,
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
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
