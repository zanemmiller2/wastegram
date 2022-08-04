
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/red_circular_progress_indicator.dart';
import '../models/food_waste_post.dart';

class RemoteDataBuilderScreen extends StatefulWidget {

  static final url = Uri.parse('https://console.firebase.google.com/project/wastegram-b9716/firestore/data/~2Fposts~2F3K8rH8ukboChvdfpWjNh');

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataBuilderScreen> {

  // TODO check status code and handle different status codes

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Widget child;
          if(snapshot.hasData) {
            var post = FoodWastePost.fromMap(snapshot.data!.docs[0].data());
            child = Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Date: ${post.date}', style: Theme.of(context).textTheme.headlineSmall,),
                    Text('Quantity: ${post.quantity}'),
                    Text('Latitude: ${post.latitude}'),
                    Text('Longitude: ${post.longitude}'),
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