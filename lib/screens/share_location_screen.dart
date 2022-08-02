import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../components/red_circular_progress_indicator.dart';

class ShareLocationScreen extends StatefulWidget {

  static const routeName = "/";

  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  LocationData? locationData;
  var locationService = Location();


  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        print('requesting service');
        _serviceEnabled = await locationService.requestService();
        print('requested service');
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return Center(child: RedCircularProgressIndicator());
    } else {
      return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Latitude: ${locationData!.latitude}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall),
                Text('Longitude:  ${locationData!.longitude}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall),
                ElevatedButton(
                  child: Text('Share'),
                  onPressed: () {
                    Share.share('Hey! Meet me at ${locationData!.latitude}, ${locationData!.longitude}');
                  },
                )
              ],
            )),
      );
    }
  }
}

