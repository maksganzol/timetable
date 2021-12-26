import 'package:timetable/models/timetable.dart';

abstract class TimetableRepository {
  Future<List<Timetable>> retrieveAllTimetables();
}
