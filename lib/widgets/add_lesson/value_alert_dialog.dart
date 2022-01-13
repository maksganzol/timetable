import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class ValueAlertDialog {
  static Future<T> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext, ValueSetter<T>) builder,
  }) async {
    final completer = Completer<T>();

    showDialog(
      context: context,
      builder: (context) => builder(
        context,
        (value) {
          completer.complete(value);
          AutoRouter.of(context).pop();
        },
      ),
    );

    return completer.future;
  }
}
