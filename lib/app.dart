import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/blocs/timetable_bloc/bloc.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/router/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  List<BlocProvider> get _blocProviders => [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<TimetableBloc>(create: (_) => TimetableBloc()),
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
