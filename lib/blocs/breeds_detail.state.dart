import 'package:equatable/equatable.dart';

class BreedDetailState extends Equatable {
  final bool isLoading;
  final String? fact;
  final String? error;

  const BreedDetailState({this.isLoading = false, this.fact, this.error});

  BreedDetailState copyWith({bool? isLoading, String? fact, String? error}) {
    return BreedDetailState(
      isLoading: isLoading ?? this.isLoading,
      fact: fact ?? this.fact,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, fact, error];
}
