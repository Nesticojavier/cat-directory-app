import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BreedRowSkeleton extends StatelessWidget {
  const BreedRowSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 100, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Container(width: 20, height: 48, color: Colors.white),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
