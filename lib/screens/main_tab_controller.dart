import 'package:flutter/material.dart';
import 'package:wastegram/screens/remote_data_screen.dart';
import 'package:wastegram/screens/share_location_screen.dart';

import 'camera_screen.dart';


class MainTabController extends StatelessWidget {

  static const tabs = [
    Tab(icon: Icon(Icons.location_pin)),
    Tab(icon: Icon(Icons.cloud_download)),
    Tab(icon: Icon(Icons.camera_alt))
  ];

  final screens = [
    ShareLocationScreen(),
    RemoteDataScreen(),
    CameraScreen()
  ];

  MainTabController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
                'Wastegram',
            ),
            bottom: const TabBar(tabs: tabs),
        ),
          body: TabBarView(
            children: screens,
          ),
        )
    );
  }
}