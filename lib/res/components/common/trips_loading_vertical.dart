import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TripsLoadingVertical extends StatelessWidget {
  const TripsLoadingVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.black.withOpacity(0.2),
      enabled: true,
      child: Container(
        width: size.width,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
