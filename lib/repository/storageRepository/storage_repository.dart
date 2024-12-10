import 'package:flutter/material.dart';

abstract class StorageRepository {
  Future fetchTourBooking(BuildContext context);
  Future fetchBusLayout(BuildContext context,String code);
}
