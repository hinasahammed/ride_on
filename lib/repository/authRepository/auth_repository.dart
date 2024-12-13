import 'package:flutter/material.dart';
import 'package:ride_on/model/user/user.dart';

abstract class AuthRepository {
  Future login(BuildContext context, User user);
  bool getUserLogedin();
}
