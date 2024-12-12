import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/custom_textformfield.dart';
import 'package:ride_on/res/components/common/no_data_found.dart';
import 'package:ride_on/res/components/common/trips_loading_horizontal.dart.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/bookingDetails/widget/items.dart';
import 'package:ride_on/view/busLayout/bus_layout.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({super.key});

  @override
  State<AllTrips> createState() => _AllTripsState();
}

class _AllTripsState extends State<AllTrips> {
  Future<void> refreshData(BuildContext context) async {
    await Provider.of<TourController>(context, listen: false)
        .fetchTourList(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final homeController = Provider.of<TourController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Trips"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refreshData(context);
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CustomTextformfield(
              prefix: Icon(
                Icons.search,
                color: theme.colorScheme.onSurface.withOpacity(.7),
              ),
              labelText: "Search Destinations",
            ),
            const Gap(20),
            FutureBuilder(
              future: homeController.fetchTourList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) =>
                        const TripsLoadingHorizontal(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
                if (!snapshot.hasData ||
                    snapshot.data?.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return SizedBox(
                      width: size.width,
                      height: size.height * .7,
                      child: const NoDataFound());
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.data![index];
                      return Card(
                        clipBehavior: Clip.hardEdge,
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
                                      const Divider(),
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
                                      const Divider(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "₹${data.amount}",
                                          style: theme.textTheme.titleLarge!
                                              .copyWith(
                                            color: theme.colorScheme.primary,
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
