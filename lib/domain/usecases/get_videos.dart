
// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>?,MovieParams>{
  final MovieRepository repository;

  GetVideos(this.repository);
  @override
  Future<Either<AppError,List<VideoEntity>?>> call(MovieParams params) async {
    return await repository.getVideos(params.id);
  }
}
