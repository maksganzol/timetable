import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher extends Equatable {
  final String name;
  final String surname;
  final String patro;

  const Teacher({
    required this.surname,
    required this.name,
    required this.patro,
  });

  String get displayName =>
      '$surname ${name.characters.first}. ${patro.characters.first}.';

  String get nameToAdress => '$name $patro';

  @override
  List<Object?> get props => [surname, name, patro];

  Json toJson() => _$TeacherToJson(this);

  factory Teacher.fromJson(Json json) => _$TeacherFromJson(json);
}
