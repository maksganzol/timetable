import 'package:equatable/equatable.dart';
import 'package:timetable/models/timetable_details.dart';

class TimetableDetailsState extends Equatable {
  final TimetableDetails? timetableDetails;
  final bool isLocked;

  const TimetableDetailsState(
      {required this.timetableDetails, required this.isLocked});

  const TimetableDetailsState.initial()
      : timetableDetails = null,
        isLocked = false;

  @override
  List<Object?> get props => [timetableDetails];
}
