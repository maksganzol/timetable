import 'package:timetable/models/user_profile.dart';

abstract class UserProfileRepository{
  Future<UserProfile> getUserProfile();
  Future<void> addTimetableByCode(String code);
  Future<void> removeTimetable(String timetableId);
}