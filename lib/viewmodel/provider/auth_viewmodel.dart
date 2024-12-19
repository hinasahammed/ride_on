import 'package:flutter/material.dart';
import 'package:ride_on/model/user/user.dart';
import 'package:ride_on/repository/authRepository/auth_repo.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthViewmodel({required this.authRepo});

  bool _isloading = false;
  bool get isLoading => _isloading;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  bool getUserLogin() {
    var val = authRepo.getUserLogedin();
    return val;
  }

  Future login(
    BuildContext context,
    User user,
  ) async {
    setLoading(true);
    await authRepo.login(context, user);
    setLoading(false);
  }
}
