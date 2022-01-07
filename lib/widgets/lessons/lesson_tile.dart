import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/models/lesson_time.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final LessonTime startTime;
  final LessonTime endTime;

  final bool isActive;

  const LessonTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
    required this.isActive,
  }) : super(key: key);

  Color get _activeColor => CupertinoColors.activeBlue;

  BoxDecoration get _activeDecoration => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _activeColor.withOpacity(0),
            _activeColor.withOpacity(0.3),
          ],
        ),
        border: Border(
          right: BorderSide(
            width: 3,
            color: _activeColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isActive ? _activeDecoration : null,
      padding: const EdgeInsets.all(AppMargins.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LessonTimeLabel(time: startTime.toDateTime()),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTexStyles.b600.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                subtitle,
                style: AppTexStyles.b600,
              ),
            ],
          ),
          _LessonTimeLabel(time: endTime.toDateTime()),
        ],
      ),
    );
  }
}

class _LessonTimeLabel extends StatelessWidget {
  final DateTime time;

  const _LessonTimeLabel({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      time.timeString,
      style: AppTexStyles.b400.copyWith(color: Colors.black.withOpacity(0.5)),
    );
  }
}

extension _TimeFormat on DateTime {
  String get timeString {
    return DateFormat('hh:mm').format(toLocal());
  }
}
