import 'package:timetable/models/extensions/firestore_serializable.dart';
import 'package:timetable/models/user_profile.dart';
import 'package:timetable/services/firebase_firestore_service.dart';

class FirebaseUserProfileService extends FirebaseFirestoreService{
  static const _usersCollectionName = 'users';
  Future<UserProfile?> getUserProfileForId(String id) async {
    final documentSnapshot = await firebaseFirestore.collection(_usersCollectionName).doc(id).get();
    return documentSnapshot.toModel(UserProfile.fromJson);
  }

}