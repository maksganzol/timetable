import 'package:timetable/models/lesson_schedule.dart';
import 'package:timetable/models/teacher.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'add_lesson_request.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class AddLessonRequest {
  @JsonKey(ignore: true)
  final String timetableId;
  final String description;
  final Teacher teacher;
  final LessonSchedule time;

  const AddLessonRequest({
    required this.description,
    required this.teacher,
    required this.time,
    required this.timetableId,
  });

  Json toJson() => _$AddLessonRequestToJson(this);
}
