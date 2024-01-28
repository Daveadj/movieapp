import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/screenutils/screenutil.dart';
import 'package:movieapp/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/journeys/search_movie/custom_search_movie_delegare.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_12.h,
            ),
          ),
          const Expanded(
            child: Logo(
              height: Sizes.dimen_14,
            ),
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(BlocProvider.of<SearchMovieBloc>(context)));
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
          )
        ],
      ),
    );
  }
}
