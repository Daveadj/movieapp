part of 'cast_bloc.dart';

sealed class CastState extends Equatable {
  const CastState();

  @override
  List<Object> get props => [];
}

class CastInitial extends CastState {}

class CastLoaded extends CastState {
  final List<CastEntity> casts;

  const CastLoaded({required this.casts});

  @override
  List<Object> get props => [casts];
}

class CastError extends CastState{
  
}
