import 'package:equatable/equatable.dart';
import '../models/breed_model.dart';

class BreedsState extends Equatable {
  final List<BreedModel> breeds;
  final List<BreedModel> filteredBreeds;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasReachedMax;
  final String? error;
  final int page;

  const BreedsState({
    this.breeds = const [],
    this.filteredBreeds = const [],
    this.isLoading = false,
    this.isFetchingMore = false,
    this.hasReachedMax = false,
    this.error,
    this.page = 1,
  });

  BreedsState copyWith({
    List<BreedModel>? breeds,
    List<BreedModel>? filteredBreeds,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasReachedMax,
    String? error,
    int? page,
  }) {
    return BreedsState(
      breeds: breeds ?? this.breeds,
      filteredBreeds: filteredBreeds ?? this.filteredBreeds,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
    breeds,
    filteredBreeds,
    isLoading,
    isFetchingMore,
    hasReachedMax,
    error,
    page,
  ];
}
