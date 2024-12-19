import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/bus_layout_model/data.dart';
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

  final List<Datum?> _filteredTripList = [];
  List<Datum?> get filteredTripList => _filteredTripList;

  Status _status = Status.completed;
  Status get status => _status;

  Data _buslayout = Data();
  Data get busLayout => _buslayout;

  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  void clearSelectedSeat() {
    _selectedSlot.clear();
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

  Future fetchBusLAyoutTesting(
    BuildContext context,
    String code,
  ) async {
    setStatus(Status.loading);
    var data = await storageRepository.fetchBusLayout(code);
    if (data != null && data.data != null) {
      _buslayout = data.data!;
    }
    setStatus(Status.completed);
    notifyListeners();
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

  void filterTrip(String searchText) {
    setStatus(Status.loading);
    var filtered = _triplList
        .where(
          (element) =>
              element!.name!.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    _filteredTripList.clear();
    _filteredTripList.addAll(filtered);

    setStatus(Status.completed);
    notifyListeners();
  }

  

  

  //on deprecation
  Future<TourModel?> fetchTourList(BuildContext context) async {
    var data = await storageRepository.fetchTourBooking();
    return data;
  }
  Future<BusLayoutModel?> fetchBusLAyout(
      BuildContext context, String code) async {
    var data = await storageRepository.fetchBusLayout(code);
    return data;
  }
}
