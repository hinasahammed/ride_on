import 'dart:convert';
import 'dart:developer';

import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/storage_repository.dart';
import 'package:http/http.dart' as http;

const tourApi =
    "https://demotravels.api.deeprootcrm.com/api/Tour/tour_booking_list";

class ApiStorageRepo implements StorageRepository {
  @override
  Future fetchTourBooking() async {
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
        Uri.parse(tourApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      var res = jsonDecode(response.body);
      if (res['ResponseCode'] == 200) {
        var value = TourModel.fromJson(jsonDecode(response.body));
        return value;
      } else {
        return "Bad_state";
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
