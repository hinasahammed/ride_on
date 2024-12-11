import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/storage_repository.dart';
import 'package:http/http.dart' as http;
import 'package:ride_on/res/appUrl/app_url.dart';
import 'package:ride_on/res/utils/utils.dart';

class ApiStorageRepo implements StorageRepository {
  @override
  Future fetchTourBooking(BuildContext context) async {
    try {
      var data = {
        "Layout": "",
        "Name": "",
        "FileNo": "",
        "StartDate": "",
        "EndDate": "",
        "BoardingPoint": ""
      };
      final response = await http.post(
        Uri.parse(AppUrl.tourApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      var res = jsonDecode(response.body);
      if (res['ResponseCode'] == 200) {
        var value = TourModel.fromJson(jsonDecode(response.body));
        return value;
      } else {
        return TourModel();
      }
    } on SocketException {
      if (context.mounted) {
        Utils().showToast(context, "No Internet");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future fetchBusLayout(BuildContext context, String code) async {
    var data = {"Code": code};
    try {
      final response = await http.post(
        Uri.parse(AppUrl.busLayoutApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      var res = jsonDecode(response.body);
      if (res['ResponseCode'] == 200) {
        var value = BusLayoutModel.fromJson(jsonDecode(response.body));
        return value;
      } else {
        return BusLayoutModel();
      }
    } on SocketException {
      if (context.mounted) {
        Utils().showToast(context, "No Internet");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
