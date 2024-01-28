import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/usecases/get_movie_details.dart';
import 'package:movieapp/presentation/bloc/cast/cast_bloc.dart';
import 'package:movieapp/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/bloc/loading/loading_bloc.dart';
import 'package:movieapp/presentation/bloc/videos/videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails getMovieDetails;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;
  final LoadingBloc loadingBloc;

  MovieDetailBloc({
    required this.getMovieDetails,
    required this.castBloc,
    required this.videosBloc,
    required this.favoriteBloc,
    required this.loadingBloc,
  }) : super(MovieDetailInitial()) {
    on<MovieDetailEvent>(
      (event, emit) async {
        if (event is MovieDetailLoadEvent) {
          loadingBloc.add(StartLoading());
          final Either<AppError, MovieDetailEntity> eitherResponse =
              await getMovieDetails(MovieParams(event.movieId));

          emit(
            eitherResponse.fold(
              (l) => MovieDetailError(),
              (movie) => MovieDetailLoaded(movie),
            ),
          );
          favoriteBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
          castBloc.add(LoadCastEvent(movieId: event.movieId));
          videosBloc.add(LoadVideosEvent(movieId: event.movieId));
          loadingBloc.add(FinishLoading());
        }
      },
    );
  }
}
