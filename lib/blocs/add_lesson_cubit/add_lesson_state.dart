import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timetable/blocs/add_lesson_cubit/add_lesson_request_factory.dart';
import 'package:timetable/models/add_lesson_request.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:timetable/models/teacher.dart';

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

  AddLessonRequest? addLessonRequest(String timetableId) =>
      AddLessonRequestFactory.create(
        description: description,
        teacher: _teacher,
        lessonSchedule: lessonSchedule, 
        timetableId: timetableId,
      );

  bool get isFormValid => AddLessonRequestFactory.validate(
        description: description,
        teacher: _teacher,
      );

  Teacher? get _teacher {
    final name = teacherName;
    final surname = teacherSurname;
    final patro = teacherPatro;
    if (name == null || surname == null || patro == null) return null;
    return Teacher(surname: surname, name: name, patro: patro);
  }

  LessonSchedule get _scheduleNow {
    final now = DateTime.now();

    return LessonSchedule(
      startTime: TimeOfDay.fromDateTime(now),
      endTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
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
