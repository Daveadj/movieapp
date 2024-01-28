import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class CheckIfFavorite extends UseCase<bool, MovieParams> {
  final MovieRepository movieRepository;

  CheckIfFavorite(this.movieRepository);
  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await movieRepository.checkIfMovieFavorite(params.id);
  }
}
