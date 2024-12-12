import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';

class TourController extends ChangeNotifier {
  TourController({required this.storageRepository});

  final ApiStorageRepo storageRepository;

  final List<Slot> _selectedSlot = [];
  List<Slot> get selectedSlot => _selectedSlot;

  void selectSeat(Slot slot) {
    if (!_selectedSlot.contains(slot)) {
      log("Adding");
      _selectedSlot.add(slot);
    } else {
      _selectedSlot.remove(slot);
    }
    notifyListeners();
  }

  Future<TourModel?> fetchTourList(BuildContext context) async {
    var data = await storageRepository.fetchTourBooking();
    return data;
  }

  Future<BusLayoutModel?> fetchBusLAyout(
      BuildContext context, String code) async {
    var data = await storageRepository.fetchBusLayout("30184");
    return data;
  }
}
