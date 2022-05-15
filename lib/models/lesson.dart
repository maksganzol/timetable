import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/models/extensions/date_time_operators.dart';
import 'package:timetable/models/lesson_status.dart';
import 'package:timetable/models/teacher.dart';
import 'package:timetable/utils/type_defs/json.dart';
import 'package:timetable/models/lesson_schedule.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Equatable {
  final String id;
  final String? description;
  final Teacher? teacher;
  final LessonSchedule time;
  // final String? subject;

  LessonStatus get status {
    final now = DateTime.now();

    if (now < time) {
      return LessonStatus.notStarted;
    }
    if (now > time) return LessonStatus.finished;

    return LessonStatus.started;
  }

  const Lesson({
    required this.id,
    required this.description,
    required this.teacher,
    required this.time,
    // required this.subject,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        teacher,
        time,
        // subject,
      ];

  Json toJson() => _$LessonToJson(this);

  factory Lesson.fromJson(Json json) => _$LessonFromJson(json);
}
