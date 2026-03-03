import 'package:flutter/material.dart';
import 'breed_row_skeleton.dart';

class BreedSkeleton extends StatelessWidget {
  const BreedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const BreedRowSkeleton();
      },
    );
  }
}
