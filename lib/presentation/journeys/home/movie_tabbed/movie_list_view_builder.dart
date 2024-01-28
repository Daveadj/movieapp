import 'package:flutter/material.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;
  const MovieListViewBuilder({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final MovieEntity movie = movies[index];
            return MovieTabCardWidget(
              movieId: movie.id!,
              title: movie.title!,
              posterPath: movie.posterPath!,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 14.h,
            );
          },
          itemCount: movies.length),
    );
  }
}
