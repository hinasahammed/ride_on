import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';
import 'package:ride_on/res/components/trips_loading.dart';
import 'package:ride_on/view/bookingDetails/booking_details.dart';
import 'package:ride_on/viewmodel/controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    ApiStorageRepo().fetchTourBooking();
  }

  List<String> images = [
    "assets/images/bg1.jpg",
    "assets/images/bg2.jpg",
    "assets/images/bg3.jpg",
    "assets/images/bg4.jpg",
    "assets/images/bg5.jpg",
    "assets/images/bg6.jpg",
    "assets/images/bg7.jpg",
    "assets/images/bg8.jpg",
    "assets/images/bg9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final homeController = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Trips"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
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
                    Text("Find Your Next Trip",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        )),
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
            Text(
              "Trips",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Expanded(
              child: FutureBuilder(
                future: homeController.fetchTourList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) => const Gap(10),
                      itemBuilder: (context, index) => const TripsLoading(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: Text("No Trip found"),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data!.data!.length,
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
                                  builder: (context) => BookingDetails(
                                    tourModel: data,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: size.width,
                              height: 220,
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    images[Random().nextInt(images.length - 1)],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(.6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Flex(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      data.name ?? '',
                                      style:
                                          theme.textTheme.labelLarge!.copyWith(
                                        color: theme.colorScheme.surface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Image.asset(
                                          "assets/icons/seat.png",
                                          width: 30,
                                        ),
                                        const Gap(5),
                                        Text(
                                          "Available: ${data.availableSeat} ",
                                          style: theme.textTheme.labelLarge!
                                              .copyWith(
                                            color: theme.colorScheme.surface,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "₹${data.amount}",
                                      style:
                                          theme.textTheme.labelLarge!.copyWith(
                                        color:
                                            theme.colorScheme.primaryContainer,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
