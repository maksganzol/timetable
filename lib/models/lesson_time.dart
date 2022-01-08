import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'lesson_time.g.dart';

@JsonSerializable()
class LessonTime {
  final int hours;
  final int minutes;

  const LessonTime({
    required this.hours,
    this.minutes = 0,
  });

  factory LessonTime.fromJson(Json json) => _$LessonTimeFromJson(json);

  factory LessonTime.fromDate(DateTime dateTime) => LessonTime(
        hours: dateTime.hour,
        minutes: dateTime.minute,
      );

  factory LessonTime.fromTimeOfDay(TimeOfDay timeOfDay) => LessonTime(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );

  String get formatted => DateFormat('hh:mm').format(toDateTime());

  Json toJson() => _$LessonTimeToJson(this);

  DateTime toDateTime() => DateTime(0, 0, 0, hours, minutes);
}
