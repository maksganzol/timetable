import 'package:auto_route/auto_route.dart';
import 'package:timetable/router/guards/check_if_authenticated.dart';
import 'package:timetable/router/guards/check_if_not_authenticated.dart';
import 'package:timetable/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:timetable/screens/sign_in_page.dart';
import 'package:timetable/screens/splash_page.dart';
import 'package:timetable/screens/timetable_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashPage,
      path: 'splash-screen',
      initial: true,
    ),
    AutoRoute(
      path: 'signin',
      page: SigninPage,
      guards: [CheckIfNotAuthenticated],
    ),
    AutoRoute(
      path: 'timetables',
      page: HomePage,
    ),
    AutoRoute(
      path: 'timetables/:timetableId',
      page: TimetablePage,
      guards: [CheckIfAuthenticated],
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  AppRouter({
    required CheckIfAuthenticated checkIfAuthenticatedGuard,
    required CheckIfNotAuthenticated checkIfNotAuthenticated,
  }) : super(
          checkIfAuthenticated: checkIfAuthenticatedGuard,
          checkIfNotAuthenticated: checkIfNotAuthenticated,
        );
}
