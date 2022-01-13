import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timetable/blocs/add_lesson_bloc/add_lesson_bloc.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_bloc.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/utils/extensions/iterable_join_with.dart';
import 'package:timetable/widgets/add_lesson/input_wrapper.dart';
import 'package:timetable/widgets/add_lesson/lesson_schedule_field.dart';
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
        trailing: const _AddLessonButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMargins.margin),
        child: ListView(
          children: const [
            _DescriptionField(),
            _LessonSchedulePicker(),
            _TeacherField(),
          ].joinWith(const SizedBox(height: AppMargins.largeMargin)),
        ),
      ),
    );
  }
}

class _AddLessonButton extends StatelessWidget {
  const _AddLessonButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).pop(),
      child: GestureDetector(
        onTap: () => _handleAddLesson(context),
        child: BlocBuilder<AddLessonBloc, AddLessonState>(
          builder: (context, state) => Text(
            'Готово',
            style: TextStyle(
              color: state.isFormValid
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.systemGrey,
            ),
          ),
        ),
      ),
    );
  }

  void _handleAddLesson(BuildContext context) {
    final timetableDetailsBloc = context.read<TimetableDetailsBloc>();
    final addLessonBloc = context.read<AddLessonBloc>();
    final timetableId = timetableDetailsBloc.state.timetableDetails?.id;

    if (timetableId == null) return;

    addLessonBloc.add(AddLessonSubmit(timetableId: timetableId));
    timetableDetailsBloc.add(TimetableDetailsLoad(timetableId: timetableId));

    AutoRouter.of(context).pop();
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWrapper(
      child: TextInputField(
        onChanged: (description) => context
            .read<AddLessonBloc>()
            .add(AddLessonDescription(description)),
        hintText: 'Название или описание',
      ),
      label: 'Описание',
      isRequired: true,
    );
  }
}

class _TeacherField extends StatelessWidget {
  const _TeacherField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputWrapper(
      child: Row(
        children: [
          TextInputField(
            hintText: 'Фамилия',
            onChanged: (surname) => context
                .read<AddLessonBloc>()
                .add(AddLessonTeacher(teacherSurname: surname)),
          ),
          TextInputField(
            hintText: 'Имя',
            onChanged: (name) => context
                .read<AddLessonBloc>()
                .add(AddLessonTeacher(teacherName: name)),
          ),
          TextInputField(
            hintText: 'Отчество',
            onChanged: (patro) => context
                .read<AddLessonBloc>()
                .add(AddLessonTeacher(teacherParto: patro)),
          ),
        ]
            .map((input) => Expanded(child: input))
            .joinWith(const SizedBox(width: AppMargins.margin)),
      ),
      label: 'Преподаватель',
    );
  }
}

class _LessonSchedulePicker extends StatelessWidget {
  const _LessonSchedulePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLessonBloc, AddLessonState>(
      builder: (context, state) => LessonScheduleFiled(
        onChanged: (lessonSchedule) => context
            .read<AddLessonBloc>()
            .add(AddLessonSchedule(lessonSchedule)),
        value: state.lessonSchedule,
      ),
    );
  }
}
