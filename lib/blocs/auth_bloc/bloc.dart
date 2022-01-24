import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = DI.locator<AuthRepository>();

  AuthBloc() : super(const AuthState.unauthorized()) {
    on<AuthLogin>(_handleLogin);
    on<AuthConfirmPhome>(_handleConfirmPhone);
    on<AuthLogout>(_handleLogout);
    on<AuthInit>(_handleInit);

    add(const AuthInit());
  }

  Future<void> _handleLogin(AuthLogin event, Emitter emit) async {
    final authConfirmationResult =
        await _authRepository.signInWithPhone(phoneNumber: event.phone);

    emit(state.copyWith.authConfirmationResult(authConfirmationResult));
  }

  Future<void> _handleLogout(AuthLogout event, Emitter emit) async {
    await _authRepository.logout();
    emit(const AuthState.unauthorized());
  }

  void _handleInit(AuthInit event, Emitter emit) {
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      // add(const AuthLogin());
      return;
    }
    emit(AuthState.authenticated(_authRepository.currentUser));
  }

  void _handleConfirmPhone(AuthConfirmPhome event, Emitter emit) async {
    final user = await state.authConfirmationResult?.confirmPhone(event.code);
    emit(AuthState.authenticated(user));
  }
}
