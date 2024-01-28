import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';
import 'package:movieapp/presentation/widgets/app_error_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({super.key});

  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentTabIndex = 0;

  @override
  void initState() {
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: currentTabIndex));
    super.initState();
  }

  @override
  void dispose() {
    movieTabbedBloc.close();
    super.dispose();
  }

  void _onTabTapped(int i) {
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: i));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0;
                      i < MovieTabbedConstants.movieTabs.length;
                      i++)
                    TabTitleWidget(
                      title: MovieTabbedConstants.movieTabs[i].title,
                      onTap: () => _onTabTapped(i),
                      isSelected: MovieTabbedConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    ),
                ],
              ),
              if (state is MovieTabChanged)
                Expanded(
                  child: MovieListViewBuilder(movies: state.movies),
                ),
              if (state is MovieTabLoadError)
                Expanded(
                  child: AppErrorWidget(
                    errorType: state.appErrorType,
                    onPressed: () => movieTabbedBloc.add(
                      MovieTabChangedEvent(currentTabIndex:state.currentTabIndex),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
