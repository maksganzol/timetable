import 'package:timetable/models/user_profile.dart';

abstract class UserProfileRepository{
  Future<UserProfile> getUserProfile();
}