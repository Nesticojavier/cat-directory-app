import 'package:equatable/equatable.dart';

abstract class BreedsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBreeds extends BreedsEvent {}

class LoadMoreBreeds extends BreedsEvent {}

class RefreshBreeds extends BreedsEvent {}

class SearchBreeds extends BreedsEvent {
  final String query;

  SearchBreeds(this.query);

  @override
  List<Object?> get props => [query];
}
