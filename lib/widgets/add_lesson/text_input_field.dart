import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/configuration/app_text_styles.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 20,
      style: AppTexStyles.b800,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CupertinoColors.systemGrey,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CupertinoColors.systemBlue,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        isDense: true,
      ),
    );
  }
}
