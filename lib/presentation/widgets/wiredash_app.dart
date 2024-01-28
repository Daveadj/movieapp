import 'package:flutter/material.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final Widget child;
  final String languagueCode;
  const WiredashApp({super.key, required this.child, required this.languagueCode});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-hczr83x',
      secret: 'BZQt5A0SSpJhGocXEAecT06Xo9sM0Q-i',
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
      ),
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(languageCode: languagueCode)
      ),
      child: child,
    );
  }
}
