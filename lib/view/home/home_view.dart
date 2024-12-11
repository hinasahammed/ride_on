
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/view/home/widgets/home_banner.dart';
import 'package:ride_on/view/home/widgets/popular_trip_item_container.dart';
import 'package:ride_on/view/home/widgets/popular_trips_title.dart';
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return refreshData(context);
        },
        child: ListView(
          children: const [
            HomeBanner(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  PopularTripsTitle(),
                  Gap(10),
                  PopularTripItemContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
