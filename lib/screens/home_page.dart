import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/router/router.dart';
import 'package:timetable/widgets/timetables/timetable_tile.dart';
import 'package:timetable/utils/extensions/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TimetableBloc>().add(const TimetableLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          const CupertinoSliverNavigationBar(
            backgroundColor: AppColors.creamPink,
            leading: Icon(
              CupertinoIcons.calendar,
              color: Colors.white,
            ),
            largeTitle: Text(
              'Мои расписания',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        body: Container(
          color: AppColors.creamPink.withOpacity(0.05),
          child: BlocBuilder<TimetableBloc, TimetableState>(
            builder: (context, state) => _TimetableList(
              timetables: state.timetables,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimetableList extends StatelessWidget {
  final List<Timetable> timetables;

  const _TimetableList({
    Key? key,
    required this.timetables,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: timetables
          .map(
            (timetable) => TimetableTile(
              title: timetable.title,
              color: timetable.color.materialColor,
              onPressed: () => AutoRouter.of(context).push(
                TimetableRoute(timetableId: timetable.id),
              ),
            ),
          )
          .joinWith(const SizedBox(height: 5)),
    );
  }
}