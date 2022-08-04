import 'package:flutter/material.dart';
import 'package:wastegram/components/wasted_food_form.dart';
import 'package:wastegram/screens/waste_list_screen.dart';

class CameraFab extends StatelessWidget {

  const CameraFab({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    WasteListScreenState wasteListScreen = WasteListScreenState();

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                var photoURL = await wasteListScreen.getImage('gallery');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return WastedFoodForm(url: photoURL);
                }));
              },
              child: const Icon(Icons.add_photo_alternate_outlined)
          ),
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                var photoURL = wasteListScreen.getImage('camera');
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return WastedFoodForm(url: photoURL);
                    }));
              },
              child: const Icon(Icons.add_a_photo_outlined)
          ),
        ],
    );
  }
}
