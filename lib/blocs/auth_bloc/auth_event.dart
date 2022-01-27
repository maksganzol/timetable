import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoginWithPhone extends AuthEvent {
  final String phone;
  const AuthLoginWithPhone(this.phone);

  @override
  List<Object?> get props => [phone];
}

class AuthLoginWithGoogle extends AuthEvent {
  const AuthLoginWithGoogle();
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
