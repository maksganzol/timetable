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

  String get displayName => _names[this];
}
