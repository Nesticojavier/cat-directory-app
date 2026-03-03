import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cat_directory_app/helpers/debounce_transformer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/breed_service.dart';
import 'breeds_event.dart';
import 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  final BreedService service;

  BreedsBloc(this.service) : super(const BreedsState()) {
    on<LoadBreeds>(_onLoadBreeds);
    on<RefreshBreeds>(_onRefreshBreeds);
    on<LoadMoreBreeds>(_onLoadMoreBreeds, transformer: droppable());
    on<SearchBreeds>(
      _onSearchBreeds,
      transformer: debounceRestartable(const Duration(milliseconds: 500)),
    );
  }

  /// Initial load of breeds
  Future<void> _onLoadBreeds(
    LoadBreeds event,
    Emitter<BreedsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final breeds = await service.fetchBreeds(1);

      emit(
        state.copyWith(
          breeds: breeds,
          filteredBreeds: breeds,
          isLoading: false,
          page: 1,
        ),
      );
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
          filteredBreeds: breeds,
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
        emit(state.copyWith(hasReachedMax: true, isFetchingMore: false));
      } else {
        final allBreeds = [...state.breeds, ...newBreeds];

        emit(
          state.copyWith(
            breeds: allBreeds,
            filteredBreeds: allBreeds,
            isFetchingMore: false,
            page: nextPage,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isFetchingMore: false, error: e.toString()));
    }
  }

  /// Search breeds by name
  Future<void> _onSearchBreeds(
    SearchBreeds event,
    Emitter<BreedsState> emit,
  ) async {
    emit(state.copyWith(error: null, isLoading: true));

    // simulate debounce delay
    await Future.delayed(const Duration(milliseconds: 300));
    final filtered = state.breeds
        .where((b) => b.breed.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(filteredBreeds: filtered, isLoading: false));
  }
}
