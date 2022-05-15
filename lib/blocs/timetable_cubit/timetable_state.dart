import 'package:equatable/equatable.dart';
import 'package:timetable/models/timetable.dart';

class TimetableState extends Equatable {
  final List<Timetable> timetables;

  const TimetableState({
    required this.timetables,
  });

  const TimetableState.initial() : timetables = const [];

  @override
  List<Object?> get props => [timetables];
}
