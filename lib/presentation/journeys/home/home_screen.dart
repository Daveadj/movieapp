import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_event.dart';
import 'package:movieapp/presentation/bloc/movie_carousel/movie_carousel_state.dart';
import 'package:movieapp/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/widgets/app_error_widget.dart';
import 'package:movieapp/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackdropBloc movieBackdropBloc;
  late MovieTabbedBloc movieTabbedBloc;
  late SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
    movieCarouselBloc.add(const CarouselLoadEvent());
    searchMovieBloc = getItInstance<SearchMovieBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    movieTabbedBloc.close();
    searchMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => movieCarouselBloc),
        BlocProvider(create: (context) => movieBackdropBloc),
        BlocProvider(create: (context) => movieTabbedBloc),
        BlocProvider(create: (context) => searchMovieBloc),
      ],
      child: Scaffold(
        drawer: const NavigationDrawers(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          bloc: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      )),
                  const FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.4,
                      child: MovieTabbedWidget())
                ],
              );
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                errorType: state.errorType,
                onPressed: () => movieCarouselBloc.add(
                  const CarouselLoadEvent(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
