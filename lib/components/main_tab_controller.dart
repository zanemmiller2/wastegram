import 'package:flutter/material.dart';
import 'package:wastegram/unused/share_location_screen.dart';

import '../screens/waste_list_screen.dart';


class MainTabController extends StatelessWidget {

  static const tabs = [
    Tab(icon: Icon(Icons.location_pin)),
    Tab(icon: Icon(Icons.camera_alt))
  ];

  final screens = [
    ShareLocationScreen(),
    WasteListScreen()
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