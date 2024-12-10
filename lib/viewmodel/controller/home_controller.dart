import 'package:flutter/material.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';

class HomeController extends ChangeNotifier {
  HomeController({required this.storageRepository});

  final ApiStorageRepo storageRepository;

  Future<TourModel?> fetchTourList(BuildContext context) async {
    var data = await storageRepository.fetchTourBooking(context);
    return data;
  }
}
