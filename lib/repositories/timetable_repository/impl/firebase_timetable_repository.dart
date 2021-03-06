import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/add_lesson_request.dart';
import 'package:timetable/models/add_timetable_request.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/models/timetable_details.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/services/timetable_service/firebase_timetable_service.dart';

class FirebaseTimetableRepository extends TimetableRepository {
  final FirebaseTimetableService _timetableService =
      DI.locator<FirebaseTimetableService>();

  final FirebaseAuth _firebaseAuth = DI.locator<FirebaseAuth>();

  @override
  Future<List<Timetable>> retrieveAllTimetables() async {
    final timetables = await _timetableService.fetchTimetableCollection();
    return timetables;
  }

  @override
  Future<List<Timetable>> timetablesForIdsList(List<String> ids) async {
    final timetables = await _timetableService.fetchTimetableCollection();
    return timetables
        .where((timetable) => ids.any((id) => timetable.id == id))
        .toList(growable: false);
  }

  @override
  Future<TimetableDetails?> loadTimetableDetails({required String id}) async {
    final timetable = await _timetableService.fetchTimetableById(id: id);
    if (timetable == null) return null;

    final lessons = await _timetableService.fetchLessonsForTimetable(
      timetableId: id,
    );

    return TimetableDetails.fromTimetableAndLessons(
      timetable: timetable,
      lessons: lessons,
    );
  }

  @override
  Future<void> addLesson(AddLessonRequest addLessonRequest) async {
    await _timetableService.addLessonToTimetable(
      addLessonRequest.timetableId,
      addLessonRequest.toJson(),
    );
  }

  @override
  Future<String> addNewTimetable(String name, TimetableColor color) async {
    final newTimetableId = await _timetableService.addNewTimetable(
      AddTimetableRequest(
        color: color,
        title: name,
        authorId: _firebaseAuth.currentUser!.uid,
      ),
    );
    return newTimetableId;
  }

  @override
  Future<String> createCopy(String timetableId) async {
    return await _timetableService.createCopyForUser(
      _firebaseAuth.currentUser!.uid,
      timetableId,
    );
  }
}
