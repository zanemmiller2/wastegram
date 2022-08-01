
import 'package:flutter/material.dart';
import 'package:wastegram/screens/main_tab_controller.dart';
import 'package:wastegram/screens/share_location_screen.dart';

class App extends StatefulWidget {

  const App({Key? key}) : super(key: key);

  static final routes = {
    ShareLocationScreen.routeName: (context) => ShareLocationScreen(),
  };

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastegram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainTabController(),
    );
  }
}