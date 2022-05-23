import 'package:flutter/material.dart';

enum TimetableColor {
  red,
  green,
  yellow,
  indigo,
  blue,
  pink,
}

extension TimetableMaterialColor on TimetableColor {
  Color get materialColor {
    switch (this) {
      case TimetableColor.red:
        return Colors.red;
      case TimetableColor.blue:
        return Colors.blue;
      case TimetableColor.green:
        return Colors.green;
      case TimetableColor.indigo:
        return Colors.indigo;
      case TimetableColor.pink:
        return Colors.pink;
      case TimetableColor.yellow:
        return Colors.yellow;
    }
  }
}
