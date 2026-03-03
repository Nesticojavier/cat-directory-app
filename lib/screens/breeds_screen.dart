import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/breeds_bloc.dart';
import '../blocs/breeds_event.dart';
import '../blocs/breeds_state.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BreedsBloc>().add(LoadBreeds());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<BreedsBloc>().add(LoadMoreBreeds());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cat Directory")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search breeds...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<BreedsBloc>().add(SearchBreeds(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<BreedsBloc, BreedsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null && state.breeds.isEmpty) {
                  return Center(child: Text(state.error!));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<BreedsBloc>().add(RefreshBreeds());
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.breeds.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.breeds.length) {
                        final breed = state.breeds[index];
                        return ListTile(
                          title: Text(breed.breed),
                          subtitle: Text(breed.country),
                        );

                        // last item for loading indicator
                      } else {
                        if (state.isFetchingMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return const SizedBox();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
