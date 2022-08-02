
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/red_circular_progress_indicator.dart';
import '../models/character.dart';

class RemoteDataBuilderScreen extends StatefulWidget {

  static final url = Uri.parse('https://swapi.dev/api/people/3');

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataBuilderScreen> {

  // TODO check status code and handle different status codes
  Future<http.Response> apiResponse = http.get(RemoteDataBuilderScreen.url);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiResponse,
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          Widget child;
          if(snapshot.hasData) {
            Character character = Character.fromJSON(jsonDecode(snapshot.data!.body));
            child = Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(character.name, style: Theme.of(context).textTheme.headlineSmall,),
                    Text(character.gender.toUpperCase()),
                    Text(character.height.toString()),
                  ],
                ));
          } else {
            child = RedCircularProgressIndicator();
          }
          return Center(child: child);
        }
    );
  }
}