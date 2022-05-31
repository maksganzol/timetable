import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/add_timetable_request.dart';
import 'package:timetable/models/extensions/firestore_serializable.dart';
import 'package:timetable/models/lesson.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/services/firebase_firestore_service.dart';
import 'package:timetable/utils/type_defs/json.dart';

class FirebaseTimetableService extends FirebaseFirestoreService {
  static const _timetableCollectionName = 'timetables';
  static const _lessonsCollectionName = 'lessons';

  CollectionReference<Json> get _collection =>
      firebaseFirestore.collection(_timetableCollectionName);

  Future<List<Timetable>> fetchTimetableCollection() async {
    final querySnapshot = await _collection.get();
    return querySnapshot.docs.toModels(Timetable.fromJson);
  }

  Future<Timetable?> fetchTimetableById({required String id}) async {
    final documentReference =
        firebaseFirestore.collection(_timetableCollectionName).doc(id);

    final document = await documentReference.get();

    return document.toModel(Timetable.fromJson);
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

  Future<String> addNewTimetable(
    AddTimetableRequest addTimetableRequest,
  ) async {
    final document = await _collection.add(addTimetableRequest.toJson());
    return document.id;
  }

  Future<String> createCopyForUser(String userId, String timetableId) async {
    final document = await _collection.doc(timetableId).get();
    final lessonsDocs = await _collection
        .doc(timetableId)
        .collection(_lessonsCollectionName)
        .get();
    final documentReference =
        await _collection.add(document.data()!..['authorId'] = userId);
    await Future.wait(lessonsDocs.docs.map((doc) => _collection
        .doc(documentReference.id)
        .collection(_lessonsCollectionName)
        .add(doc.data())));
    return documentReference.id;
  }
}
