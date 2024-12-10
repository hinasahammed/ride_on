import 'package:flutter/material.dart';
import 'package:ride_on/model/user/user.dart';
import 'package:ride_on/repository/authRepository/auth_repo.dart';

class AuthController extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isLoading => _isloading;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
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
