part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;

  const SearchMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final AppErrorType appError;

  const SearchMovieError({required this.appError});

   @override
  List<Object> get props => [appError];
}
