import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String displayName;

  const User({
    required this.id,
    required this.displayName,
  });

  @override
  List<Object?> get props => [id, displayName];

  Json toJson() => _$UserToJson(this);

  factory User.fromJson(Json json) => _$UserFromJson(json);
}
