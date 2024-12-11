import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/res/components/common/custom_textformfield.dart';
import 'package:ride_on/view/allTrips/widgets/all_trips_item_card.dart';
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
    final theme = Theme.of(context);
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
            const AllTripsItemCard(),
          ],
        ),
      ),
    );
  }
}
