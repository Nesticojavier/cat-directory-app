import 'package:cat_directory_app/api_client.dart';
import 'package:cat_directory_app/blocs/breeds_bloc.dart';
import 'package:cat_directory_app/screens/breeds_screen.dart';
import 'package:cat_directory_app/services/breed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final apiClient = ApiClient();
  final breedService = BreedService(apiClient.dio);

  runApp(MainApp(breedService: breedService));
}

class MainApp extends StatelessWidget {
  final BreedService breedService;

  const MainApp({super.key, required this.breedService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => BreedsBloc(breedService),
        child: BreedsScreen(),
      ),
    );
  }
}
