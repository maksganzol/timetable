import 'package:auto_route/auto_route.dart';
import 'package:timetable/screens/home_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
