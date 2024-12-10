import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/trips_loading.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/allTrips/all_trips.dart';
import 'package:ride_on/view/busLayout/bus_layout.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

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
    await Provider.of<TourController>(context, listen: false)
        .fetchTourList(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final homeController = Provider.of<TourController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Trips"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refreshData(context);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(.3),
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurface.withOpacity(.7),
                  ),
                  const Gap(10),
                  Text(
                    "Search Destinations",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.7),
                    ),
                  )
                ],
              ),
            ),
            const Gap(10),
            Card(
              margin: const EdgeInsets.all(0),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find Your Next Trip",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Explore destinations, book tours, and more.",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onPrimary.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular trips",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllTrips(),
                      ),
                    );
                  },
                  child: const Text("See all"),
                )
              ],
            ),
            const Gap(10),
            FutureBuilder(
              future: homeController.fetchTourList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) => const TripsLoading(),
                  );
                }
                if (!snapshot.hasData ||
                    snapshot.data?.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return const Center(
                    child: Text("No Trip found"),
                  );
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.data![index];
                      return Card( 
                        margin: const EdgeInsets.all(0),
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BusLayout(tourModel: data),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: size.width,
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  tripImages[
                                      Random().nextInt(tripImages.length - 1)],
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
                                        style: theme.textTheme.labelLarge!
                                            .copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text(
                                            "Available Seat: ${data.availableSeat} ",
                                            style: theme.textTheme.labelLarge!
                                                .copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                          ),
                                          const Gap(5),
                                        ],
                                      ),
                                      Text(
                                        "₹${data.amount}",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.w700,
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
                  );
                }
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //   child: GNav(
      //     color: theme.colorScheme.primary,
      //     activeColor: theme.colorScheme.onPrimary,
      //     tabBackgroundColor: theme.colorScheme.primary,
      //     gap: 8,
      //     padding: const EdgeInsets.all(12),
      //     onTabChange: (newIndex) {},
      //     tabs: const [
      //       GButton(
      //         icon: Icons.home_filled,
      //         text: 'Home',
      //       ),
      //       GButton(
      //         icon: Icons.search,
      //         text: 'Search',
      //       ),
      //       GButton(
      //         icon: Icons.person,
      //         text: 'Account',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
