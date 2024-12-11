import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/no_data_found.dart';
import 'package:ride_on/res/components/common/trips_loading_horizontal.dart.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';
import 'package:ride_on/view/busLayout/bus_layout.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

class AllTripsItemCard extends StatefulWidget {
  const AllTripsItemCard({super.key});

  @override
  State<AllTripsItemCard> createState() => _AllTripsItemCardState();
}

class _AllTripsItemCardState extends State<AllTripsItemCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final homeController = Provider.of<TourController>(context, listen: false);
    return FutureBuilder(
      future: homeController.fetchTourList(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Gap(10),
            itemBuilder: (context, index) => const TripsLoadingHorizontal(),
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
                        builder: (context) => BusLayout(tourModel: data),
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
                          tripImages[Random().nextInt(tripImages.length - 1)],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const Gap(5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flex(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            direction: Axis.vertical,
                            children: [
                              Text(
                                data.name ?? '',
                                style: theme.textTheme.labelLarge!.copyWith(
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
                                    style: theme.textTheme.labelLarge!.copyWith(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const Gap(5),
                                ],
                              ),
                              Text(
                                "₹${data.amount}",
                                style: theme.textTheme.bodyLarge!.copyWith(
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
    );
  }
}
