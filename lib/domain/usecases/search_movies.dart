// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/movie_search_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class SearchMovies extends UseCase<List<MovieEntity>?,MovieSearchParams>{
  final MovieRepository repository;

  SearchMovies(this.repository);
  @override
  Future<Either<AppError,List<MovieEntity>?>> call(MovieSearchParams params) async {
    return await repository.getSearchMovies(params.searchTerm);
  }
}
