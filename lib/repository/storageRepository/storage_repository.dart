
import 'package:ride_on/model/tour_model/tour_model.dart';

abstract class StorageRepository {
  Future fetchTourBooking();
  Future<TourModel?> fetchTripTesting();
  Future fetchBusLayout(String code);
}
