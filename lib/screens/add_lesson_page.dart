import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/widgets/add_lesson/input_wrapper.dart';
import 'package:timetable/widgets/add_lesson/text_input_field.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({Key? key}) : super(key: key);

  static show(BuildContext context) {
    CupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => const AddLessonPage(),
    );
  }

  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          child: const Icon(
            CupertinoIcons.xmark_circle,
            color: CupertinoColors.destructiveRed,
          ),
          onTap: () => AutoRouter.of(context).pop(),
        ),
        middle: const Text('Добавить урок'),
        trailing: GestureDetector(
          onTap: () => AutoRouter.of(context).pop(),
          child: const Text(
            'Готово',
            style: TextStyle(color: CupertinoColors.systemGreen),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMargins.margin),
        child: ListView(
          children: const [
            InputWrapper(
              child: TextInputField(),
              label: 'Описание',
            ),
          ],
        ),
      ),
    );
  }
}
