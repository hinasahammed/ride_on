import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
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

  List sliderList = [
    {
      "headline": "Travel Smoothly, Travel Smart",
      "subHeadline":
          "Book your bus tickets now and enjoy hassle-free journeys.",
      "image": "assets/images/slider1.jpg"
    },
    {
      "headline": "Travel Together, Save More",
      "subHeadline": "Group discounts available! Book with friends and family.",
      "image": "assets/images/slider2.png"
    },
    {
      "headline": "Experience Luxury on Wheels",
      "subHeadline":
          "Book AC, Sleeper, and Semi-Sleeper buses with top operators.",
      "image": "assets/images/slider3.jpg"
    },
    {
      "headline": "Discover the Magic",
      "subHeadline": "Book your bus tickets and explore the wonders ",
      "image": "assets/images/slider4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final tourController = Provider.of<TourViewmodel>(context, listen: false);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return tourController.tripTesting();
          },
          child: ListView(
            children: [
              // const HomeBanner(),
              const Padding(
                padding: EdgeInsets.all(16),
                child: HomeSearchOption(),
              ),
              const Gap(20),
              CarouselSlider(
                items: List.generate(
                  4,
                  (index) => Container(
                      width: double.infinity,
                      height: 180,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: .8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sliderList[index]['headline'],
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  sliderList[index]['subHeadline'],
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: theme.colorScheme.onPrimary
                                        .withValues(alpha: .5),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              sliderList[index]['image'],
                              fit: BoxFit.cover,
                              width: 100,
                              height: double.infinity,
                            ),
                          )
                        ],
                      )),
                ),
                options: CarouselOptions(
                  height: 180,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const Gap(20),
              const PopularTrips(),
              const Gap(20),
              const OffersCard(),
            ],
          ),
        ),
      ),
    );
  }
}
