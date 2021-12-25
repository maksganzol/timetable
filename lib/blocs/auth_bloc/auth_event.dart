import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent {
  const AuthLogin();

  @override
  List<Object?> get props => [];
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}

class AuthInit extends AuthEvent {
  const AuthInit();
}
