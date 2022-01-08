import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_bloc.dart';
import 'package:timetable/models/extensions/day_of_week_display_name.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/models/lesson_time.dart';

class LessonScheduleFiled extends StatelessWidget {
  const LessonScheduleFiled({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final ValueChanged<LessonSchedule> onChanged;
  final LessonSchedule value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final startTime = await showTimePicker(
          helpText: 'Выберите время начала',
          context: context,
          initialTime: TimeOfDay.fromDateTime(value.startTime.toDateTime()),
        );
        if (startTime == null) return;

        final endTime = await showTimePicker(
          helpText: 'Выберите время окончания',
          context: context,
          initialTime: TimeOfDay.fromDateTime(value.endTime.toDateTime()),
        );
        if (endTime == null) return;
        final lessonSchedule = LessonSchedule(
          startTime: LessonTime.fromTimeOfDay(startTime),
          endTime: LessonTime.fromTimeOfDay(endTime),
          dayOfWeek: 0,
          isOddWeek: false,
        );

        onChanged(lessonSchedule);
      },
      leading: const Padding(
        padding: EdgeInsets.only(top: 5),
        child: Icon(CupertinoIcons.clock),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
      contentPadding: EdgeInsets.zero,
      title: _LessonWeekDayLabel(dayOfWeek: value.dayOfWeek),
      subtitle: _LessonTimeLabel(
        endTime: value.endTime,
        startTime: value.startTime,
      ),
    );
  }
}

class _LessonTimeLabel extends StatelessWidget {
  final LessonTime startTime;
  final LessonTime endTime;

  const _LessonTimeLabel({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${startTime.formatted} - ${endTime.formatted}');
  }
}

class _LessonWeekDayLabel extends StatelessWidget {
  const _LessonWeekDayLabel({
    Key? key,
    required this.dayOfWeek,
  }) : super(key: key);

  final int dayOfWeek;

  @override
  Widget build(BuildContext context) {
    return Text(dayOfWeek.displayName);
  }
}
