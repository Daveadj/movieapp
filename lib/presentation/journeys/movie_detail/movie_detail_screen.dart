import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/bloc/cast/cast_bloc.dart';
import 'package:movieapp/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/bloc/videos/videos_bloc.dart';
import 'package:movieapp/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movieapp/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movieapp/presentation/journeys/movie_detail/videos_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;
  const MovieDetailScreen({super.key, required this.movieDetailArguments});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc movieDetailBloc;
  late CastBloc castBloc;
  late VideosBloc videosBloc;
  late FavoriteBloc favoriteBloc;
  @override
  void initState() {
    movieDetailBloc = getItInstance<MovieDetailBloc>();
    movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguments.movieId!));
    castBloc = movieDetailBloc.castBloc;
    videosBloc = movieDetailBloc.videosBloc;
    favoriteBloc = movieDetailBloc.favoriteBloc;
    super.initState();
  }

  @override
  void dispose() {
    movieDetailBloc.close();
    castBloc.close();
    videosBloc.close();
    favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: movieDetailBloc),
          BlocProvider.value(value: castBloc),
          BlocProvider.value(value: videosBloc),
          BlocProvider.value(value: favoriteBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(movie: movieDetail),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_8.h),
                      child: Text(
                        movieDetail.overview!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context)!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const CastWidget(),
                    VideosWidget(videosBloc: videosBloc),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
