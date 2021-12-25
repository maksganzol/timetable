import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(initialState) : super(const AuthUnauthorized()) {
    on<AuthLogin>(_handleLogin);
    on<AuthLogout>(_handleLogout);
  }

  void _handleLogin(AuthLogin event, Emitter emit) {
    emit(const AuthAuthenticated(token: 'token'));
  }

  void _handleLogout(AuthLogout event, Emitter emit) {
    emit(const AuthUnauthorized());
  }
}
