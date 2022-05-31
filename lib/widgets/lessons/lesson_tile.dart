import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/screens/share_timetable_screen.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final TimeOfDay startTime;
  final TimeOfDay endTime;

  final bool isActive;

  const LessonTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
    required this.isActive,
  }) : super(key: key);

  Color get _activeColor => CupertinoColors.activeBlue;

  BoxDecoration get _activeDecoration => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _activeColor.withOpacity(0),
            _activeColor.withOpacity(0.3),
          ],
        ),
        border: Border(
          right: BorderSide(
            width: 3,
            color: _activeColor,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(title),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        children: [
          _DismissibleAction(
            icon: Icons.edit,
            onPressed: () => {},
          ),
          _DismissibleAction(
            icon: Icons.delete,
            onPressed: () => {},
          )
        ],
        motion: const ScrollMotion(),
      ),
      child: Container(
        width: double.infinity,
        decoration: isActive ? _activeDecoration : null,
        padding: const EdgeInsets.all(AppMargins.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LessonTimeLabel(time: startTime),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      AppTexStyles.b600.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: AppTexStyles.b600,
                ),
              ],
            ),
            _LessonTimeLabel(time: endTime),
          ],
        ),
      ),
    );
  }
}

class _LessonTimeLabel extends StatelessWidget {
  final TimeOfDay time;

  const _LessonTimeLabel({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      time.format(context),
      style: AppTexStyles.b400.copyWith(color: Colors.black.withOpacity(0.5)),
    );
  }
}

class _DismissibleAction extends StatelessWidget {
  const _DismissibleAction({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
