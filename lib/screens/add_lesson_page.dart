import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timetable/blocs/add_lesson_cubit/add_lesson_cubit.dart';
import 'package:timetable/blocs/timetable_details_bloc/timetable_details_bloc.dart';
import 'package:timetable/configuration/app_margings.dart';
import 'package:timetable/models/lesson_schedule.dart';

import 'package:timetable/utils/extensions/iterable_join_with.dart';
import 'package:timetable/widgets/add_lesson/input_wrapper.dart';
import 'package:timetable/widgets/add_lesson/lesson_schedule_field.dart';
import 'package:timetable/widgets/add_lesson/text_input_field.dart';
import 'package:timetable/widgets/add_lesson/weekday_picker.dart';

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
    return BlocBuilder<TimetableDetailsBloc, TimetableDetailsState>(
      builder: (context, state) => Scaffold(
        appBar: CupertinoNavigationBar(
          previousPageTitle: state.timetableDetails?.title ?? '...',
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
        child: BlocBuilder<AddLessonCubit, AddLessonState>(
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

  void _handleAddLesson(BuildContext context) async {
    final timetableDetailsBloc = context.read<TimetableDetailsBloc>();
    final addLessonBloc = context.read<AddLessonCubit>();
    final timetableId = timetableDetailsBloc.state.timetableDetails?.id;

    if (timetableId == null) return;

    await addLessonBloc.submitLesson(timetableId);
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
        onChanged: (description) =>
            context.read<AddLessonCubit>().addLessonDescriprion(description),
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
                .read<AddLessonCubit>()
                .addLessonTeacher(teacherSurname: surname),
          ),
          TextInputField(
              hintText: 'Имя',
              onChanged: (name) => context
                  .read<AddLessonCubit>()
                  .addLessonTeacher(teacherName: name)),
          TextInputField(
              hintText: 'Отчество',
              onChanged: (patro) => context
                  .read<AddLessonCubit>()
                  .addLessonTeacher(teacherParto: patro)),
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
    return BlocBuilder<AddLessonCubit, AddLessonState>(
      builder: (context, state) {
        return Column(
          children: [
            LessonScheduleFiled(
              onChanged: (lessonSchedule) => context
                  .read<AddLessonCubit>()
                  .addLessonSchedule(lessonSchedule),
              value: state.lessonSchedule,
            ),
            WeekdayPicker(
              onChanged: (dayOfWeek) =>
                  context.read<AddLessonCubit>().addLessonSchedule(
                        state.lessonSchedule.copyWith.dayOfWeek(dayOfWeek),
                      ),
              selectedDay: state.lessonSchedule.dayOfWeek,
            ),
          ],
        );
      },
    );
  }
}
