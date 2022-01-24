import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/user.dart';
import 'package:timetable/repositories/auth_repository/auth_confirmation_result.dart';
import '../extensions/firebase_user_to_user_model.dart';

class FirebaseAuthConfirmationResult extends AuthConfirmationResult {
  const FirebaseAuthConfirmationResult(this.verificationId);
  final String verificationId;

  @override
  Future<User?> confirmPhone(String code) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      final userCredential =
          await DI.locator<FirebaseAuth>().signInWithCredential(credential);
      return userCredential.user?.model;
    } catch (e) {
      return null;
    }
  }
}
