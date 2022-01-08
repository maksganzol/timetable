import 'package:equatable/equatable.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/models/lesson_time.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_lesson_state.g.dart';

@CopyWith(copyWithNull: true)
class AddLessonState extends Equatable {
  final String? description;
  final String? teacherName;
  final String? teacherSurname;
  final String? teacherPatro;

  final LessonSchedule? _lessonSchedule;

  const AddLessonState({
    required this.description,
    required this.teacherName,
    required this.teacherPatro,
    required this.teacherSurname,
    required LessonSchedule? lessonSchedule,
  }) : _lessonSchedule = lessonSchedule;

  const AddLessonState.initial()
      : description = null,
        teacherName = null,
        teacherPatro = null,
        teacherSurname = null,
        _lessonSchedule = null;

  LessonSchedule get _scheduleNow {
    final now = DateTime.now();

    return LessonSchedule(
      startTime: LessonTime.fromDate(now),
      endTime: LessonTime.fromDate(now.add(const Duration(hours: 1))),
      dayOfWeek: now.weekday,
      isOddWeek: false,
    );
  }

  LessonSchedule get lessonSchedule => _lessonSchedule ?? _scheduleNow;

  @override
  List<Object?> get props => [
        description,
        teacherName,
        teacherPatro,
        teacherSurname,
        lessonSchedule,
      ];
}
