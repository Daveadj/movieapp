import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_backdrop_widget.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_data_widget.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_page_view.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';
import 'package:movieapp/presentation/widgets/separator.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity>? movies;
  final int defaultIndex;
  const MovieCarouselWidget(
      {super.key, required this.movies, required this.defaultIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const MovieBackdropWidgwt(),
        Column(
          children: [
            const MovieAppBar(),
            MoviePageView(movies: movies, initialPage: defaultIndex),
            const MovieDataWidget(),
            const Separator()
          ],
        ),
      ],
    );
  }
}
