import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/models/timetable_creation_option.dart';
import 'package:timetable/models/extensions/timetable_creation_option_display_items.dart';

class TimetableCreationOptionTile extends StatelessWidget {
  const TimetableCreationOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.goTo,
  }) : super(key: key);

  factory TimetableCreationOptionTile.fromModel(
          TimetableCreationOption option) =>
      TimetableCreationOptionTile(
        icon: option.icon,
        title: option.displayName,
        goTo: option.goTo,
      );

  final IconData icon;
  final String title;
  final Function(BuildContext) goTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goTo(context),
      child: Container(
        decoration: const BoxDecoration(
            // color: CupertinoColors.white,
            // boxShadow: [
            //   BoxShadow(
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     color: Colors.grey,
            //   ),
            // ],
            ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 30),
        // alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32),
            Text(
              title,
              // style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
