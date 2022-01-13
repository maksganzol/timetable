import 'package:timetable/models/add_lesson_request.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/models/timetable_details.dart';

abstract class TimetableRepository {
  Future<List<Timetable>> retrieveAllTimetables();
  Future<TimetableDetails?> loadTimetableDetails({required String id});
  Future<void> addLesson(AddLessonRequest addLessonRequest);
}
