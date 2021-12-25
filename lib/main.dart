import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timetable/app.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DI.inject();

  runApp(const App());
}
