import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/add_timetable_cubit/add_timetable_cubit.dart';

class AddTimetableFormTemplate extends StatelessWidget {
  const AddTimetableFormTemplate({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.inputHintText,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String inputHintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 24),
            decoration: InputDecoration(hintText: inputHintText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 18))),
            onPressed: onSubmit,
            child: const Text('Готово'),
          ),
          const SizedBox(height: 30),
          BlocBuilder<AddTimetableCubit, AddTimetableState>(
            builder: (context, state) => Visibility(
              visible: state.isLoading,
              child: const CircularProgressIndicator.adaptive(),
            ),
          )
        ],
      ),
    );
  }
}
