import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/models/extensions/day_of_week_display_name.dart';
import 'package:timetable/models/lesson.dart';
import 'package:timetable/models/lesson_status.dart';
import 'package:timetable/widgets/lessons/lesson_tile.dart';

class LessonsList extends StatelessWidget {
  final List<Lesson> lessons;

  const LessonsList({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  Set<int> get _daysOfWeek =>
      lessons.map((lesson) => lesson.time.dayOfWeek).toSet();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _daysOfWeek.mapIndexed(
        (dayIndex, dayOfWeek) {
          final lessonsForDate = lessons
              .where((lesson) => lesson.time.dayOfWeek == dayOfWeek)
              .toList(growable: false);

          return SliverStickyHeader(
            header: Container(
              padding: const EdgeInsets.only(
                left: AppMargins.margin / 2,
                top: AppMargins.margin,
              ),
              child: Text(
                dayOfWeek.displayName,
                style: const TextStyle(color: CupertinoColors.label),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                _lessonTileBuilder(dayOfWeek, lessonsForDate),
                childCount: lessonsForDate.length,
              ),
            ),
          );
        },
      ).toList(growable: false),
    );
  }

  Widget Function(BuildContext, int) _lessonTileBuilder(
    int dayIndex,
    List<Lesson> lessonsForDay,
  ) =>
      (BuildContext context, int lessonIndex) {
        final lesson = lessonsForDay[lessonIndex];

        return LessonTile(
          isActive: lesson.status == LessonStatus.started,
          title: lesson.description ?? '',
          subtitle: lesson.teacher?.displayName ?? '',
          startTime: lesson.time.startTime,
          endTime: lesson.time.endTime,
        );
      };
}
