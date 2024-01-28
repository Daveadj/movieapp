// ignore_for_file: override_on_non_overriding_member

import 'package:bloc/bloc.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/presentation/bloc/loading/loading_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_event.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;
  final LoadingBloc loadingBloc;
  MovieCarouselBloc(
      {required this.getTrending,
      required this.movieBackdropBloc,
      required this.loadingBloc})
      : super(const MovieCarouselInitial()) {
    on<CarouselLoadEvent>(
      (event, emit) async {
        loadingBloc.add(StartLoading());
        final moviesEither = await getTrending(NoParams());
        emit(
          moviesEither.fold(
            (l) => MovieCarouselError(l.appErrorType),
            (movies) {
              movieBackdropBloc
                  .add(MovieBackdropChangedEvent(movies![event.defaultIndex]));
              return MovieCarouselLoaded(
                movies: movies,
                defaultIndex: event.defaultIndex,
              );
            },
          ),
        );
          loadingBloc.add(FinishLoading());
      },
    );
  }
}
