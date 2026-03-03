import 'package:cat_directory_app/blocs/breeds_detail.state.dart';
import 'package:cat_directory_app/blocs/breeds_detail_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/breed_service.dart';

class BreedDetailBloc extends Bloc<BreedDetailEvent, BreedDetailState> {
  final BreedService service;

  BreedDetailBloc(this.service) : super(const BreedDetailState()) {
    on<LoadRandomFact>(_onLoadRandomFact);
  }

  Future<void> _onLoadRandomFact(
    LoadRandomFact event,
    Emitter<BreedDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final fact = await service.fetchRandomFact();

      emit(state.copyWith(isLoading: false, fact: fact));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
