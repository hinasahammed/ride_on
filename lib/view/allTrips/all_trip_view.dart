import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/res/components/textfield/custom_textformfield.dart';
import 'package:ride_on/res/components/loading/shimmer_loading.dart';
import 'package:ride_on/view/allTrips/widget/all_trips_items.dart';
import 'package:ride_on/view/allTrips/widget/filtered_trip_items.dart';
import 'package:ride_on/viewmodel/provider/tour_viewmodel.dart';

class AllTripsView extends StatefulWidget {
  const AllTripsView({super.key});

  @override
  State<AllTripsView> createState() => _AllTripsViewState();
}

class _AllTripsViewState extends State<AllTripsView> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                return tourViewmodel.tripTesting();
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
                    Status.loading => const ShimmerLoading(),
                    Status.error => const Center(
                        child: Text("Something Went wrong"),
                      ),
                    Status.completed => searchController.text.isEmpty
                        ? const AllTripsItems()
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
                            : const FilteredTripItems(),
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
