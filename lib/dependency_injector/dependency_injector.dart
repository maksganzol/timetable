import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/repositories/auth_repository/impl/firebase_auth_repository.dart';
import 'package:timetable/repositories/timetable_repository/impl/firebase_timetable_repository.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/repositories/user_profile_repository/impl/firebase_user_profile_repository.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';
import 'package:timetable/router/guards/check_if_authenticated.dart';
import 'package:timetable/router/guards/check_if_not_authenticated.dart';
import 'package:timetable/router/router.dart';
import 'package:timetable/services/timetable_service/firebase_timetable_service.dart';
import 'package:timetable/services/user_profile_service/firebase_user_profile_service.dart';

abstract class DI {
  static GetIt locator = GetIt.instance;
  static void inject() {
    // API
    locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

    // Services
    locator.registerSingleton<FirebaseTimetableService>(
      FirebaseTimetableService(),
    );
    locator.registerSingleton<FirebaseUserProfileService>(
      FirebaseUserProfileService(),
    );

    // Repositories
    locator.registerSingleton<AuthRepository>(FirebaseAuthRepository());
    locator.registerSingleton<TimetableRepository>(
      FirebaseTimetableRepository(),
    );
    locator.registerSingleton<UserProfileRepository>(
      FirebaseUserProfileRepository(),
    );

    // Router
    locator.registerSingleton<AppRouter>(
      AppRouter(
        checkIfAuthenticatedGuard: CheckIfAuthenticated(),
        checkIfNotAuthenticated: CheckIfNotAuthenticated(),
      ),
    );
  }
}
