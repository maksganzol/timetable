import 'package:flutter/material.dart';
import 'package:timetable/configuration/configuration.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 24, letterSpacing: 1.5),
      keyboardType: TextInputType.phone,
      controller: controller,
      decoration: const InputDecoration(
        hintStyle: TextStyle(letterSpacing: 1, fontSize: 18),
        hintText: 'Номер телефона',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.indigo900,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.indigo900,
          ),
        ),
      ),
    );
  }
}
