import 'package:timetable/models/user.dart';
import 'package:timetable/repositories/auth_repository/auth_confirmation_result.dart';

abstract class AuthRepository {
  Future<User?> signInAnonymously();
  Future<AuthConfirmationResult> signInWithPhone({
    required String phoneNumber,
  });

  Future<void> logout();
  User? get currentUser;
}
