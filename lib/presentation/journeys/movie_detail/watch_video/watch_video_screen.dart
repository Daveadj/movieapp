import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/domain/entities/video_entity.dart';
import 'package:movieapp/presentation/journeys/movie_detail/watch_video/watch_video_arguments.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoScreen extends StatefulWidget {
  final WatchVideoArguments watchVideoArguments;
  const WatchVideoScreen({super.key, required this.watchVideoArguments});

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late List<VideoEntity> videos;
  late YoutubePlayerController controller;

  @override
  void initState() {
    videos = widget.watchVideoArguments.videos;
    controller = YoutubePlayerController(
        initialVideoId: videos[0].key!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TranslationConstants.watchTrailers,
        ),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (context, player) {
          return Column(
            children: [
              player,
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: [
                  for (int i = 0; i < videos.length; i++)
                    Container(
                      height: 100.h,
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical: Sizes.dimen_8.h),
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            controller.load(videos[i].key!);
                            controller.play();
                          },
                          child: CachedNetworkImage(
                            imageUrl: YoutubePlayer.getThumbnail(
                              videoId: videos[i].key!,
                              quality: ThumbnailQuality.high,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              videos[i].title!,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        )
                      ]),
                    )
                ]),
              ))
            ],
          );
        },
      ),
    );
  }
}
