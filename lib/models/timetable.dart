import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'timetable.g.dart';

@JsonSerializable()
class Timetable extends Equatable {
  final String id;
  final String title;
  final TimetableColor color;

  const Timetable({
    required this.id,
    required this.title,
    required this.color,
  });

  @override
  List<Object?> get props => [];

  factory Timetable.fromJson(Json json) => _$TimetableFromJson(json);

  Json toJson() => _$TimetableToJson(this);
}
