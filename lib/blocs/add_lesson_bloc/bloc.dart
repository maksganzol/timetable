import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_event.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_state.dart';

class AddLessonBloc extends Bloc<AddLessonEvent, AddLessonState> {
  AddLessonBloc() : super(const AddLessonState.initial()) {
    on<AddLessonDescription>(_handleAddLessonDescriprion);
    on<AddLessonTeacher>(_handleAddLessonTeacher);
    on<AddLessonSchedule>(_handleAddLessonSchedule);
  }

  void _handleAddLessonDescriprion(
    AddLessonDescription event,
    Emitter<AddLessonState> emit,
  ) {
    final description = event.description;
    if (description == null || description.isEmpty) {
      emit(state.copyWithNull(description: true));
      return;
    }
    emit(state.copyWith(description: description));
  }

  void _handleAddLessonTeacher(
    AddLessonTeacher event,
    Emitter<AddLessonState> emit,
  ) {
    emit(
      state.copyWith(
        teacherName: event.teacherName,
        teacherPatro: event.teacherParto,
        teacherSurname: event.teacherSurname,
      ),
    );
  }

  void _handleAddLessonSchedule(
    AddLessonSchedule event,
    Emitter<AddLessonState> emit,
  ) {
    emit(state.copyWith(lessonSchedule: event.lessonSchedule));
  }
}
