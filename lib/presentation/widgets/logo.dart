import 'package:flutter/material.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';

class Logo extends StatelessWidget {
  final double height;
  const Logo({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      color: Colors.white,
      height: height.h,
    );
  }
}