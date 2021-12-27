import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

extension IterableJoinWith<T extends Widget> on Iterable<T> {
  List<Widget> joinWith(Widget separator) {
    return expandIndexed(
      (index, element) => [
        element,
        if (index < length - 1) separator,
      ],
    ).toList(growable: false);
  }
}
