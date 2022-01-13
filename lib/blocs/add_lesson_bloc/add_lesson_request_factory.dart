import 'package:timetable/models/add_lesson_request.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/models/teacher.dart';

abstract class AddLessonRequestFactory {
  static AddLessonRequest? create({
    required String? description,
    required Teacher? teacher,
    required LessonSchedule lessonSchedule,
    required String timetableId,
  }) {
    if (description == null || teacher == null) return null;

    return AddLessonRequest(
      description: description,
      teacher: teacher,
      time: lessonSchedule,
      timetableId: timetableId,
    );
  }

  static bool validate({
    required String? description,
    required Teacher? teacher,
  }) =>
      description != null && teacher != null;
}
