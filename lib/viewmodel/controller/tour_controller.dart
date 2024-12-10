import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';

class TourController extends ChangeNotifier {
  TourController({required this.storageRepository});

  final ApiStorageRepo storageRepository;

  Future<TourModel?> fetchTourList(BuildContext context) async {
    var data = await storageRepository.fetchTourBooking(context);
    return data;
  }

  Future<BusLayoutModel?> fetchBusLAyout(BuildContext context,String code) async {
    var data = await storageRepository.fetchBusLayout(context, "30184");
    return data;
  }
}
