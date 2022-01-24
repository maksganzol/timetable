import 'package:flutter/material.dart';
import 'package:timetable/models/extensions/day_of_week_display_name.dart';
import 'package:weekday_selector/weekday_selector.dart';

class WeekdayPicker extends StatelessWidget {
  const WeekdayPicker({
    Key? key,
    required this.onChanged,
    required this.selectedDay,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  final int selectedDay;

  List<int> get _days => List.generate(7, (i) => i);

  @override
  Widget build(BuildContext context) {
    return WeekdaySelector(
      onChanged: (day) => onChanged(day - 1),
      values:
          _days.map((day) => day == selectedDay + 1).toList(growable: false),
      shortWeekdays: _days.map((day) => day.shortName).toList(growable: false),
    );
  }
}
