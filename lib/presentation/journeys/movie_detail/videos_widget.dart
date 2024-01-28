import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/routes_constant.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/presentation/bloc/videos/videos_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/watch_video/watch_video_arguments.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videosBloc;
  const VideosWidget({super.key, required this.videosBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is LoadedVideos && state.videos!.iterator.moveNext()) {
          final videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.watchTrailer,
                arguments: WatchVideoArguments(
                  videos: videos!,
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
