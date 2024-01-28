import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/routes_constant.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/bloc/login/login_bloc.dart';
import 'package:movieapp/presentation/journeys/login/label_field_widget.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController userNameController, passwordController;
  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.dimen_32.w,
        vertical: Sizes.dimen_40.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.dimen_8.h,
            ),
            child: Text(
              TranslationConstants.loginToMovieApp.t(context)!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          LabelFieldWidget(
            label: TranslationConstants.username.t(context)!,
            hintText: TranslationConstants.enterTMDbUsername.t(context)!,
            controller: userNameController,
          ),
          LabelFieldWidget(
            label: TranslationConstants.password.t(context)!,
            hintText: TranslationConstants.enterPassword.t(context)!,
            controller: passwordController,
            isPasswordField: true,
          ),
          BlocConsumer<LoginBloc, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              builder: (context, state) {
                if (state is LoginError) {
                  return Text(
                    state.message.t(context)!,
                    style: Theme.of(context).textTheme.orangeSubtitle1,
                  );
                }
                return const SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RouteList.home, (route) => false);
              }),
          Button(
            text: TranslationConstants.signIn,
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(
                LogInInitialEvent(
                    username: userNameController.text,
                    password: passwordController.text),
              );
            },
          )
        ],
      ),
    );
  }
}
