import 'package:timetable/models/lesson_schedule.dart';

extension DateTimeOperators on DateTime {
  bool operator <(LessonSchedule lessonTime) {
    return weekday - 1 < lessonTime.dayOfWeek ||
        (weekday - 1 == lessonTime.dayOfWeek &&
            hour <= lessonTime.startTime.hour &&
            minute < lessonTime.startTime.minute);
  }

  bool operator >(LessonSchedule lessonTime) {
    return weekday - 1 > lessonTime.dayOfWeek ||
        (weekday - 1 == lessonTime.dayOfWeek &&
            hour >= lessonTime.endTime.hour &&
            minute > lessonTime.endTime.minute);
  }
}
