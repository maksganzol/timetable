import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';
import 'package:timetable/repositories/user_profile_repository/user_profile_repository.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();
    
  final UserProfileRepository _userProfileRepository = DI.locator<UserProfileRepository>();

  TimetableBloc() : super(const TimetableState.initial()) {
    on<TimetableLoad>(_handleLoad);
  }

  Future<void> _handleLoad(
    TimetableLoad event,
    Emitter<TimetableState> emitter,
  ) async {
    final userProfile = await _userProfileRepository.getUserProfile();
    final timetables = await _timetableRepository.timetablesForIdsList(userProfile.timetables);
    
    emitter(TimetableState(timetables: timetables));
  }
}
