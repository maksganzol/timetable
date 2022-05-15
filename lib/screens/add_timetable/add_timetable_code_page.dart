import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/add_timetable_cubit/add_timetable_cubit.dart';
import 'package:timetable/blocs/timetable_cubit/bloc.dart';
import 'package:timetable/widgets/add_timetable/add_timetable_form_template.dart';

class AddTimetableCodePage extends StatefulWidget {
  const AddTimetableCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTimetableCodePageState();
}

class _AddTimetableCodePageState extends State<AddTimetableCodePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        previousPageTitle: 'Добавить расписание',
        middle: Text('Введите код'),
      ),
      body: AddTimetableFormTemplate(
        controller: _controller,
        onSubmit: () async {
          await context
              .read<AddTimetableCubit>()
              .addTimetableByCode(_controller.text);
          await context.read<TimetableCubit>().load();
          AutoRouter.of(context).popUntilRoot();
        },
        inputHintText: 'Код рассписания',
      ),
    );
  }
}
