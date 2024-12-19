import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.white54,
        highlightColor: Colors.black.withValues(alpha: 0.2),
        enabled: true,
        child: Container(
          width: size.width * .8,
          height: 210,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
