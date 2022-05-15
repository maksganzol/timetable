import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/blocs/timetable_cubit/bloc.dart';
import 'package:timetable/configuration/configuration.dart';

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
    return Dismissible(
      background: Container(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _DismissibleAction(icon: Icons.share, label: 'Поделиться'),
            _DismissibleAction(icon: Icons.delete, label: 'Удалить')
          ],
        ),
      ),
      key: ValueKey(title),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          context.read<TimetableCubit>().removeTimetable(id);
          return true;
        }
        return false;
      },
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
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
