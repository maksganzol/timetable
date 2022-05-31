import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/user_profile.dart';
import 'package:timetable/services/user_profile_service/firebase_user_profile_service.dart';
import 'package:timetable/utils/extensions/generic_apply.dart';

import '../user_profile_repository.dart';

class FirebaseUserProfileRepository extends UserProfileRepository {
  final FirebaseAuth _firebaseAuth = DI.locator<FirebaseAuth>();
  final FirebaseUserProfileService _userProfileService =
      DI.locator<FirebaseUserProfileService>();

  @override
  Future<UserProfile?> getUserProfile() async {
    final userId = _firebaseAuth.currentUser?.uid;

    final userProfile =
        await userId?.app(_userProfileService.getUserProfileForId);

    return userProfile;
  }

  @override
  Future<void> addTimetableByCode(String code) async {
    //In future cod may be not equal to id
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return;
    await _userProfileService.addTimetableToUserById(userId, code);
  }

  @override
  Future<void> removeTimetable(String timetableId) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return;
    await _userProfileService.removeTimetableFromUserById(userId, timetableId);
  }

  @override
  Future<void> addUserProfile() async {
    await _userProfileService.addUserProfile(_firebaseAuth.currentUser!.uid);
  }
}
