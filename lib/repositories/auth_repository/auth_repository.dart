import 'package:timetable/models/user.dart';

abstract class AuthRepository {
  Future<User?> signInAnonymously();
  Future<void> logout();
  User? get currentUser;
}
