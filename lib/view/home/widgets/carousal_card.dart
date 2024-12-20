import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/res/utils/constants/trip_images.dart';

class CarousalCard extends StatelessWidget {
  const CarousalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CarouselSlider(
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
              spacing: 5,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyLargeText(
                        text: sliderList[index]['headline'],
                        fontWeight: FontWeight.bold,
                        textColor: theme.colorScheme.onPrimary,
                      ),
                      Text(
                        sliderList[index]['subHeadline'],
                        style: theme.textTheme.bodySmall!.copyWith(
                          color:
                              theme.colorScheme.onPrimary.withValues(alpha: .5),
                        ),
                      )
                    ],
                  ),
                ),
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
        viewportFraction: 0.86,
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
    );
  }
}
