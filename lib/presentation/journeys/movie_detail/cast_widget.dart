import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/bloc/cast/cast_bloc.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          return SizedBox(
            height: Sizes.dimen_200.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.casts.length,
              itemBuilder: (context, index) {
                final castEnity = state.casts[index];
                return SizedBox(
                  height: Sizes.dimen_100.h,
                  width: Sizes.dimen_150.w,
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_8.w, vertical: Sizes.dimen_4.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.dimen_8.w),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                8.w,
                              ),
                            ),
                            child: CachedNetworkImage(
                              height: Sizes.dimen_100.h,
                              width: Sizes.dimen_150.w,
                              fit: BoxFit.fitWidth,
                              imageUrl:
                                  '${ApiConstants.BASE_IMAGE_URL}${castEnity.posterPath}',
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                          child: Text(
                            castEnity.name!,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.vulcanBodyText2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Sizes.dimen_8.w,
                            right: Sizes.dimen_8.w,
                            bottom: Sizes.dimen_2.h,
                          ),
                          child: Text(
                            castEnity.character!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {}
        return const SizedBox.shrink();
      },
    );
  }
}
