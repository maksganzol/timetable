import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/add_lesson_cubit/add_lesson_state.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();

  AddLessonCubit() : super(const AddLessonState.initial());

  void addLessonDescriprion(String? description) {
    if (description == null || description.isEmpty) {
      emit(state.copyWithNull(description: true));
      return;
    }
    emit(state.copyWith(description: description));
  }

  void addLessonTeacher({
     String? teacherName,
     String? teacherParto,
     String? teacherSurname,
  }) {
    if (teacherName != null) {
      emit(state.copyWith.teacherName(teacherName));
    }
    if (teacherParto != null) {
      emit(state.copyWith.teacherPatro(teacherParto));
    }
    if (teacherSurname != null) {
      emit(state.copyWith.teacherSurname(teacherSurname));
    }
  }

  void addLessonSchedule(LessonSchedule lessonSchedule) {
    emit(state.copyWith(lessonSchedule: lessonSchedule));
  }

  Future<void> submitLesson(String timetableId) async {
    final addLessonRequest = state.addLessonRequest(timetableId);
    if (addLessonRequest == null) return;
    await _timetableRepository.addLesson(addLessonRequest);
  }
}
