import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/screenutils/screenutil.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/animated_movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity>? movies;
  final int initialPage;
  const MoviePageView(
      {super.key, required this.movies, required this.initialPage});

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  // ignore: unused_field
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil().screenHeight * 0.35,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.movies?.length ?? 0,
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies![index];
          return AnimatedMovieCardWidget(
            movieId: movie.id!,
            posterPath: movie.posterPath!,
            index: index,
            pageController: _pageController,
          );
        },
        pageSnapping: true,
        onPageChanged: (index) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(MovieBackdropChangedEvent(widget.movies![index]));
        },
      ),
    );
  }
}
