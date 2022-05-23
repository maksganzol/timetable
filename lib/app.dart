import 'package:flutter/material.dart';
import 'package:timetable/blocs/add_lesson_cubit/bloc.dart';
import 'package:timetable/blocs/add_timetable_cubit/add_timetable_cubit.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/router/router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  List<BlocProvider> get _blocProviders => [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<TimetableCubit>(create: (_) => TimetableCubit()),
        BlocProvider<AddLessonCubit>(create: (_) => AddLessonCubit()),
        BlocProvider<TimetableDetailsBloc>(
          create: (_) => TimetableDetailsBloc(),
        ),
        BlocProvider<AddTimetableCubit>(create: (_) => AddTimetableCubit()),

      ];

  @override
  Widget build(BuildContext context) {
    final router = DI.locator<AppRouter>();
    return MultiBlocProvider(
      providers: _blocProviders,
      child: MaterialApp.router(
        routeInformationParser: router.defaultRouteParser(),
        routerDelegate: router.delegate(),
      ),
    );
  }
}
