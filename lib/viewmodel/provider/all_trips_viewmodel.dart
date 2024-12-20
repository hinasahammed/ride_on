import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/repository/storageRepository/storage_repository.dart';

class AllTripsViewmodel extends ChangeNotifier {
  AllTripsViewmodel({required this.storageRepository});

  final StorageRepository storageRepository;

  final List<Datum?> _triplList = [];
  List<Datum?> get tripList => _triplList;

  final List<Datum?> _filteredTripList = [];
  List<Datum?> get filteredTripList => _filteredTripList;

  Status _status = Status.completed;
  Status get status => _status;

  // set status of operation
  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  // fetch all trips
  Future fetchAllTrips() async {
    setStatus(Status.loading);
    try {
      await storageRepository.fetchTrips().then(
        (value) {
          if (value != null && value.data != null && value.data!.isNotEmpty) {
            _triplList.clear();
            for (var i in value.data!) {
              _triplList.add(i);
            }
          }
        },
      );
      setStatus(Status.completed);
    } catch (e) {
      setStatus(Status.error);
      log(e.toString());
    }
    notifyListeners();
  }

  // filter trips
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
}
