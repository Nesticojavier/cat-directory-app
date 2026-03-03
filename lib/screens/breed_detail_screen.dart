import 'package:cat_directory_app/blocs/breeds_detail.state.dart';
import 'package:cat_directory_app/blocs/breeds_detail_bloc.dart';
import 'package:cat_directory_app/blocs/breeds_detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/breed_model.dart';

class BreedDetailScreen extends StatefulWidget {
  final BreedModel breed;

  const BreedDetailScreen({super.key, required this.breed});

  @override
  State<BreedDetailScreen> createState() => _BreedDetailScreenState();
}

class _BreedDetailScreenState extends State<BreedDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BreedDetailBloc>().add(LoadRandomFact());
  }

  @override
  Widget build(BuildContext context) {
    final breed = widget.breed;

    return Scaffold(
      appBar: AppBar(title: Text(breed.breed)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Country: ${breed.country}"),
            Text("Origin: ${breed.origin}"),
            Text("Coat: ${breed.coat}"),
            Text("Pattern: ${breed.pattern}"),
            const SizedBox(height: 24),

            const Text(
              "Random Fact",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            BlocBuilder<BreedDetailBloc, BreedDetailState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }

                if (state.error != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.error!),
                      TextButton(
                        onPressed: () {
                          context.read<BreedDetailBloc>().add(LoadRandomFact());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  );
                }

                return Text(state.fact ?? "");
              },
            ),
          ],
        ),
      ),
    );
  }
}
