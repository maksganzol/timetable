extension DayOfWeekDisplayName on int {
  List<String> get _names => [
        'Понедельник',
        'Вторник',
        'Среда',
        'Четверг',
        'Пятница',
        'Суббота',
        'Воскресенье',
      ];

  List<String> get _shortNames => [
        'Вс',
        'Пн',
        'Вт',
        'Ср',
        'Чт',
        'Пт',
        'Сб',
      ];

  String get displayName => _names[this];
  String get shortName => _shortNames[this];
}
