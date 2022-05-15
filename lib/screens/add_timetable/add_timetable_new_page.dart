import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/blocs/add_timetable_cubit/add_timetable_cubit.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/widgets/add_timetable/add_timetable_form_template.dart';

class AddTimetableNewPage extends StatefulWidget {
  const AddTimetableNewPage({Key? key}) : super(key: key);

  @override
  State<AddTimetableNewPage> createState() => _AddTimetableNewPageState();
}

class _AddTimetableNewPageState extends State<AddTimetableNewPage> {
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
        middle: Text('Новое расписание'),
      ),
      body: AddTimetableFormTemplate(
        controller: _controller,
        onSubmit: () async {
          await context
              .read<AddTimetableCubit>()
              .addNewTimetable(_controller.text);
          await context.read<TimetableCubit>().load();
          AutoRouter.of(context).popUntilRoot();
        },
        inputHintText: 'Название расписания',
      ),
    );
  }
}
