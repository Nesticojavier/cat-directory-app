import 'package:equatable/equatable.dart';

abstract class BreedDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRandomFact extends BreedDetailEvent {}
