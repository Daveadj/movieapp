import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: Sizes.dimen_40.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColor.royalBlue,
              AppColor.violet,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w))),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text.t(context)!,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
