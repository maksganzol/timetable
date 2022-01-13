import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/extensions/firestore_serializable.dart';
import 'package:timetable/models/lesson.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/utils/type_defs/json.dart';

class FirebaseTimetableService {
  final FirebaseFirestore _firebaseFirestore = DI.locator<FirebaseFirestore>();

  static const _timetableCollectionName = 'timetables';
  static const _lessonsCollectionName = 'lessons';

  CollectionReference<Json> get _collection =>
      _firebaseFirestore.collection(_timetableCollectionName);

  Future<List<Timetable>> fetchTimetableCollection() async {
    final querySnapshot = await _collection.get();
    return querySnapshot.docs.toModels(Timetable.fromJson);
  }

  Future<Timetable?> fetchTimetableById({required String id}) async {
    final documentSnapshot = await _firebaseFirestore
        .collection(_timetableCollectionName)
        .doc(id)
        .get();

    return documentSnapshot.toModel(Timetable.fromJson);
  }

  Future<List<Lesson>> fetchLessonsForTimetable({
    required String timetableId,
  }) async {
    final querySnapshot = await _collection
        .doc(timetableId)
        .collection(_lessonsCollectionName)
        .get();

    return querySnapshot.docs.toModels(Lesson.fromJson);
  }

  Future<void> addLessonToTimetable(String timetableId, Json lessonData) async {
    await _collection
        .doc(timetableId)
        .collection(_lessonsCollectionName)
        .add(lessonData);
  }
}
