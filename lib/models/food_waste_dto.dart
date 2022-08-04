import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'date_formatter.dart';

class WastedFoodDTO {

  LocationData? locationData;
  var locationService = Location();

  WastedFoodDTO() {
    retrieveLocation();
  }


  void retrieveLocation() async {
    try {
      var serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        print('requesting service');
        serviceEnabled = await locationService.requestService();
        print('requested service');
        if (!serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var permissionGranted = await locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
          return;
        }
      }

      locationData = await locationService.getLocation();

    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }

    locationData = await locationService.getLocation();
  }

  String date = dateFormatter(DateTime.now());
  int quantity = 1;
  String photoURL = '';
  late double? latitude = locationData?.latitude;
  late double? longitude = locationData?.longitude;

  @override
  String toString() {

    return 'date: $date, '
        'quantity: $quantity, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'photoURL: $photoURL';
  }
}