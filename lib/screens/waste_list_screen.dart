import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastegram/models/food_waste_post.dart';
import '../components/camera_fab.dart';
import '../models/date_formatter.dart';


// List view screen of all posts with date and counter
class WasteListScreen extends StatefulWidget {

  @override
  State<WasteListScreen> createState() => WasteListScreenState();
}

class WasteListScreenState extends State<WasteListScreen> {

  File? image;
  final picker_gallery = ImagePicker();
  final picker_camera = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const CameraFab(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var post = FoodWastePost.fromMap(snapshot.data!.docs[index].data());
                        return ListTile(
                            leading: Text(post.date),
                            title: Text('${post.quantity}'),
                            trailing: Image.network(post.photoURL),
                            onTap: () {
                              throw StateError('Example Error!');
                            },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
              );
            } else { // Database is empty
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }


  // TODO handle live photos
  Future getImage(sourceType) async {
    // TODO Add logic to handle user not allowing permission to access photos
    ImageSource source;

    if(sourceType == 'gallery'){
      source = ImageSource.gallery;
    } else{
      source = ImageSource.camera;
    }

    final pickedFile = await picker_gallery.pickImage(source: source);
    image = File(pickedFile!.path);

    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  void uploadData(source) async {
    final date = dateFormatter(DateTime.now());
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;


    if(source == 'get') {
      addToCollection(date.toString(), await getImage('gallery'), quantity, latitude, longitude);
    } else {
      addToCollection(date.toString(), await getImage('camera'), quantity, latitude, longitude);
    }
  }

  void addToCollection(date, url, quantity, latitude, longitude) {
    FirebaseFirestore.instance
        .collection('posts')
        .add({'date': date, 'photoURL': url, 'quantity': quantity, 'latitude': latitude, 'longitude': longitude});

  }


}