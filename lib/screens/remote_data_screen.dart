import 'package:flutter/material.dart';

class RemoteDataScreen extends StatelessWidget {

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Latitude: LATITUDE', style: Theme.of(context).textTheme.headline5),
          Text('Longitude: LONGITUDE', style: Theme.of(context).textTheme.headline5),
          ElevatedButton(
              onPressed: () {

              },
              child: Text('Share')
          )
        ],
      ),
    );
  }
}