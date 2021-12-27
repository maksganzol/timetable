import 'package:auto_route/auto_route.dart';
import 'package:timetable/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:timetable/screens/timetable_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: 'timetables',
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      path: 'timetables/:timetableId',
      page: TimetablePage,
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
