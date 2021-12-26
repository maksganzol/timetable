import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/blocs/timetable_bloc/timetable_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TimetableBloc>().add(const TimetableLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои рассписания'),
      ),
      body: Center(child: BlocBuilder<TimetableBloc, TimetableState>(
        builder: (context, state) {
          return Column(
            children: state.timetables
                .map((e) => Text(e.title))
                .toList(growable: false),
          );
        },
      )),
    );
  }
}
