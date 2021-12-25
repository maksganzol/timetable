import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = DI.locator<AuthRepository>();

  AuthBloc() : super(const AuthState.unauthorized()) {
    on<AuthLogin>(_handleLogin);
    on<AuthLogout>(_handleLogout);
    on<AuthInit>(_handleInit);

    add(const AuthInit());
  }

  Future<void> _handleLogin(AuthLogin event, Emitter emit) async {
    final user = await _authRepository.signInAnonymously();
    if (user != null) {
      emit(AuthState.authenticated(user));
    }
  }

  Future<void> _handleLogout(AuthLogout event, Emitter emit) async {
    await _authRepository.logout();
    emit(const AuthState.unauthorized());
  }

  void _handleInit(AuthInit event, Emitter emit) {
    emit(AuthState.authenticated(_authRepository.currentUser));
  }
}
