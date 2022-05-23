import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

import 'add_timetable_state.dart';

class AddTimetableCubit extends Cubit<AddTimetableState> {
  final UserProfileRepository _userProfileRepository =
      DI.locator<UserProfileRepository>();

  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();

  AddTimetableCubit() : super(const AddTimetableState.initial());

  Future<void> addTimetableByCode(String code) async {
    emit(state.copyWith(isLoading: true));
    await _userProfileRepository.addTimetableByCode(code);
    emit(state.copyWith(isLoading: false));
  }

  Future<String> addNewTimetable(String name, TimetableColor color) async {
    emit(state.copyWith(isLoading: true));
    final timetableId = await _timetableRepository.addNewTimetable(name, color);
    await addTimetableByCode(timetableId);
    emit(state.copyWith(isLoading: false));
    return timetableId;

  }
}
