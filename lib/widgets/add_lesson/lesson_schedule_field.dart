import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/models/extensions/day_of_week_display_name.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/widgets/add_lesson/value_alert_dialog.dart';

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
      onTap: () => _handleTimePicker(context),
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

  Future<void> _handleTimePicker(BuildContext context) async {
    final startTime = await showTimePicker(
      helpText: 'Выберите время начала',
      context: context,
      initialTime: value.startTime,
    );
    if (startTime == null) return;

    final endTime = await showTimePicker(
      helpText: 'Выберите время окончания',
      context: context,
      initialTime: value.endTime,
    );
    if (endTime == null) return;

    //TODO process period
    await ValueAlertDialog.show<int>(context, builder: _alertDialogBuilder);

    final lessonSchedule = LessonSchedule(
      startTime: startTime,
      endTime: endTime,
      dayOfWeek: DateTime.now().weekday,
      isOddWeek: false,
    );

    onChanged(lessonSchedule);
  }

  Widget _alertDialogBuilder(BuildContext context, ValueSetter<int> resolve) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text('Период'),
      ),
      actions: [
        TextButton(
          child: const Text('Каждый день'),
          onPressed: () => resolve(1),
        ),
        TextButton(
          child: const Text('Неделю'),
          onPressed: () => resolve(2),
        ),
        TextButton(
          child: const Text('2 недели'),
          onPressed: () => resolve(3),
        ),
      ],
    );
  }
}

class _LessonTimeLabel extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const _LessonTimeLabel({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${startTime.format(context)} - ${endTime.format(context)}');
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
