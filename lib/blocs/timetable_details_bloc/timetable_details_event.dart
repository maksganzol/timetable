import 'package:equatable/equatable.dart';

abstract class TimetableDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimetableDetailsLoad extends TimetableDetailsEvent {
  final String timetableId;

  TimetableDetailsLoad({
    required this.timetableId,
  });

  @override
  List<Object?> get props => [timetableId];
}
