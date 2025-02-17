import 'package:flutter/material.dart';
import 'package:defenders/widget/shimmer_widget/shimmer_container.dart';

class CircleShimmerWidget extends StatelessWidget {
  final double radius;

  const CircleShimmerWidget({super.key, this.radius = 40});

  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      child: CircleAvatar(
        radius: radius,
      ),
    );
  }
}
