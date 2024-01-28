part of 'movie_tabbed_bloc.dart';

sealed class MovieTabbedState extends Equatable {
  final int currentTabIndex;
  const MovieTabbedState({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity> movies;

  const MovieTabChanged({required int currentTabIndex, required this.movies})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabbedState {
  final AppErrorType appErrorType;
  const MovieTabLoadError( {required int currentTabIndex, required this.appErrorType,})
      : super(currentTabIndex: currentTabIndex);
}
