import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/num_extensions.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/screenutils/screenutil.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_appbar.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity movie;
  const BigPoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.3),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
            width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              movie.title!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              movie.releaseDate!,
              style: Theme.of(context).textTheme.greySubtitle1,
            ),
            trailing: Text(movie.voteAverage!.convertToPercentageString(),
                style: Theme.of(context).textTheme.violetHeadline6),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: ScreenUtil().statusBarHeight + Sizes.dimen_4.h,
          child: MovieDetailAppBar(
            movie : movie
          ),
        ),
      ],
    );
  }
}
