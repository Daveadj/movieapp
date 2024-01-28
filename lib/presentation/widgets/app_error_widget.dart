import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function() onPressed;
  const AppErrorWidget(
      {super.key, required this.errorType, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong
                : TranslationConstants.checkNetwork,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ButtonBar(
            children: [
              Button(text: TranslationConstants.retry, onPressed: onPressed),
              Button(
                text: TranslationConstants.feedback,
                onPressed: () => Wiredash.of(context).show(),
              )
            ],
          )
        ],
      ),
    );
  }
}
