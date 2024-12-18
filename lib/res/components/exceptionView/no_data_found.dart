import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ride_on/gen/assets.gen.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            Assets.images.noItemFound,
            frameRate: const FrameRate(30),
          ),
        ],
      ),
    );
  }
}
