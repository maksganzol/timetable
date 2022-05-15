import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

import 'add_timetable_state.dart';

class AddTimetableCubit extends Cubit<AddTimetableState> {
  final UserProfileRepository _userProfileRepository =
      DI.locator<UserProfileRepository>();

  AddTimetableCubit() : super(const AddTimetableState.initial());

  Future<void> addTimetableByCode(String code) async {
    emit(state.copyWith(isLoading: true));
    await _userProfileRepository.addTimetableByCode(code);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> addNewTimetable(String name) async {}
}
