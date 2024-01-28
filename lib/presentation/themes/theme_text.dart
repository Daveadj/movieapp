import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadline6 =>
      _poppinsTextTheme.titleLarge!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );
  static TextStyle get whiteHeadline5 => _poppinsTextTheme.titleSmall!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubtitle1 =>
      _poppinsTextTheme.titleMedium!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );
  static TextStyle get whiteButton => _poppinsTextTheme.labelLarge!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );
  static TextStyle get whiteBoodyText2 =>
      _poppinsTextTheme.bodyMedium!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );
  static getTextTheme() => TextTheme(
        labelLarge: whiteButton,
        headlineSmall: whiteHeadline5,
        titleLarge: _whiteHeadline6,
        titleMedium: whiteSubtitle1,
        bodyMedium: whiteBoodyText2,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
  TextStyle get greySubtitle1 => titleMedium!.copyWith(
        color: Colors.grey,
      );
  TextStyle get orangeSubtitle1 => titleMedium!.copyWith(
        color: Colors.orange,
      );
  TextStyle get violetHeadline6 => titleMedium!.copyWith(
        color: AppColor.violet,
      );

  TextStyle get vulcanBodyText2 => bodyMedium!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
  TextStyle get greyCaption => bodySmall!.copyWith(
        color: Colors.grey,
      );
}
