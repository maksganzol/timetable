import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color systemBlue = CupertinoColors.systemBlue;
  static const Color activeBlue = CupertinoColors.activeBlue;
  static const Color systemRed = CupertinoColors.systemRed;
  static const Color destructiveRed = CupertinoColors.destructiveRed;
  static const Color activeGreen = CupertinoColors.activeGreen;
  static const Color systemGreen = CupertinoColors.systemGreen;

  static const Color indigo900 = Color(0xff23036a);
  static const Color indigo800 = Color(0xff30009c);
  static const Color indigo700 = Color(0xff3700b3);
  static const Color indigo600 = Color(0xff5600e8);
  static const Color indigo400 = Color(0xff7f39fb);
  static const Color indigo300 = Color(0xff985eff);
  static const Color indigo200 = Color(0xffbb86fc);
  static const Color indigo100 = Color(0xffdbb2ff);
  static const Color indigo050 = Color(0xfff2e7fe);

  static const Color indigoBackground = Color(0xfffcf8ff);
  static const Color greyBackground = Color(0xffF7F7F7);
}

extension ColorMaterialStateProperty on Color {
  MaterialStateProperty<Color?> get materialProperty =>
      MaterialStateProperty.all(this);
}
