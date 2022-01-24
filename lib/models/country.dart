import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/utils/type_defs/json.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final String name;
  final String code;
  final String flag;
  @JsonKey(name: 'dial_code')
  final String phoneCode;

  String get displaName {
    return '$name ($phoneCode)';
  }

  const Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [
        name,
        code,
        flag,
        phoneCode,
      ];

  factory Country.fromJson(Json json) => _$CountryFromJson(json);

  Json toJson() => _$CountryToJson(this);
}
