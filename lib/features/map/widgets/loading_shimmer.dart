import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  Color get base => Colors.grey.shade500;
  Color get highlight => Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Shimmer.fromColors(
            baseColor: base,
            highlightColor: highlight,
            child: Container(
              color: Colors.white,
              height: 200,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          5,
              (i) => Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Shimmer.fromColors(
              baseColor: base,
              highlightColor: highlight,
              child: const TilePlaceholder(width: double.infinity),
            ),
          ),
        ),
      ],
    );
  }
}

class TilePlaceholder extends StatelessWidget {
  final double width;

  const TilePlaceholder({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: 100,
            height: 20,
          ),
        ],
      ),
    );
  }
}