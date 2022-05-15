import 'package:flutter/material.dart';
import 'package:timetable/models/timetable_creation_option.dart';
import 'package:timetable/screens/add_timetable/add_timetable_code_page.dart';
import 'package:timetable/screens/add_timetable/add_timetable_new_page.dart';
import 'package:timetable/widgets/modal_bottom_sheet_navigator.dart';

extension TimetableCreationOptionDisplayItems on TimetableCreationOption {
  String get displayName {
    switch (this) {
      case TimetableCreationOption.code:
        return 'Ввести код';
      case TimetableCreationOption.qr:
        return 'Сканировать QR';
      case TimetableCreationOption.manual:
        return 'Создать свое';
    }
  }

  IconData get icon {
    switch (this) {
      case TimetableCreationOption.code:
        return Icons.share;
      case TimetableCreationOption.qr:
        return Icons.qr_code;
      case TimetableCreationOption.manual:
        return Icons.create;
    }
  }

  Function(BuildContext) get goTo {
    switch (this) {
      case TimetableCreationOption.code:
        return (context) => ModalBottomSheetNavigator.push(
              context,
              const AddTimetableCodePage(),
            );
      case TimetableCreationOption.qr:
        return (_) => {};
      case TimetableCreationOption.manual:
        return (context) => ModalBottomSheetNavigator.push(
              context,
              const AddTimetableNewPage(),
            );
    }
  }
}
