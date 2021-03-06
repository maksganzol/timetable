import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetable/configuration/app_colors.dart';

abstract class AppTexStyles {
  static final textStyle = GoogleFonts.roboto();

  static final TextStyle b200 = textStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle b400 = textStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle b600 = textStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle b700 = textStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle b800 = textStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w100,
  );

  static final TextStyle h100 = textStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle h200 = textStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle h300 = textStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle h400 = textStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
}

extension TextDecorations on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get white => copyWith(color: AppColors.white);
}
