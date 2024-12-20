import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/model/bus_layout_model/data.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/repository/storageRepository/storage_repository.dart';

class SeatLayoutViewmodel extends ChangeNotifier {
  SeatLayoutViewmodel({required this.storageRepository});

  final StorageRepository storageRepository;

  final List<Slot> _selectedSlot = [];
  List<Slot> get selectedSlot => _selectedSlot;

  Data _buslayout = Data();
  Data get busLayout => _buslayout;

  Status _status = Status.completed;
  Status get status => _status;

  // set status of operation
  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  // clear selected seat
  void clearSelectedSeat() {
    _selectedSlot.clear();
    notifyListeners();
  }

  // select seat
  void selectSeat(Slot slot) {
    if (!_selectedSlot.contains(slot)) {
      _selectedSlot.add(slot);
    } else {
      _selectedSlot.remove(slot);
    }
    notifyListeners();
  }

  // fetch bus layout
  Future fetchBusLayout(
    BuildContext context,
    String code,
  ) async {
    setStatus(Status.loading);
    try {
      var data = await storageRepository.fetchBusLayout(code);
      if (data != null && data.data != null) {
        _buslayout = data.data!;
      }
      setStatus(Status.completed);
    } catch (e) {
      setStatus(Status.error);
      log(e.toString());
    }

    notifyListeners();
  }
}
