import 'package:auto_route/auto_route.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/router/guards/authentication_guard.dart';
import 'package:timetable/router/router.dart';

class CheckIfNotAuthenticated extends AuthenticationGuard {
  CheckIfNotAuthenticated()
      : super(authRepository: DI.locator<AuthRepository>());

  @override
  PageRouteInfo get guardRoute => const HomeRoute();

  @override
  bool get isGuardPassed => !isAuthenticated;
}
