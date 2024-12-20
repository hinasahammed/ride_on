import 'package:ride_on/model/bus_layout_model/bus_layout_model.dart';
import 'package:ride_on/model/tour_model/tour_model.dart';

abstract class StorageRepository {
  Future<TourModel?> fetchTrips();
  Future<BusLayoutModel?> fetchBusLayout(String code);
}
