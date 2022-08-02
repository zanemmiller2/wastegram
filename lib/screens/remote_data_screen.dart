import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/character.dart';

class RemoteDataScreen extends StatefulWidget {

  static final url = Uri.parse('https://swapi.dev/api/people/1');

  const RemoteDataScreen({Key? key}) : super(key: key);

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataScreen> {
  Character? character;

  @override
  void initState() {
    super.initState();
    retrieveCharacter();
  }

  Future<void> retrieveCharacter() async {
    final http.Response apiResponse = await http.get(RemoteDataScreen.url);
    print(apiResponse.body);
    character = Character.fromJSON(jsonDecode(apiResponse.body));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(character == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(child: Text(character!.name));
    }
  }
}