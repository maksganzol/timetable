import 'package:equatable/equatable.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'add_timetable_request.g.dart';

@JsonSerializable(createToJson: true)
class AddTimetableRequest extends Equatable {
  final String title;
  final TimetableColor color;
  final String authorId;

  const AddTimetableRequest({
    required this.title,
    required this.color,
    required this.authorId,
  });

  @override
  List<Object?> get props => [title, color, authorId];

  Json toJson() => _$AddTimetableRequestToJson(this);
}
