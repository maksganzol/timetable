import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/blocs/add_timetable_cubit/add_timetable_cubit.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/models/add_timetable_request.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/router/router.dart';
import 'package:timetable/utils/extensions/iterable_join_with.dart';
import 'package:timetable/widgets/add_timetable/add_timetable_form_template.dart';

class AddTimetableNewPage extends StatefulWidget {
  const AddTimetableNewPage({Key? key}) : super(key: key);

  @override
  State<AddTimetableNewPage> createState() => _AddTimetableNewPageState();
}

class _AddTimetableNewPageState extends State<AddTimetableNewPage> {
  late final TextEditingController _controller;

  TimetableColor _selectedColor = TimetableColor.values.first;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: 'Добавить расписание',
        middle: const Text('Новое расписание'),
        backgroundColor: _selectedColor.materialColor.withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        child: AddTimetableFormTemplate(
          controller: _controller,
          onSubmit: () async {
           final timetableId =  await context.read<AddTimetableCubit>().addNewTimetable(
                  _controller.text,
                  _selectedColor,
                );
            await context.read<TimetableCubit>().load();
            AutoRouter.of(context).popUntilRoot();
          AutoRouter.of(context).push(TimetableRoute(timetableId: timetableId));
          },
          inputHintText: 'Название расписания',
          child: _TimetableColorPicker(
            selectedColor: _selectedColor,
            onColorChanged: (color) => setState(() {
              _selectedColor = color;
            }),
          ),
        ),
      ),
    );
  }
}

class _TimetableColorPicker extends StatelessWidget {
  const _TimetableColorPicker({
    Key? key,
    required this.selectedColor,
    required this.onColorChanged,
  }) : super(key: key);

  final TimetableColor selectedColor;
  final ValueChanged<TimetableColor> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Выберите цвет'),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: TimetableColor.values
              .map(
                (color) => GestureDetector(
                  onTap: () => onColorChanged(color),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: selectedColor == color
                          ? Border.all(
                              color: CupertinoColors.systemBlue, width: 2)
                          : null,
                      shape: BoxShape.circle,
                      color: color.materialColor.withOpacity(
                        selectedColor == color ? 1 : 0.7,
                      ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}
