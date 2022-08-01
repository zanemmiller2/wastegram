import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File? image;
  final picker = ImagePicker();

  void getImage() async {
    // TODO Add logic to handle user not allowing permission to access photos
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Center(
          child: ElevatedButton(
            onPressed: () {
              getImage();

            },
            child: Text('Select Photo'),
          )
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image!),
            SizedBox(height: 40,),
            ElevatedButton(
                onPressed: () {

                },
                child: Text('Post It!')
            )
          ],
        ),
      );
    }
  }
}
