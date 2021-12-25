import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthAuthenticated extends AuthState {
  final String token;

  const AuthAuthenticated({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}

class AuthUnauthorized extends AuthState {
  const AuthUnauthorized();
}
