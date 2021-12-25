import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetable/models/user.dart' as user_model;

extension FirebaseUserToUserModel on User {
  user_model.User get model => user_model.User(
        id: uid,
        displayName: displayName ?? '',
      );
}
