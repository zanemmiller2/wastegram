import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/red_circular_progress_indicator.dart';
import '../models/food_waste_post.dart';

class RemoteDataScreen extends StatefulWidget {

  static final url = Uri.parse('https://swapi.dev/api/people/1');

  const RemoteDataScreen({Key? key}) : super(key: key);

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataScreen> {
  FoodWastePost? foodWastePost;

  @override
  void initState() {
    super.initState();
    retrieveCharacterData();
  }

  Future<void> retrieveCharacterData() async {
    final http.Response apiResponse = await http.get(RemoteDataScreen.url);
    print(apiResponse.body);
    foodWastePost = FoodWastePost.fromMap(
        jsonDecode(apiResponse.body)
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(foodWastePost == null) {
      return Center(child: RedCircularProgressIndicator());
    } else {
      return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(foodWastePost!.date.toString(), style: Theme.of(context).textTheme.headlineSmall,),
              Text('${foodWastePost!.quantity}'),
              Text('${foodWastePost!.longitude}'),
              Text('${foodWastePost!.latitude}'),
            ],
        ));
      }
    }
}