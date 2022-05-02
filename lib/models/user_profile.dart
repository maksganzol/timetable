import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'user_profile.g.dart';

@JsonSerializable()

class UserProfile extends Equatable {
  final List<String> timetables;

  const UserProfile({
    required this.timetables,
  }); 

  const UserProfile.empty(): timetables = const [];

  @override
  List<Object?> get props => [timetables];

  Json toJson() => _$UserProfileToJson(this);

  factory UserProfile.fromJson(Json json) => _$UserProfileFromJson(json);
}
