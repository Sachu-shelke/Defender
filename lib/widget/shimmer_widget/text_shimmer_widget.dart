import 'package:flutter/material.dart';
import 'package:defenders/widget/shimmer_widget/shimmer_container.dart';

class TextShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  const TextShimmer(
      {super.key, this.width = 100, this.height = 10, this.radius = 6});

  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(radius)),
        height: height,
      ),
    );
  }
}
