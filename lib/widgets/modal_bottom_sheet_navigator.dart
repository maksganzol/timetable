import 'package:flutter/material.dart';

class ModalBottomSheetNavigator extends StatelessWidget {
  const ModalBottomSheetNavigator({Key? key, required this.builder}) : super(key: key);

  static Future<void> push(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: builder,
      ),
    );
  }
}