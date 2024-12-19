import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/view/home/widgets/carousal_card.dart';
import 'package:ride_on/view/home/widgets/home_search_option.dart';
import 'package:ride_on/view/home/widgets/offers_card.dart';
import 'package:ride_on/view/home/widgets/popular_trips.dart';
import 'package:ride_on/viewmodel/provider/tour_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  @override
  Widget build(BuildContext context) {
    final tourController = Provider.of<TourViewmodel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return tourController.tripTesting();
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              HomeSearchOption(),
              Gap(20),
              CarousalCard(),
              Gap(20),
              PopularTrips(),
              Gap(20),
              OffersCard(),
            ],
          ),
        ),
      ),
    );
  }
}
