
// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetMovieDetails extends UseCase<MovieDetailEntity,MovieParams>{
  final MovieRepository repository;

  GetMovieDetails(this.repository);
  @override
  Future<Either<AppError,MovieDetailEntity>> call(MovieParams params) async {
    return await repository.getMovieDetail(params.id);
  }
}
