import 'package:flutter/material.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/view/home/widgets/home_search_option.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: 300,
        ),
        Positioned(
          top: 0,
          child: Container(
            width: size.width,
            alignment: Alignment.centerLeft,
            height: 280,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              image: DecorationImage(
                image: Assets.images.bg2.provider(),
                fit: BoxFit.cover,
                opacity: .7,
              ),
            ),
            child: Text(
              "Where would you like to go ?",
              style: theme.textTheme.headlineLarge!.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 15,
          right: 15,
          child: HomeSearchOption(),
        )
      ],
    );
  }
}
