import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_timetable_state.g.dart';

@CopyWith(copyWithNull: true)
class AddTimetableState extends Equatable {
  final bool isLoading;

  const AddTimetableState({required this.isLoading });

  const AddTimetableState.initial(): isLoading = false;

  @override
  List<Object?> get props => [isLoading];
}
