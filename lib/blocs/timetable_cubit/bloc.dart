import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();
    
  final UserProfileRepository _userProfileRepository = DI.locator<UserProfileRepository>();

  TimetableCubit() : super(const TimetableState.initial());

  Future<void> load(
  ) async {
    final userProfile = await _userProfileRepository.getUserProfile();
    final timetables = await _timetableRepository.timetablesForIdsList(userProfile.timetables);
    
    emit(TimetableState(timetables: timetables));
  }

  Future<void> removeTimetable(String id) async {
    await _userProfileRepository.removeTimetable(id);
    await load();
  }
}
