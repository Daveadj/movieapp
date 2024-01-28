import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class DeleteFavoriteMovies extends UseCase<void, MovieParams> {
  final MovieRepository movieRepository;

  DeleteFavoriteMovies(this.movieRepository);
  @override
  Future<Either<AppError, void>> call(MovieParams params) async {
    return await movieRepository.deleteFavoriteMovie(params.id);
  }
}
