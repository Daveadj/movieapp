import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_params.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;
  VideosBloc({required this.getVideos}) : super(VideosInitial()) {
    on<VideosEvent>((event, emit) async {
      if (event is LoadVideosEvent) {
        final Either<AppError, List<VideoEntity>?> eitherResponse =
            await getVideos(MovieParams(event.movieId));

        emit(
          eitherResponse.fold(
            (l) => NoVideos(),
            (videos) => LoadedVideos(videos: videos),
          ),
        );
      }
    });
  }
}
