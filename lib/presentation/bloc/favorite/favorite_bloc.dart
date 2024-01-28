import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/check_if_favorite_movie.dart';
import 'package:movieapp/domain/usecases/delete_movie.dart';
import 'package:movieapp/domain/usecases/get_favorite_movie.dart';
import 'package:movieapp/domain/usecases/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovies deleteFavoriteMovies;
  final CheckIfFavorite checkIfFavorite;
  FavoriteBloc({
    required this.saveMovie,
    required this.deleteFavoriteMovies,
    required this.checkIfFavorite,
    required this.getFavoriteMovies,
  }) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is ToggleFavoriteMovieEvent) {
        if (event.isFavorite) {
          await deleteFavoriteMovies(MovieParams(event.movieEntity.id!));
        } else {
          await saveMovie(event.movieEntity);
        }
        final response =
            await checkIfFavorite(MovieParams(event.movieEntity.id!));
        emit(response.fold(
          (l) => FavoriteMoviesError(),
          (r) => IsFavoriteMovie(r),
        ));
      } else if (event is LoadFavoriteMovieEvent) {
        final Either<AppError, List<MovieEntity>> response =
            await getFavoriteMovies(NoParams());
        emit(response.fold(
          (l) => FavoriteMoviesError(),
          (r) => FavoriteMoviesLoaded(r),
        ));
      } else if (event is DeleteFavoriteMovieEvent) {
        await deleteFavoriteMovies(MovieParams(event.movieId));
        final Either<AppError, List<MovieEntity>> response =
            await getFavoriteMovies(NoParams());
        emit(response.fold(
          (l) => FavoriteMoviesError(),
          (r) => FavoriteMoviesLoaded(r),
        ));
      } else if (event is CheckIfFavoriteMovieEvent) {
        final response = await checkIfFavorite(MovieParams(event.movieId));
        emit(response.fold(
          (l) => FavoriteMoviesError(),
          (r) => IsFavoriteMovie(r),
        ));
      }
    });
  }
}
