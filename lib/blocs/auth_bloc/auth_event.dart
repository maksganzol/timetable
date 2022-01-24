import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent {
  final String phone;
  const AuthLogin(this.phone);

  @override
  List<Object?> get props => [phone];
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}

class AuthInit extends AuthEvent {
  const AuthInit();
}

class AuthConfirmPhome extends AuthEvent {
  final String code;
  const AuthConfirmPhome(this.code);

  @override
  List<Object?> get props => [code];
}
