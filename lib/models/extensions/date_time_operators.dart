import 'package:timetable/models/lesson_schedule.dart';

extension DateTimeOperators on DateTime {
  bool operator <(LessonSchedule lessonTime) {
    return weekday - 1 < lessonTime.dayOfWeek ||
        (weekday - 1 == lessonTime.dayOfWeek &&
            hour <= lessonTime.startTime.hours &&
            minute < lessonTime.startTime.minutes);
  }

  bool operator >(LessonSchedule lessonTime) {
    return weekday - 1 > lessonTime.dayOfWeek ||
        (weekday - 1 == lessonTime.dayOfWeek &&
            hour >= lessonTime.endTime.hours &&
            minute > lessonTime.endTime.minutes);
  }
}
