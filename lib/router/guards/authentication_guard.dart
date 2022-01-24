import 'package:auto_route/auto_route.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';

abstract class AuthenticationGuard extends AutoRouteGuard {
  AuthenticationGuard({
    required this.authRepository,
  });

  bool get isAuthenticated => authRepository.currentUser != null;

  bool get isGuardPassed;

  PageRouteInfo get guardRoute;

  final AuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (isGuardPassed) {
      resolver.next(true);
    } else {
      router.push(guardRoute);
    }
  }
}
