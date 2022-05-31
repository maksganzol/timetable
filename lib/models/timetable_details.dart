import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/models/lesson.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'timetable_details.g.dart';

@JsonSerializable()
class TimetableDetails extends Equatable {
  final String title;
  final String id;
  final String authorId;

  final List<Lesson> lessons;

  const TimetableDetails({
    required this.title,
    required this.id,
    required this.lessons,
    required this.authorId,
  });

  factory TimetableDetails.fromJson(Json json) =>
      _$TimetableDetailsFromJson(json);

  factory TimetableDetails.fromTimetableAndLessons({
    required Timetable timetable,
    required List<Lesson> lessons,
  }) {
    return TimetableDetails(
      title: timetable.title,
      id: timetable.id,
      lessons: lessons,
      authorId: timetable.authorId
    );
  }

  Json toJson() => _$TimetableDetailsToJson(this);

  @override
  List<Object?> get props => [title, id, lessons, authorId];
}
