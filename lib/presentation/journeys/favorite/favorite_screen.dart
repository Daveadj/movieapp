import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_movie_grid_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc favoriteBloc;
  @override
  void initState() {
    favoriteBloc = getItInstance<FavoriteBloc>();
    favoriteBloc.add(LoadFavoriteMovieEvent());
    super.initState();
  }

  @override
  void dispose() {
    favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.favoriteMovies.t(context)!),
      ),
      body: BlocProvider.value(
        value: favoriteBloc,
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovies.t(context)!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              }
              return FavoriteMovieGridView(
                movies:state.movies
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
