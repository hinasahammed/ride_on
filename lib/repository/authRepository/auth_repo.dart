import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ride_on/model/user/user.dart';
import 'package:ride_on/repository/authRepository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:ride_on/res/appUrl/app_url.dart';
import 'package:ride_on/res/utils/utils.dart';
import 'package:ride_on/view/customNavigation/custom_navigation_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userLogin = "userLogedin";

class AuthRepo implements AuthRepository {
  AuthRepo({required this.preferences});

  final SharedPreferences preferences;

  @override
  Future login(BuildContext context, User user) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.loginApi),
        headers: {"Content-Type": "application/json"},
        body: user.toJson(),
      );
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['ResponseCode'] == 200) {
        await preferences.setBool(userLogin, true);
        Utils().showToast("Login successfull");
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavigationView(),
              ));
        }
      } else {
        Utils().showToast("Invalid credential");
      }
    } on FormatException {
      Utils().showToast("Something Went Wrong!");
    } on SocketException {
      Utils().showToast("No Internet");
    } catch (e) {
      if (context.mounted) {
        Utils().showToast(e.toString());
      }
    }
  }

  @override
  bool getUserLogedin() {
    final val = preferences.getBool(userLogin) ?? false;
    return val;
  }
}
