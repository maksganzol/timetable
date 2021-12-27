import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/models/extensions/timestamp_to_date_time.dart';
import 'package:timetable/utils/type_defs/json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'lesson_time.g.dart';

@JsonSerializable()
class LessonTime extends Equatable {
  @JsonKey(fromJson: TimestampToDateTime.fromJson)
  final DateTime startTime;
  @JsonKey(fromJson: TimestampToDateTime.fromJson)
  final DateTime endTime;
  final int dayOfWeek;
  final bool? isOddWeek;

  const LessonTime({
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.isOddWeek,
  });

  factory LessonTime.fromJson(Json json) => _$LessonTimeFromJson(json);

  Json toJson() => _$LessonTimeToJson(this);

  @override
  List<Object?> get props => [startTime, endTime, dayOfWeek, isOddWeek];
}
