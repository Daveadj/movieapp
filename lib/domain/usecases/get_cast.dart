
// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/cast_entity.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetCastCrew extends UseCase<List<CastEntity>?,MovieParams>{
  final MovieRepository repository;

  GetCastCrew(this.repository);
  @override
  Future<Either<AppError,List<CastEntity>?>> call(MovieParams params) async {
    return await repository.getCastCrew(params.id);
  }
}
