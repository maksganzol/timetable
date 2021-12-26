import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/services/timetable_service/firebase_timetable_service.dart';

class FirebaseTimetableRepository extends TimetableRepository {
  final FirebaseTimetableService _timetableService =
      DI.locator<FirebaseTimetableService>();

  FirebaseTimetableRepository();

  @override
  Future<List<Timetable>> retrieveAllTimetables() async {
    final timetables = await _timetableService.fetchTimetableCollection();
    return timetables;
  }
}
