import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';
import 'package:timetable/models/extensions/time_of_day_serializable.dart';

part 'lesson_schedule.g.dart';

const startTimeKey = JsonKey(
  fromJson: TimeOfDaySerializable.fromJson,
  toJson: TimeOfDaySerializable.toJson,
);

@JsonSerializable()
class LessonSchedule extends Equatable {
  @startTimeKey
  final TimeOfDay startTime;
  @startTimeKey
  final TimeOfDay endTime;
  final int dayOfWeek;
  final bool? isOddWeek;

  const LessonSchedule({
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.isOddWeek,
  });

  factory LessonSchedule.fromJson(Json json) => _$LessonScheduleFromJson(json);

  Json toJson() => _$LessonScheduleToJson(this);

  @override
  List<Object?> get props => [startTime, endTime, dayOfWeek, isOddWeek];
}
