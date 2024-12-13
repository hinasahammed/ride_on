import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/custom_textformfield.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/bookingDetails/widget/items.dart';
import 'package:ride_on/view/busLayout/bus_layout_view.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class AllTripsTest extends StatefulWidget {
  const AllTripsTest({super.key});

  @override
  State<AllTripsTest> createState() => _AllTripsTestState();
}

class _AllTripsTestState extends State<AllTripsTest> {
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

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Trips"),
        ),
        body: Consumer<TourViewmodel>(
          builder: (context, tour, child) {
            var filteredList = tour.tripList
                .where(
                  (element) => element!.name == searchController.text,
                )
                .toList();
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                CustomTextformfield(
                  onChanged: (newValue) {
                    setState(() {});
                  },
                  prefix: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurface.withOpacity(.7),
                  ),
                  labelText: "Search Destinations",
                ),
                const Gap(20),
                ListView.separated(
                  itemCount: filteredList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    final data = filteredList[index];
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
                                        BusLayoutView(tourModel: data),
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
                                            style: theme.textTheme.labelLarge!
                                                .copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
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
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              "₹${data.amount}",
                                              style: theme.textTheme.titleLarge!
                                                  .copyWith(
                                                color:
                                                    theme.colorScheme.primary,
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
              ],
            );
          },
        ));
  }
}
