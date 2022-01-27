import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/user.dart';
import 'package:timetable/repositories/auth_repository/auth_confirmation_result.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/repositories/auth_repository/impl/firebase_auth_confirmation_result.dart';
import '../extensions/firebase_user_to_user_model.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth = DI.locator<FirebaseAuth>();

  @override
  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user?.model;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser?.model;

  @override
  Future<AuthConfirmationResult> signInWithPhone({
    required String phoneNumber,
  }) async {
    //TODO: Handle Error
    final completer = Completer<AuthConfirmationResult>();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) => completer.complete(
        FirebaseAuthConfirmationResult(verificationId),
      ),
      verificationCompleted: (_) {},
      verificationFailed: (error) {
        print('Error $error');
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    return completer.future;
  }


  
}
