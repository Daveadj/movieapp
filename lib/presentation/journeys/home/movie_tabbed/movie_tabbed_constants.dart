

import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/tab.dart';

class MovieTabbedConstants {
  static  List<Tab> movieTabs = [
    Tab(index: 0, title: TranslationConstants.popular),
    Tab(index: 1, title: TranslationConstants.now),
    Tab(index: 2, title: TranslationConstants.soon),
  ];
}
