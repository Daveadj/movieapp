import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/routes_constant.dart';
import 'package:movieapp/common/screenutils/screenutil.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/app_localizations.dart';
import 'package:movieapp/presentation/bloc/language/language_bloc.dart';
import 'package:movieapp/presentation/bloc/loading/loading_bloc.dart';
import 'package:movieapp/presentation/bloc/login/login_bloc.dart';
import 'package:movieapp/presentation/journeys/loading/loading_screen.dart';
import 'package:movieapp/presentation/routes.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/widgets/fade_page_route_builder.dart';
import 'package:movieapp/presentation/widgets/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc languageBloc;
  late LoginBloc loginBloc;
  late LoadingBloc loadingBloc;
  @override
  void initState() {
    languageBloc = getItInstance<LanguageBloc>();
    languageBloc.add(LoadPreferredLanguageEvent());
    loginBloc = getItInstance<LoginBloc>();
    loadingBloc = getItInstance<LoadingBloc>();
    super.initState();
  }

  @override
  void dispose() {
    languageBloc.close();
    loginBloc.close();
    loadingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: languageBloc),
        BlocProvider<LoginBloc>.value(value: loginBloc),
        BlocProvider<LoadingBloc>.value(value: loadingBloc),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return WiredashApp(
              languagueCode: state.locale.languageCode,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.royalBlue,
                  primaryColor: AppColor.vulcan,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: AppBarTheme(
                      elevation: 0,
                      backgroundColor: Theme.of(context).primaryColor),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  return LoadingScreen(screen: child!);
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder builder = routes[settings.name]!;
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
