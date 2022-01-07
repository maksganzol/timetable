import 'package:flutter/material.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/configuration/app_text_styles.dart';

class InputWrapper extends StatelessWidget {
  const InputWrapper({
    Key? key,
    required this.child,
    required this.label,
  }) : super(key: key);

  final Widget child;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTexStyles.b400.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppMargins.margin / 2),
        child,
      ],
    );
  }
}
