import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_event.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_state.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';
import 'package:timetable/repositories/timetable_repository/timetable_repositoty.dart';

class TimetableDetailsBloc
    extends Bloc<TimetableDetailsEvent, TimetableDetailsState> {
  final TimetableRepository _timetableRepository =
      DI.locator<TimetableRepository>();

  TimetableDetailsBloc() : super(const TimetableDetailsState.initial()) {
    on<TimetableDetailsLoad>(_handleLoad);
  }

  Future<void> _handleLoad(TimetableDetailsLoad event,
      Emitter<TimetableDetailsState> emitter) async {
    if (event.timetableId != state.timetableDetails?.id) {
      emitter(const TimetableDetailsState.initial());
    }
    final timetableDetails = await _timetableRepository.loadTimetableDetails(
      id: event.timetableId,
    );
    emitter(TimetableDetailsState(timetableDetails: timetableDetails));
  }
}
