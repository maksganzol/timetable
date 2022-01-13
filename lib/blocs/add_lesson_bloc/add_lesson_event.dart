import 'package:equatable/equatable.dart';
import 'package:timetable/models/lesson_schedule.dart';

abstract class AddLessonEvent extends Equatable {
  const AddLessonEvent();

  @override
  List<Object?> get props => [];
}

class AddLessonDescription extends AddLessonEvent {
  final String? description;

  const AddLessonDescription(this.description);

  @override
  List<Object?> get props => [description];
}

class AddLessonTeacher extends AddLessonEvent {
  final String? teacherName;
  final String? teacherSurname;
  final String? teacherParto;

  const AddLessonTeacher({
    this.teacherName,
    this.teacherSurname,
    this.teacherParto,
  });

  @override
  List<Object?> get props => [
        teacherName,
        teacherSurname,
        teacherParto,
      ];
}

class AddLessonSchedule extends AddLessonEvent {
  final LessonSchedule? lessonSchedule;

  const AddLessonSchedule(this.lessonSchedule);

  @override
  List<Object?> get props => [lessonSchedule];
}

class AddLessonSubmit extends AddLessonEvent {
  final String timetableId;

  const AddLessonSubmit({required this.timetableId});

  @override
  List<Object?> get props => [timetableId];
}
