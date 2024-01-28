import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/widgets/app_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: Theme.of(context).textTheme.greySubtitle1,
            hintStyle: Theme.of(context).textTheme.greySubtitle1));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        size: Sizes.dimen_20.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(SearchTermChangedEvent(searchTerm: query));

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: searchMovieBloc,
      builder: (context, state) {
        if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.appError,
            onPressed: () => searchMovieBloc.add(
              SearchTermChangedEvent(
                searchTerm: query,
              ),
            ),
          );
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_48.w,
                ),
                child: const Text(
                  TranslationConstants.noMoviesSearched,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return SearchMovieCard(
                movie: movies[index],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
