import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampToDateTime on Timestamp {
  static DateTime fromJson(Timestamp timestamp) => timestamp.toDate();
}
