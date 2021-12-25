import 'package:equatable/equatable.dart';
import 'package:timetable/models/user.dart';

class AuthState extends Equatable {
  final User? user;

  const AuthState.unauthorized() : user = null;

  const AuthState.authenticated(this.user);

  bool get isAuthenticated => user != null;

  @override
  List<Object?> get props => [user];
}
