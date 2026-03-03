import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/breed_service.dart';
import 'breeds_event.dart';
import 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  final BreedService service;

  BreedsBloc(this.service) : super(const BreedsState()) {
    on<LoadBreeds>(_onLoadBreeds);
    on<RefreshBreeds>(_onRefreshBreeds);
    on<LoadMoreBreeds>(_onLoadMoreBreeds);
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

  Future<void> _onRefreshBreeds(
    RefreshBreeds event,
    Emitter<BreedsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final breeds = await service.fetchBreeds(1);

      emit(
        state.copyWith(
          breeds: breeds,
          isLoading: false,
          page: 1,
          hasReachedMax: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Load more breeds for pagination
  Future<void> _onLoadMoreBreeds(
    LoadMoreBreeds event,
    Emitter<BreedsState> emit,
  ) async {
    if (state.isFetchingMore || state.hasReachedMax) return;

    emit(state.copyWith(isFetchingMore: true));

    try {
      final nextPage = state.page + 1;
      final newBreeds = await service.fetchBreeds(nextPage);

      if (newBreeds.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        final allBreeds = [...state.breeds, ...newBreeds];

        emit(
          state.copyWith(
            breeds: allBreeds,
            isFetchingMore: false,
            page: nextPage,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isFetchingMore: false, error: e.toString()));
    }
  }
}
