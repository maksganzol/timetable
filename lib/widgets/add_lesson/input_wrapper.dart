import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/configuration/app_text_styles.dart';

class InputWrapper extends StatelessWidget {
  const InputWrapper({
    Key? key,
    required this.child,
    required this.label,
    this.isRequired = false,
  }) : super(key: key);

  final Widget child;
  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        const SizedBox(height: AppMargins.margin / 2),
        child,
      ],
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTexStyles.b400.copyWith(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
        ],
      ),
    );
  }
}
