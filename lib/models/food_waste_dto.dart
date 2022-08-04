import 'package:location/location.dart';

import 'date_formatter.dart';

class WastedFoodDTO {
  LocationData? locationData;


  String date = dateFormatter(DateTime.now());
  int quantity = 1;
  double? latitude = 0.0;
  double? longitude = 0.0;
  String photoURL = '';

  @override
  String toString() {
    latitude = locationData?.latitude;
    longitude = locationData?.longitude;

    return 'date: $date, '
        'quantity: $quantity, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'photoURL: $photoURL';
  }
}