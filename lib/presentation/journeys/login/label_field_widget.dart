import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';

class LabelFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final UnderlineInputBorder enableBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );
  final UnderlineInputBorder _focusedBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );
  const LabelFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.isPasswordField = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
          TextField(
            obscureText: isPasswordField,
            obscuringCharacter: '*',
            controller: controller,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.greySubtitle1,
              focusedBorder: _focusedBorder,
              enabledBorder: enableBorder,
            ),
          ),
        ],
      ),
    );
  }
}
