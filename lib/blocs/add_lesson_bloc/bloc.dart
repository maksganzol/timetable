import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_event.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_state.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';

class AddLessonBloc extends Bloc<AddLessonEvent, AddLessonState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();

  AddLessonBloc() : super(const AddLessonState.initial()) {
    on<AddLessonDescription>(_handleAddLessonDescriprion);
    on<AddLessonTeacher>(_handleAddLessonTeacher);
    on<AddLessonSchedule>(_handleAddLessonSchedule);
    on<AddLessonSubmit>(_handleAddLessonSubmit);
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
    if (event.teacherName != null) {
      emit(state.copyWith.teacherName(event.teacherName));
    }
    if (event.teacherParto != null) {
      emit(state.copyWith.teacherPatro(event.teacherParto));
    }
    if (event.teacherSurname != null) {
      emit(state.copyWith.teacherSurname(event.teacherSurname));
    }
  }

  void _handleAddLessonSchedule(
    AddLessonSchedule event,
    Emitter<AddLessonState> emit,
  ) {
    emit(state.copyWith(lessonSchedule: event.lessonSchedule));
  }

  Future<void> _handleAddLessonSubmit(
    AddLessonSubmit event,
    Emitter<AddLessonState> emit,
  ) async {
    final addLessonRequest = state.addLessonRequest(event.timetableId);
    if (addLessonRequest == null) return;
    await _timetableRepository.addLesson(addLessonRequest);
  }
}
