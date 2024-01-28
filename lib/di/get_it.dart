import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_sources/authentication_local_data_source.dart';
import 'package:movieapp/data/data_sources/authentication_remote_data_source.dart';
import 'package:movieapp/data/data_sources/language_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/repositories/app_repository_impl.dart';
import 'package:movieapp/data/repositories/authentication_repository_impl.dart';
import 'package:movieapp/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/repositories/authentication_repository.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/check_if_favorite_movie.dart';
import 'package:movieapp/domain/usecases/delete_movie.dart';
import 'package:movieapp/domain/usecases/get_cast.dart';
import 'package:movieapp/domain/usecases/get_coming_soon.dart';
import 'package:movieapp/domain/usecases/get_favorite_movie.dart';
import 'package:movieapp/domain/usecases/get_movie_details.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/domain/usecases/get_preferred_language.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';
import 'package:movieapp/domain/usecases/login_user.dart';
import 'package:movieapp/domain/usecases/logout_user.dart';
import 'package:movieapp/domain/usecases/save_movie.dart';
import 'package:movieapp/domain/usecases/search_movies.dart';
import 'package:movieapp/domain/usecases/update_language.dart';
import 'package:movieapp/presentation/bloc/cast/cast_bloc.dart';
import 'package:movieapp/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/bloc/language/language_bloc.dart';
import 'package:movieapp/presentation/bloc/loading/loading_bloc.dart';
import 'package:movieapp/presentation/bloc/login/login_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/bloc/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSorce>(
      () => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory(() => MovieCarouselBloc(
        loadingBloc: getItInstance(),
        getTrending: getItInstance(),
        movieBackdropBloc: getItInstance(),
      ));

  getItInstance.registerFactory(() => MovieTabbedBloc(
      getPopular: getItInstance(),
      getPlayingNow: getItInstance(),
      getComingSoon: getItInstance()));

  getItInstance.registerFactory(() => LanguageBloc(
      getPreferredLanguage: getItInstance(), updateLanguage: getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetails>(
      () => GetMovieDetails(getItInstance()));

  getItInstance
      .registerLazySingleton<GetCastCrew>(() => GetCastCrew(getItInstance()));

  getItInstance.registerFactory(() => MovieDetailBloc(
      loadingBloc: getItInstance(),
      getMovieDetails: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
      favoriteBloc: getItInstance()));

  getItInstance.registerFactory(() => CastBloc(getCastCrew: getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance.registerFactory(() => VideosBloc(getVideos: getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      loadingBloc: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovies>(
      () => DeleteFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavorite>(
      () => CheckIfFavorite(getItInstance()));

  getItInstance.registerFactory(() => FavoriteBloc(
      saveMovie: getItInstance(),
      deleteFavoriteMovies: getItInstance(),
      checkIfFavorite: getItInstance(),
      getFavoriteMovies: getItInstance()));

  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  getItInstance.registerFactory(
      () => LoginBloc(loginUser: getItInstance(), logoutUser: getItInstance()));
  getItInstance.registerFactory(() => LoadingBloc());
}
