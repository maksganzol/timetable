import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/models/extensions/firestore_serializable.dart';
import 'package:timetable/models/user_profile.dart';
import 'package:timetable/services/firebase_firestore_service.dart';
import 'package:timetable/utils/type_defs/json.dart';

class FirebaseUserProfileService extends FirebaseFirestoreService {
  static const _usersCollectionName = 'users';

  CollectionReference<Json> get _collection =>
      firebaseFirestore.collection(_usersCollectionName);

  Future<UserProfile?> getUserProfileForId(String id) async {
    final documentSnapshot = await _collection.doc(id).get();
    return documentSnapshot.toModel(UserProfile.fromJson);
  }

  Future<void> addTimetableToUserById(String userId, String timetableId) async {
    await _collection.doc(userId).update({
      'timetables': FieldValue.arrayUnion([timetableId])
    });
  }

  Future<void> removeTimetableFromUserById(
      String userId, String timetableId) async {
    await _collection.doc(userId).update({
      'timetables': FieldValue.arrayRemove([timetableId])
    });
  }

  Future<void> addUserProfile(String id) async {
    await _collection.doc(id).set(const UserProfile.empty().toJson());
  }
}
