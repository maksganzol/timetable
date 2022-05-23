import 'package:flutter/material.dart';
import 'package:timetable/configuration/configuration.dart';

class EmptyListLabel extends StatelessWidget {
  const EmptyListLabel({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmptyListText(text: title),
              const SizedBox(height: 30),
              _EmptyListText(text: subtitle),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 150, bottom: 20  ),
          child: Image(
            image: AssetImage('assets/images/add_timetabe_arrow.png'),
            height: 100,
          ),
        ),
      ],
    );
  }
}

class _EmptyListText extends StatelessWidget {
  const _EmptyListText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, color: AppColors.systemBlue),
      textAlign: TextAlign.center,
    );
  }
}
