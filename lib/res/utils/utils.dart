import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_on/res/components/booking_success_dailog.dart';

class Utils {
  void showToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  void showBookinSuccess(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: BookingSuccessDailog(),
      ),
    );
  }
}
