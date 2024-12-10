import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ride_on/model/user/user.dart';
import 'package:ride_on/repository/authRepository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:ride_on/res/utils/utils.dart';
import 'package:ride_on/view/home/home_view.dart';

const loginApi = "https://demotravels.api.deeprootcrm.com/api/User/user_login";

class AuthRepo implements AuthRepository {
  @override
  Future login(BuildContext context, User user) async {
    try {
      final response = await http.post(
        Uri.parse(loginApi),
        headers: {"Content-Type": "application/json"},
        body: user.toJson(),
      );
      var data = jsonDecode(response.body);
      if (data['ResponseCode'] == 200) {
        if (context.mounted) {
          Utils().showToast(context, "Login successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ));
        }
      } else {
        if (context.mounted) {
          Utils().showToast(context, "Invalid credential");
        }
      }
    } catch (e) {
      if (context.mounted) {
        Utils().showToast(context, e.toString());
      }
    }
  }
}
