import 'package:flutter/material.dart';
import 'package:timetable/configuration/configuration.dart';

class TimetableTile extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const TimetableTile({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: color.withOpacity(0.1),
      hoverColor: color.withOpacity(0.05),
      highlightColor: color.withOpacity(0.05),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppMargins.margin),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTexStyles.h100,
            ),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
      ),
    );
  }
}
