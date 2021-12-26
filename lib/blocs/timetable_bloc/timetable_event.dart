import 'package:equatable/equatable.dart';

abstract class TimetableEvent extends Equatable {
  @override
  const TimetableEvent();

  @override
  List<Object?> get props => [];
}

class TimetableLoad extends TimetableEvent {
  const TimetableLoad();
}
