import 'package:flutter/material.dart';
import 'package:wastegram/models/food_waste_post.dart';

// Single page post view with full detail
class WasteDetailScreen extends StatelessWidget {
  final FoodWastePost post;

  const WasteDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WasteGram')),
      body: layout()
    );
  }

  Widget layout() {
    return Column(
      children: const [
        Text('TODO'),
        SizedBox(height: 20),
        Placeholder()
      ],
    );
  }
}