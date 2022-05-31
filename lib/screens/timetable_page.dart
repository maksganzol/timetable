import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_bloc.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/models/timetable_view_mode.dart';
import 'package:timetable/screens/add_lesson_page.dart';
import 'package:timetable/widgets/empty_list.dart';
import 'package:timetable/widgets/lessons/lessons_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    context.read<TimetableDetailsCubit>().load(widget.timetableId);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        appBar: CupertinoNavigationBar(
          previousPageTitle: 'Расписания',
          trailing: Material(
            child: IconButton(
              onPressed: () => setState(() => viewMode = viewMode.inverted),
              icon: viewMode.icon,
            ),
          ),
          middle: BlocBuilder<TimetableDetailsCubit, TimetableDetailsState>(
            builder: (context, state) {
              final title = state.timetableDetails?.title ?? '...';
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20)),
                  if (state.isLocked)
                    Material(
                      child: IconButton(
                        iconSize: 20,
                        color: CupertinoColors.systemGrey,
                        icon: const Icon(Icons.lock),
                        onPressed: () => _unlockTimetable(context),
                      ),
                    ),
                ],
              );
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
          child: BlocBuilder<TimetableDetailsCubit, TimetableDetailsState>(
            builder: (context, state) => _AddLessonFloatingButton(
              isLocked: state.isLocked,
            ),
          ),
        ),
        body: BlocBuilder<TimetableDetailsCubit, TimetableDetailsState>(
          builder: (context, state) {
            final lessons = state.timetableDetails?.lessons;
            if (lessons == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (lessons.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EmptyListLabel(
                  title: 'Тут пока нет уроков.',
                  subtitle: 'Добавьте первый урок в своё расписание.',
                ),
              );
            }
            return LessonsList(lessons: lessons);
          },
        ),
      ),
    );
  }
}

class _AddLessonFloatingButton extends StatelessWidget {
  const _AddLessonFloatingButton({
    Key? key,
    required this.isLocked,
  }) : super(key: key);
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      color: CupertinoColors.systemBlue,
      icon: const Icon(CupertinoIcons.add),
      onPressed: () async {
        final t = !isLocked || await _unlockTimetable(context);
        if (t) await AddLessonPage.show(context);
      },
    );
  }
}

Future<bool> _unlockTimetable(BuildContext context) async {
  final result = await _showUnlcokDialog(context);
  if (!result) return false;
  await context.read<TimetableDetailsCubit>().createCopy();
  await context.read<TimetableCubit>().load();
  return true;
}

Future<bool> _showUnlcokDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Это чужое расписание'),
      content: const Text(
          'Если вы хотите открыть его для редактирования, вам нужно создать копию.'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Отмена'),
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Создать копию'),
        )
      ],
    ),
  );
  return result ?? false;
}
