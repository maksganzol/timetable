import 'package:equatable/equatable.dart';
import 'package:timetable/models/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:timetable/repositories/auth_repository/auth_confirmation_result.dart';

part 'auth_state.g.dart';

@CopyWith()
class AuthState extends Equatable {
  const AuthState({
    required this.user,
    required this.authConfirmationResult,
  });

  final User? user;
  final AuthConfirmationResult? authConfirmationResult;

  const AuthState.unauthorized()
      : user = null,
        authConfirmationResult = null;

  const AuthState.authenticated(this.user) : authConfirmationResult = null;

  bool get isAuthenticated => user != null;

  @override
  List<Object?> get props => [user];
}
