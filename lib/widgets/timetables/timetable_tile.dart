import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:timetable/blocs/timetable_cubit/bloc.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/screens/share_timetable_screen.dart';

class TimetableTile extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const TimetableTile({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        children: [
          _DismissibleAction(
            icon: Icons.share,
            onPressed: () => ShareTimetableScreen.show(
              context,
              timetableIdentificator: id,
              timetableTitle: title,
              timetableColor: color,
            ),
          ),
          _DismissibleAction(
            icon: Icons.delete,
            onPressed: () => context.read<TimetableCubit>().removeTimetable(id),
          )
        ],
        motion: const ScrollMotion(),
      ),
      key: ValueKey(title),
      child: InkWell(
        splashColor: color.withOpacity(0.1),
        hoverColor: color.withOpacity(0.05),
        highlightColor: color.withOpacity(0.05),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(AppMargins.margin),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.indigo050,
                blurRadius: 10,
                offset: Offset(3, 0),
              )
            ],
            border: Border(left: BorderSide(color: color, width: 3)),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTexStyles.h100,
              ),
              const Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
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
