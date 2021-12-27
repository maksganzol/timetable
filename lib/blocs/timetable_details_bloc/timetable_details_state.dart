import 'package:equatable/equatable.dart';
import 'package:timetable/models/timetable_details.dart';

class TimetableDetailsState extends Equatable {
  final TimetableDetails? timetableDetails;

  const TimetableDetailsState({required this.timetableDetails});

  const TimetableDetailsState.initial() : timetableDetails = null;

  @override
  List<Object?> get props => [timetableDetails];
}
