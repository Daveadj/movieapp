part of 'videos_bloc.dart';

sealed class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class LoadedVideos extends VideosState {
  final List<VideoEntity>? videos;

  const LoadedVideos({required this.videos});
   @override
  List<Object> get props => [videos!];
}

class NoVideos extends VideosState {}
