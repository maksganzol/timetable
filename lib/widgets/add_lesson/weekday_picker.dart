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

  static const _days = [7, 1, 2, 3, 4, 5, 6];
  static const _daysX = [ 1, 2, 3, 4, 5, 6, 7];


  @override 
  Widget build(BuildContext context) {
    print(selectedDay);
    final t = _days.map((day) => day == selectedDay).toList(growable: false);
    print(_days);
    print(t);
    return WeekdaySelector(
      onChanged: (day) {
        print('DAY $day');
        onChanged(day);
      },
      values: t,
      shortWeekdays:_daysX.map((day) => day.shortName).toList(growable: false),
    );
  }
}
