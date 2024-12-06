import 'package:ride_on/model/tour_model/tour_model.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';

class HomeController {
  final repo = ApiStorageRepo();
  Future<TourModel> fetchTourList() async {
    var data = await repo.fetchTourBooking();
    return data;
  }
}
