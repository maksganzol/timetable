import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/extensions/firestore_serializable.dart';
import 'package:timetable/models/timetable.dart';

class FirebaseTimetableService {
  final FirebaseFirestore _firebaseFirestore = DI.locator<FirebaseFirestore>();

  static const _timetableCollectionName = 'timetables';

  Future<List<Timetable>> fetchTimetableCollection() async {
    final querySnapshot =
        await _firebaseFirestore.collection(_timetableCollectionName).get();

    final timetables = querySnapshot.docs.toModels(Timetable.fromJson);

    return timetables;
  }
}
