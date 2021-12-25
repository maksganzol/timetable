import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/repositories/auth_repository/impl/firebase_auth_repository.dart';

class DI {
  static GetIt locator = GetIt.instance;
  static inject() {
    locator.registerSingleton<AuthRepository>(
      FirebaseAuthRepository(FirebaseAuth.instance),
    );
  }
}
