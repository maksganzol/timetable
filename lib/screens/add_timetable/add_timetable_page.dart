import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timetable/models/timetable_creation_option.dart';
import 'package:timetable/widgets/add_timetable/timetable_creation_option_tile.dart';
import 'package:timetable/widgets/modal_bottom_sheet_navigator.dart';

class AddTimetablePage extends StatelessWidget {
  const AddTimetablePage({Key? key}) : super(key: key);

  static show(BuildContext context) {
    CupertinoScaffold.showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      builder: (context) => const AddTimetablePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: TimetableCreationOption.values
            .map(TimetableCreationOptionTile.fromModel)
            .toList(growable: false),
      ),
    );
  }
}
