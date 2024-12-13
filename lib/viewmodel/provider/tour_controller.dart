import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';

class TourViewmodel extends ChangeNotifier {
  TourViewmodel({required this.storageRepository});

  final ApiStorageRepo storageRepository;

  final List<Slot> _selectedSlot = [];
  List<Slot> get selectedSlot => _selectedSlot;

  final List<Datum?> _triplList = [];
  List<Datum?> get tripList => _triplList;

  Status _status = Status.completed;
  Status get status => _status;

  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  void selectSeat(Slot slot) {
    if (!_selectedSlot.contains(slot)) {
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
    var data = await storageRepository.fetchBusLayout(code);
    return data;
  }

  Future tripTesting() async {
    setStatus(Status.loading);
    try {
      await storageRepository.fetchTripTesting().then(
        (value) {
          if (value != null && value.data != null && value.data!.isNotEmpty) {
            _triplList.clear();
            for (var i in value.data!) {
              _triplList.add(i);
            }
          }
        },
      );
      notifyListeners();
      setStatus(Status.completed);
    } catch (e) {
      setStatus(Status.error);

      log(e.toString());
    }
  }
}
