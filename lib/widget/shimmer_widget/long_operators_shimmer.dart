import 'package:flutter/material.dart';
import 'package:defenders/widget/shimmer_widget/shimmer_container.dart';
import 'package:defenders/widget/shimmer_widget/text_shimmer_widget.dart';

import 'circle_shimmer_widget.dart';

class LongOperatorsShimmer extends StatelessWidget {
  const LongOperatorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, state) => const LongOperatorListContainer(
        child: ShimmerContainer(
          child: Row(
            children: [
              SizedBox(width: 10),
              CircleShimmerWidget(
                radius: 24,
              ),
              SizedBox(
                width: 10,
              ),
              TextShimmer(
                width: 260,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LongOperatorListContainer extends StatelessWidget {
  final Widget? child;

  const LongOperatorListContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
