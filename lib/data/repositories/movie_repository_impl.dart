import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/models/cast_crew_result_data_model.dart';
import 'package:movieapp/data/models/movie_detail_model.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/tables/movie_table.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSorce localDataSorce;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSorce);
  @override
  Future<Either<AppError, List<MovieModel>?>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>?>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getCommingSoon();
      return Right(movies);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>?>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>?>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailsModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>?>> getCastCrew(int id) async {
    try {
      final cast = await remoteDataSource.getCastCrew(id);
      return Right(cast);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoEntity>?>> getVideos(int id) async {
    try {
      final videos = await remoteDataSource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>?>> getSearchMovies(
      String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchMovies(searchTerm);
      return Right(movies);
    } on SocketException {
      return left(const AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async {
    try {
      final response = await localDataSorce.checkIfMovieFavorite(movieId);

      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSorce.deleteMovie(movieId);

      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavorite() async {
    try {
      final response = await localDataSorce.getMovies();

      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      final response = await localDataSorce
          .saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
