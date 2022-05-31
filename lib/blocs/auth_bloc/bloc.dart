import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = DI.locator<AuthRepository>();
  final UserProfileRepository _userProfileRepository = DI.locator<UserProfileRepository>();


  AuthBloc() : super(const AuthState.unauthorized()) {
    on<AuthLoginWithPhone>(_handleLoginWithPhone);
    on<AuthLoginWithGoogle>(_handleLoginWithGoogle);
    on<AuthConfirmPhome>(_handleConfirmPhone);
    on<AuthLogout>(_handleLogout);
    on<AuthInit>(_handleInit);

    add(const AuthInit());
  }

  Future<void> _handleLoginWithPhone(
    AuthLoginWithPhone event,
    Emitter emit,
  ) async {
    final authConfirmationResult =
        await _authRepository.signInWithPhone(phoneNumber: event.phone);

 

    emit(state.copyWith.authConfirmationResult(authConfirmationResult));


  }

  Future<void> _handleLoginWithGoogle(
    AuthLoginWithGoogle event,
    Emitter emit,
  ) async {
    final user = await _authRepository.signInAnonymously();

    emit(state.copyWith.user(user));
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
       
    final userProfile = await _userProfileRepository.getUserProfile();

    if(userProfile == null) {
      await _userProfileRepository.addUserProfile();
    }
    emit(AuthState.authenticated(user));
  }
}
