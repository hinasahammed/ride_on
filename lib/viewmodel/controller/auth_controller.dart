import 'package:flutter/material.dart';
import 'package:ride_on/model/user.dart';
import 'package:ride_on/repository/authRepository/auth_repo.dart';

class AuthController {
  final repo = AuthRepo();

  Future login(
    BuildContext context,
    User user,
  ) async {
    await repo.login(context, user);
  }
}
