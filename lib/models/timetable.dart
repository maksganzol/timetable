import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timetable.g.dart';

@JsonSerializable()
class Timetable extends Equatable {
  final String id;
  final String title;

  const Timetable({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [];

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableToJson(this);
}
