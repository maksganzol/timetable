import 'package:timetable/models/user.dart';

abstract class AuthConfirmationResult {
  const AuthConfirmationResult();
  Future<User?> confirmPhone(String code);
}
