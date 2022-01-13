import 'package:flutter/material.dart';
import 'package:timetable/utils/type_defs/json.dart';

extension TimeOfDaySerializable on TimeOfDay {
  static TimeOfDay fromJson(Json json) {
    return TimeOfDay(
      hour: json['hours'] as int,
      minute: (json['minutes'] as int?) ?? 0,
    );
  }

  static Json toJson(TimeOfDay timeOfDay) => {
        'hours': timeOfDay.hour,
        'minutes': timeOfDay.minute,
      };
}
