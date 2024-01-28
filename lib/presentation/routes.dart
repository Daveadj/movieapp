import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/routes_constant.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/journeys/home/home_screen.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:movieapp/presentation/journeys/movie_detail/watch_video/watch_video_arguments.dart';
import 'package:movieapp/presentation/journeys/movie_detail/watch_video/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.initial: (context) => const HomeScreen(),
        RouteList.home: (context) => const HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: settings.arguments as MovieDetailArguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: settings.arguments as WatchVideoArguments,
            ),
        RouteList.favorite: (context) => const FavoriteScreen(),
      };
}
