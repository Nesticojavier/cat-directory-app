import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/breed_service.dart';
import 'breeds_event.dart';
import 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  final BreedService service;

  BreedsBloc(this.service) : super(const BreedsState()) {
    on<LoadBreeds>(_onLoadBreeds);
    // here other event handlles
  }

  /// Initial load of breeds
  Future<void> _onLoadBreeds(
    LoadBreeds event,
    Emitter<BreedsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final breeds = await service.fetchBreeds(1);

      emit(state.copyWith(breeds: breeds, isLoading: false, page: 1));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
