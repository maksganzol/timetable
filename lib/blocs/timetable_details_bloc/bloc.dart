import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_state.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/auth_repository/auth_repository.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

class TimetableDetailsCubit extends Cubit<TimetableDetailsState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();

  final AuthRepository _authRepository = DI.locator<AuthRepository>();
  final UserProfileRepository _userProfileRepository =
      DI.locator<UserProfileRepository>();

  TimetableDetailsCubit() : super(const TimetableDetailsState.initial());

  Future<void> load(String id) async {
    if (id != state.timetableDetails?.id) {
      emit(const TimetableDetailsState.initial());
    }
    final timetableDetails =
        await _timetableRepository.loadTimetableDetails(id: id);
    emit(
      TimetableDetailsState(
        timetableDetails: timetableDetails,
        isLocked: timetableDetails?.authorId != _authRepository.currentUser!.id,
      ),
    );
  }

  Future<void> createCopy() async {
    final newTimetableId =
        await _timetableRepository.createCopy(state.timetableDetails!.id);

    await _userProfileRepository.addTimetableByCode(newTimetableId);
    await _userProfileRepository.removeTimetable(state.timetableDetails!.id );
    await load(newTimetableId);

  }
}
