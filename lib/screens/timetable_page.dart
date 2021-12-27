import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_bloc.dart';
import 'package:timetable/models/timetable_view_mode.dart';
import 'package:timetable/widgets/lessons/lessons_list.dart';

class TimetablePage extends StatefulWidget {
  final String timetableId;
  const TimetablePage({
    Key? key,
    @PathParam('timetableId') required this.timetableId,
  }) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  ViewMode viewMode = ViewMode.list;

  @override
  void initState() {
    super.initState();
    context
        .read<TimetableDetailsBloc>()
        .add(TimetableDetailsLoad(timetableId: widget.timetableId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: Material(
          child: IconButton(
            onPressed: () => setState(() => viewMode = viewMode.inverted),
            icon: viewMode.icon,
          ),
        ),
        middle: BlocBuilder<TimetableDetailsBloc, TimetableDetailsState>(
          builder: (context, state) {
            final title = state.timetableDetails?.title ?? 'Loading...';
            return Text(title, style: const TextStyle(fontSize: 20));
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: IconButton(
          splashColor: Colors.transparent,
          color: CupertinoColors.systemBlue,
          icon: const Icon(CupertinoIcons.add),
          onPressed: () => {},
        ),
      ),
      body: BlocBuilder<TimetableDetailsBloc, TimetableDetailsState>(
        builder: (context, state) {
          final lessons = state.timetableDetails?.lessons;
          if (lessons == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return LessonsList(lessons: lessons);
        },
      ),
    );
  }
}
