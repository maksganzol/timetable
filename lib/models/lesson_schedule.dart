import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';
import 'package:timetable/models/lesson_time.dart';

part 'lesson_schedule.g.dart';

@JsonSerializable()
class LessonSchedule extends Equatable {
  final LessonTime startTime;
  final LessonTime endTime;
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
