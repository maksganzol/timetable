// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    TimetableRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TimetableRouteArgs>(
          orElse: () => TimetableRouteArgs(
              timetableId: pathParams.getString('timetableId')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: TimetablePage(key: args.key, timetableId: args.timetableId));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'timetables', fullMatch: true),
        RouteConfig(HomeRoute.name, path: 'timetables'),
        RouteConfig(TimetableRoute.name, path: 'timetables/:timetableId')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'timetables');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [TimetablePage]
class TimetableRoute extends PageRouteInfo<TimetableRouteArgs> {
  TimetableRoute({Key? key, required String timetableId})
      : super(TimetableRoute.name,
            path: 'timetables/:timetableId',
            args: TimetableRouteArgs(key: key, timetableId: timetableId),
            rawPathParams: {'timetableId': timetableId});

  static const String name = 'TimetableRoute';
}

class TimetableRouteArgs {
  const TimetableRouteArgs({this.key, required this.timetableId});

  final Key? key;

  final String timetableId;

  @override
  String toString() {
    return 'TimetableRouteArgs{key: $key, timetableId: $timetableId}';
  }
}
