import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable/dependency_injector/dependency_injector.dart';

abstract class FirebaseFirestoreService {
  @protected
  final FirebaseFirestore firebaseFirestore = DI.locator<FirebaseFirestore>();
}